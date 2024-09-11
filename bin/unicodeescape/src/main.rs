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
        if c < 0x10000 {
            dst.push_str(&*format!("\\u{:04x}", c));
        } else {
            dst.push_str(&*format!("\\u{:04x}\\u{:04x}", (c - 0x10000) / 0x0400 + 0xd800, (c - 0x10000) % 0x0400 + 0xdc00));
        }
    }
    dst
}
