use rand::distributions::Distribution;
use rand::distributions::Uniform;
use std::thread;
use std::time::Duration;

fn main() {
    let mut rng = rand::thread_rng();
    let gen = Uniform::from(0..=9);
    loop {
        print!("[1;32m");
        for _ in 0..80 {
            print!("{}", gen.sample(&mut rng));
        }
        println!("[m");
        thread::sleep(Duration::from_millis(25));
    }
}
