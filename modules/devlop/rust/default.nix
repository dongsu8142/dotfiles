{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      (rust-bin.selectLatestNightlyWith( toolchain: toolchain.default.override {
        extensions= [ "rust-src" "rust-analyzer" "rustfmt" "clippy"  ];
        targets = [ "wasm32-unknown-unknown" "x86_64-unknown-linux-gnu" ];
      }))
      cargo-watch
    ];
  };
}
