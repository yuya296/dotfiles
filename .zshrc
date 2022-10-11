export PATH=/opt/homebrew/bin:$PATH

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# =====================================================

# zplug

#export ZPLUG_HOME=/usr/local/opt/zplug
#source $ZPLUG_HOME/init.zsh

# 使いたいzshのプラグインを以下に入れていく
#zplug "zsh-users/zsh-autosuggestions"
#zplug "zsh-users/zsh-syntax-highlighting"
#zplug "zsh-users/zsh-completions"

#if ! zplug check --verbose; then
#  printf 'Install? [y/N]: '
#  if read -q; then
#    echo; zplug install
#  fi
#fi
#zplug load --verbose

# =====================================================

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# テーマ
source ~/.zsh/zsh-dircolors-nord/zsh-dircolors-nord.zsh

# Customize to your needs...

#
# PECOの設定 ==========================================
#
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

#
# MacVim (mvim) の設定
#
# alias vim=mvim


#
# その他のエイリアス
#
alias gd="cd ~/Google\ Drive"

# prezto
#lsコマンドの色を変更
#
export LSCOLORS=gxfxcxdxbxegedabagacad

# todo.sh
alias todo="todo.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
