{ ... }:
{
  home.homeDirectory = "/Users/yuya";

  xdg.configFile."karabiner/karabiner.json".source =
    ../../dot_config/private_karabiner/private_karabiner.json;
}
