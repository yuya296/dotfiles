{ ... }:
{
  home.homeDirectory = "/Users/yuya";
  home.sessionVariables.BROWSER = "open";

  xdg.configFile."karabiner/karabiner.json".source =
    ../config/karabiner/karabiner.json;
}
