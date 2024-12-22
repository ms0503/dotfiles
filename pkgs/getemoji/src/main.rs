use serde::Deserialize;
use serde::Serialize;
use std::env;
use std::process;
use tokio::fs;
use tokio::task::JoinHandle;

#[tokio::main]
async fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("must be specified emojis' name");
        process::exit(1);
    }
    let emojis = {
        let args = args.to_owned();
        let emojis = &args[1..];
        emojis.to_owned()
    };
    let mut pool: Vec<JoinHandle<()>> = vec![];
    for emoji in emojis {
        pool.push(tokio::spawn(async move {
            let emoji = emoji.clone();
            download_emoji(&emoji).await
        }));
    }
    for handle in pool {
        let _ = handle.await;
    }
}

#[derive(Debug, Deserialize, Serialize)]
struct EmojiData {
    pub icon: IconData,
}

#[derive(Debug, Deserialize, Serialize)]
struct IconData {
    #[serde(rename = "mediaType")]
    pub media_type: String,
    pub url: String,
}

fn get_suffix(mime_type: &str) -> &str {
    match mime_type {
        "image/avif" => "avif",
        "image/gif" => "gif",
        "image/jpeg" => "jpg",
        "image/png" => "png",
        "image/webp" => "webp",
        _ => unreachable!(),
    }
}

async fn get_emoji_data(name: &str) -> Result<EmojiData, Box<dyn std::error::Error>> {
    let res = reqwest::get(format!("https://misskey.io/emojis/{}", name))
        .await?
        .json::<EmojiData>()
        .await?;
    Ok(res)
}

async fn download_emoji(name: &str) {
    let emoji = get_emoji_data(name).await;
    if let Err(_) = emoji {
        eprintln!(":{}: : failed to get metadata", name);
        return;
    }
    let emoji = emoji.unwrap();
    let data = reqwest::get(emoji.icon.url).await;
    if let Err(_) = data {
        eprintln!(":{}: : failed to get emoji", name);
        return;
    }
    let data = data.unwrap().bytes().await;
    if let Err(_) = data {
        eprintln!(":{}: : failed to get emoji", name);
        return;
    }
    let data = data.unwrap();
    match fs::write(
        format!("{}.{}", name, get_suffix(&emoji.icon.media_type)),
        data,
    )
    .await
    {
        Err(_) => eprintln!(":{}: : failed to write image file", name),
        Ok(_) => println!(":{}: : success!", name),
    }
}
