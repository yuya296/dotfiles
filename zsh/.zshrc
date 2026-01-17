# ~/.zshrc
# Interactive shell: source split config files.

ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
for zsh_config_file in "${ZSH_CONFIG_DIR}"/*.zsh(N); do
  source "${zsh_config_file}"
done
