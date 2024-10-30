{ config, inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
    inputs.neovim-nightly-overlay.overlays.default
  ];
}
