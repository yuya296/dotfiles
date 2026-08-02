{ lib, ... }:
{
  home.username = lib.mkForce "ubuntu";
  home.homeDirectory = lib.mkForce "/home/ubuntu";
}
