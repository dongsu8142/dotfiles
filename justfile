default:
  @just --list

deploy SYSTEM:
  sudo nixos-rebuild switch --flake .#{{SYSTEM}}

update:
  nix flake update

commit MESSAGE:
  git add .
  git commit -m "{{MESSAGE}}"
  git push

check:
  nix flake check

show:
  nix flake show

build SYSTEM:
  nixos-rebuild build --flake .#{{SYSTEM}}
