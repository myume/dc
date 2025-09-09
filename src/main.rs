use std::{env, io, process::exit};

use clap::Parser;

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Args {
    subdir: String,
}

fn main() -> io::Result<()> {
    let args = Args::parse();

    let cwd = env::current_dir()?;

    let parts: Vec<_> = cwd
        .to_str()
        .expect("cwd should be valid")
        .split('/')
        .filter(|&part| part != "")
        .collect();

    let matching_subdir = parts.iter().position(|&part| part == args.subdir);

    match matching_subdir {
        Some(matching_index) => {
            let target_path = format!("/{}", parts[..matching_index + 1].join("/"));
            println!("{}", target_path);
        }
        None => {
            eprintln!("No segment in path named: {}", args.subdir);
            eprintln!("cwd is {}", cwd.display());
            exit(1);
        }
    };

    Ok(())
}
