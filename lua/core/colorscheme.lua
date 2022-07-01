vim.cmd [[
try

  " https://vimcolorschemes.com

  set background=dark " or light if you want light mode

  " colorscheme dracula

  " colorscheme gruvbox

  " let g:edge_style = 'aura'
  " let g:edge_better_performance = 1
  colorscheme edge

catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
