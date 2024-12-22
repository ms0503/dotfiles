use std::char;
use std::env;
use std::process;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Error: string not specified.");
        process::exit(1);
    }
    let src = args[1].to_owned();
    println!("{}", escape(src));
}

fn escape(src: String) -> String {
    let mut dst = String::new();
    for c in src.chars() {
        let c = c as u32;
        match c {
            0x20..=0x7e => match c {
                0x21 | 0x23 | 0x3a | 0x3d | 0x5c => {
                    dst.push_str(&format!("\\{}", char::from_u32(c).unwrap()))
                }
                _ => dst.push(char::from_u32(c).unwrap()),
            },
            0x10000.. => dst.push_str(&format!(
                "\\u{:04x}\\u{:04x}",
                (c - 0x10000) / 0x0400 + 0xd800,
                (c - 0x10000) % 0x0400 + 0xdc00
            )),
            _ => dst.push_str(&format!("\\u{:04x}", c)),
        }
    }
    dst
}
