require "tools.rest"
require "tools.trouble"
require "tools.clipboard-image"
require "tools.bookmarks"
require "tools.zen-mode"
require "tools.dressing"
-- require "tools.guess-indent"
require "tools.markdown"
require "tools.dailynotes"
require "tools.line-notes"
require "tools.sql"
require "tools.colorizer"
require "tools.bookmarks"
-- require "tools.translate"

-- tmux
vim.cmd([[autocmd VimEnter,VimLeave * silent !tmux set status off]])
