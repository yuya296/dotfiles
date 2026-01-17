# ~/.zshrc
# Interactive shell: source split config files.

ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
zsh_config_files=(
  "00-options.zsh"
  "10-keybinds.zsh"
  "20-aliases.zsh"
  "30-tools.zsh"
  "40-completion.zsh"
  "50-zinit.zsh"
  "60-prompt.zsh"
  "90-local.zsh"
)

for zsh_config_file in "${zsh_config_files[@]}"; do
  if [[ -f "${ZSH_CONFIG_DIR}/${zsh_config_file}" ]]; then
    source "${ZSH_CONFIG_DIR}/${zsh_config_file}"
  fi
done
