use std::env;

fn main() {
    let mut opts = Opts::default();
    let mut stop_option = false;
    for arg in env::args().skip(1) {
        match &*arg {
            "--" => {
                if stop_option {
                    opts.src.push_str(" --");
                } else {
                    stop_option = true;
                }
            }
            "-d" => {
                if stop_option {
                    opts.src.push_str(" -d");
                } else {
                    opts.decode = true;
                }
            }
            _ => {
                if !stop_option {
                    stop_option = true;
                }
                opts.src.push_str(&arg);
            }
        }
    }
    if opts.decode {
        println!("{}", decode(opts.src));
    } else {
        println!("{}", encode(opts.src));
    }
}

#[derive(Clone, Debug, Default, Eq, Ord, PartialEq, PartialOrd)]
struct Opts {
    pub decode: bool,
    pub src: String,
}

fn encode(src: String) -> String {
    let mut dst = String::new();
    for c in src.chars() {
        let c = c as u32;
        if c < 0x80 {
            if c < 0x24
                || c == 0x3c
                || c == 0x3e
                || c == 0x60
                || c == 0x7b
                || c == 0x7d
                || c == 0x7f
            {
                dst.push_str(&format!("%{:02X}", c));
            } else if c == 0x20 {
                dst.push('+');
            } else {
                dst.push(char::from_u32(c).unwrap());
            }
        } else if c < 0x800 {
            let fst = 0xc0 | c >> 6;
            let snd = 0x80 | c & 0x3f;
            dst.push_str(&format!("%{:02X}%{:02X}", fst, snd));
        } else if c < 0x10000 {
            let fst = 0xe0 | c >> 12;
            let snd = 0x80 | c >> 6 & 0x3f;
            let trd = 0x80 | c & 0x3f;
            dst.push_str(&format!("%{:02X}%{:02X}%{:02X}", fst, snd, trd));
        } else if c < 0x110000 {
            let fst = 0xf0 | c >> 18;
            let snd = 0x80 | c >> 12 & 0x3f;
            let trd = 0x80 | c >> 6 & 0x3f;
            let frt = 0x80 | c & 0x3f;
            dst.push_str(&format!("%{:02X}%{:02X}%{:02X}%{:02X}", fst, snd, trd, frt));
        } else {
            unreachable!();
        }
    }
    dst
}

fn decode(src: String) -> String {
    let mut dst = String::new();
    let mut is_encoded = false;
    let mut num_buf = vec![0u8; 2];
    let mut num_ind = 0usize;
    let mut char_buf = vec![0u8; 4];
    let mut char_ind = 0usize;
    let mut char_len = 0usize;
    for c in src.chars() {
        println!("c: {:?}\ndst: {:?}\nis_encoded: {:?}\nnum_buf: {:?}\nnum_ind: {:?}\nchar_buf: {:?}\nchar_ind: {:?}\nchar_len: {:?}\n", &c, &dst, &is_encoded, &num_buf, &num_ind, &char_buf, &char_ind, &char_len);
        if c == '%' {
            is_encoded = true;
            continue;
        }
        if is_encoded {
            if num_ind == 1 {
                num_buf[num_ind] = c as u8;
                num_ind = 0;
                let num = u8::from_str_radix(
                    &String::from_utf8(num_buf.clone()).expect("Error: unexpected token."),
                    16,
                )
                .expect("Error: unexpected token.");
                println!("num: {:?}", &num);
                char_buf[char_ind] = num;
                if char_ind == 0 {
                    char_len = if num < 0x80 {
                        1
                    } else if num < 0xe0 {
                        2
                    } else if num < 0xf0 {
                        3
                    } else if num < 0xf4 {
                        4
                    } else {
                        unreachable!()
                    };
                }
                char_ind += 1;
                if char_ind == char_len {
                    dst.push_str(
                        &String::from_utf8(char_buf.clone()[0..char_len].to_vec())
                            .expect("Error: invalid utf8 sequence."),
                    );
                    char_ind = 0;
                    char_len = 0;
                }
                is_encoded = false;
            } else {
                num_buf[num_ind] = c as u8;
                num_ind += 1;
            }
        } else if c == '+' {
            dst.push(' ');
        } else {
            dst.push(c);
        }
    }
    dst
}
