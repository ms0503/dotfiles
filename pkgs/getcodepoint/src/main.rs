use std::io;

fn main() {
    loop {
        let mut buf = String::new();
        if let Ok(n) = io::stdin().read_line(&mut buf) {
            if n == 0 {
                break;
            }
            for (i, c) in buf.chars().enumerate() {
                if i == buf.chars().count() - 1 {
                    break;
                }
                println!("{} : U+{:06X}", c, c as u32);
            }
        }
    }
}
