{ lib, pkgs, ... }:
{
  home.username = lib.mkForce "ubuntu";
  home.homeDirectory = lib.mkForce "/home/ubuntu";

  home.packages = [
    pkgs.bubblewrap
    pkgs.tmux
  ];
}
