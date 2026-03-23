# History search (peco)
peco-select-history() {
  local tac
  if command -v tac >/dev/null 2>&1; then
    tac="tac"
  else
    tac="tail -r"
  fi

  BUFFER=$(history -n 1 | eval "$tac" | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^R' peco-select-history

setopt APPEND_HISTORY           # 履歴を上書きでなく追記
setopt EXTENDED_HISTORY         # 実行時刻と所要時間を保存
setopt HIST_EXPIRE_DUPS_FIRST   # 件数超過時は重複から先に削除
setopt HIST_FIND_NO_DUPS        # 履歴検索で重複を飛ばす
setopt HIST_IGNORE_DUPS         # 直前と同じコマンドは記録しない
setopt HIST_IGNORE_ALL_DUPS     # 古い重複履歴を削除
setopt HIST_IGNORE_SPACE        # 先頭スペース付きコマンドは記録しない
setopt HIST_REDUCE_BLANKS       # 余分な空白を詰めて保存
setopt HIST_SAVE_NO_DUPS        # 保存時に重複を落とす
setopt HIST_VERIFY              # !展開を即実行せず確認
setopt INC_APPEND_HISTORY       # 実行ごとに即時履歴ファイルへ追記
setopt SHARE_HISTORY            # セッション間で履歴共有
