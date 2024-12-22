use std::env;
use std::process;

const MSG_HELP: &str = "\
Usage: colortool <subcommand> [args...]

A simple color helper.

SUBCOMMANDS:
    hsl2rgb  convert HSL to RGB. args are H, S and L.
    rgb2hsl  convert RGB to HSL. args are R, G and B.

ARGS:
    -h      display this help.
    --help\
";

const MSG_HELP_HSL2RGB: &str = "\
Usage: colortool hsl2rgb <H> <S> <L> [args...]

Convert HSL to RGB.

ARGS:
    <H>     Hue value [deg]
    <S>     Saturation value [%]
    <L>     Lightness value [%]
    -h      display this help.
    --help\
";

const MSG_HELP_RGB2HSL: &str = "\
Usage: colortool rgb2hsl <R> <G> <B> [args...]

Convert RGB to HSL.

ARGS:
    <R>     Red value [hex]
    <G>     Green value [hex]
    <B>     Blue value [hex]
    -h      display this help.
    --help\
";

fn main() {
    let mut opts = Opts::default();
    for arg in env::args().skip(1) {
        match &*arg {
            "-h" | "--help" => opts.help = true,
            "hsl2rgb" => opts.cmd = Some(Cmd::Hsl2Rgb),
            "rgb2hsl" => opts.cmd = Some(Cmd::Rgb2Hsl),
            _ => opts.args.push(arg),
        }
    }
    let opts = opts;
    match opts.cmd {
        Some(Cmd::Hsl2Rgb) => {
            if opts.help {
                println!("{}", MSG_HELP_HSL2RGB);
            } else if opts.args.len() != 3 {
                eprintln!("Error: invalid argument length");
                process::exit(1);
            } else {
                let h = opts.args[0].parse::<i16>();
                if let Err(_) = h {
                    eprintln!("Error: {} is invalid degree.", opts.args[0]);
                    process::exit(1);
                }
                let h = h.unwrap();
                let s = opts.args[1].parse::<u8>();
                if let Err(_) = s {
                    eprintln!("Error: {} is invalid percentage.", opts.args[1]);
                    process::exit(1);
                }
                let s = s.unwrap();
                let l = opts.args[2].parse::<u8>();
                if let Err(_) = l {
                    eprintln!("Error: {} is invalid percentage.", opts.args[2]);
                    process::exit(1);
                }
                let l = l.unwrap();
                let rgb = hsl2rgb(Hsl { h, s, l });
                println!("#{:02x}{:02x}{:02x}", rgb.r, rgb.g, rgb.b);
            }
        }
        Some(Cmd::Rgb2Hsl) => {
            if opts.help {
                println!("{}", MSG_HELP_RGB2HSL);
            } else if opts.args.len() != 3 {
                eprintln!("Error: invalid argument length");
                process::exit(1);
            } else {
                let r = u8::from_str_radix(&opts.args[0], 16);
                if let Err(_) = r {
                    eprintln!("Error: {} is invalid color hex.", opts.args[0]);
                    process::exit(1);
                }
                let r = r.unwrap();
                let g = u8::from_str_radix(&opts.args[1], 16);
                if let Err(_) = g {
                    eprintln!("Error: {} is invalid color hex.", opts.args[1]);
                    process::exit(1);
                }
                let g = g.unwrap();
                let b = u8::from_str_radix(&opts.args[2], 16);
                if let Err(_) = b {
                    eprintln!("Error: {} is invalid color hex.", opts.args[2]);
                    process::exit(1);
                }
                let b = b.unwrap();
                let hsl = rgb2hsl(Rgb { r, g, b });
                println!("hsl({}deg, {}%, {}%)", hsl.h, hsl.s, hsl.l);
            }
        }
        None => {
            println!("{}", MSG_HELP);
        }
    }
}

fn hsl2rgb(hsl: Hsl) -> Rgb {
    let max = if hsl.l < 50u8 {
        2.55f32 * (hsl.l as f32 + hsl.l as f32 * (hsl.s as f32 / 100f32))
    } else {
        2.55f32 * (hsl.l as f32 + (100u8 - hsl.l) as f32 * (hsl.s as f32 / 100f32))
    };
    let min = if hsl.l < 50u8 {
        2.55f32 * (hsl.l as f32 - hsl.l as f32 * (hsl.s as f32 / 100f32))
    } else {
        2.55f32 * (hsl.l as f32 - (100u8 - hsl.l) as f32 * (hsl.s as f32 / 100f32))
    };
    return match hsl.h {
        0..60 => Rgb {
            r: max as u8,
            g: ((hsl.h as f32 / 60f32) * (max - min) + min) as u8,
            b: min as u8,
        },
        60..120 => Rgb {
            r: (((120i16 - hsl.h) as f32 / 60f32) * (max - min) + min) as u8,
            g: max as u8,
            b: min as u8,
        },
        120..180 => Rgb {
            r: min as u8,
            g: max as u8,
            b: (((hsl.h - 120i16) as f32 / 60f32) * (max - min) + min) as u8,
        },
        180..240 => Rgb {
            r: min as u8,
            g: (((240i16 - hsl.h) as f32 / 60f32) * (max - min) + min) as u8,
            b: max as u8,
        },
        240..300 => Rgb {
            r: (((hsl.h - 240i16) as f32 / 60f32) * (max - min) + min) as u8,
            g: min as u8,
            b: max as u8,
        },
        300..360 => Rgb {
            r: max as u8,
            g: min as u8,
            b: (((360i16 - hsl.h) as f32 / 60f32) * (max - min) + min) as u8,
        },
        _ => unreachable!(),
    };
}

fn rgb2hsl(rgb: Rgb) -> Hsl {
    let max = rgb.r.max(rgb.g.max(rgb.b));
    let min = rgb.r.min(rgb.g.min(rgb.b));
    return Hsl {
        h: if max == min {
            0i16
        } else {
            let mut h = match max {
                _ if max == rgb.r => (60f32 * (rgb.g - rgb.b) as f32 / (max - min) as f32) as i16,
                _ if max == rgb.g => {
                    (60f32 * (rgb.b - rgb.r) as f32 / (max - min) as f32 + 120f32) as i16
                }
                _ if max == rgb.b => {
                    (60f32 * (rgb.r - rgb.g) as f32 / (max - min) as f32 + 240f32) as i16
                }
                _ => unreachable!(),
            };
            if h < 0i16 {
                h += 360i16;
            }
            h
        },
        s: if (((max + min) as f32 / 2f32) as u8) < 128u8 {
            ((max - min) as f32 / (max + min) as f32 * 100f32) as u8
        } else {
            ((max - min) as f32 / (510u16 - max as u16 - min as u16) as f32 * 100f32) as u8
        },
        l: ((max + min) as f32 / 2f32 / 255f32 * 100f32) as u8,
    };
}

#[derive(Clone, Copy, Debug, Eq, Ord, PartialEq, PartialOrd)]
enum Cmd {
    Hsl2Rgb,
    Rgb2Hsl,
}

#[derive(Clone, Debug, Default, Eq, Ord, PartialEq, PartialOrd)]
struct Opts {
    pub cmd: Option<Cmd>,
    pub help: bool,
    pub args: Vec<String>,
}

#[derive(Clone, Copy, Debug, Default, Eq, Ord, PartialEq, PartialOrd)]
struct Rgb {
    pub r: u8,
    pub g: u8,
    pub b: u8,
}

#[derive(Clone, Copy, Debug, Default, Eq, Ord, PartialEq, PartialOrd)]
struct Hsl {
    pub h: i16,
    pub s: u8,
    pub l: u8,
}
