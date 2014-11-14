rust:
  cmd.run:
    - name:  curl -s https://static.rust-lang.org/rustup.sh | sudo sh
    - unless: which rustc
