require("config.lazy")
vim.cmd("syntax on")

vim.o.number = true             -- 行番号
vim.o.cursorline = true         -- カーソル行を強調
vim.o.wrap = false              -- 文字の折り返しを無効（コード向け）
vim.o.scrolloff = 8             -- スクロール時に上下の余白を残す
vim.o.termguicolors = true      -- True Color

vim.o.expandtab = true          -- Tabをスペースに
vim.o.shiftwidth = 2            -- インデント幅
vim.o.tabstop = 2               -- Tab表示幅
vim.o.smartindent = true

vim.o.ignorecase = true         -- 小文字検索で大文字小文字無視
vim.o.smartcase = true          -- 大文字含むと区別
vim.o.hlsearch = true           -- 検索結果ハイライト
vim.o.incsearch = true          -- インクリメンタル検索

vim.o.clipboard = "unnamedplus" -- OSクリップボード共有
vim.o.undofile = true           -- 永続Undo

vim.o.signcolumn = "yes"        -- 左カラムを常に確保
vim.o.updatetime = 250          -- 反応速度
vim.o.timeoutlen = 400          -- キーマップ待ち時間

vim.filetype.add({ extension = { rules = "conf" }})  -- codexのrules

