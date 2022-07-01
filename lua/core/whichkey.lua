local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },

    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local WHICHKEY_CONFIG = {}

-- whick-key bind.
WHICHKEY_CONFIG.g_nopts = {
  mode = "n",
  prefix = "g",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

WHICHKEY_CONFIG.g_nmappings = {
  ["o"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show Error Messages" },
  ["d"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go To Definition" },
  ["D"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go To Declaration" },
  ["i"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go To Implementation" },
  ["f"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Formatting" },
  ["r"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Go To References" },
  ["["] = { "<cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>", "Diagnostic Goto Prev" },
  ["]"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Diagnostic Goto Next" },
  ["n"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
  ["t"] = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" },
  ["L"] = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspace Folders" },
  ["h"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
  ["j"] = { "<Cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
  ["a"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
  ["A"] = { "<Cmd>lua vim.lsp.buf.range_code_action()<CR>", "Range Code Action" },
  ["S"] = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document Symbol" },
  ["W"] = { "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "Workspace Symbol" },
  ["R"] = { "<cmd>SnipRun<CR>", "SnipRun" },
  -- ["R"] = { "<cmd>lua vim.lsp.codelens.run()<CR>", "Codelens Run" },
  e = {
    name = "Diagnostic",
    a = { "<cmd>lua vim.diagnostic.setqflist()<CR>", "All Workspace Diagnostics" },
    e = { "<cmd>lua vim.diagnostic.setqflist({severity = 'E'})<CR>", "All Workspace Errors" },
    w = { "<cmd>lua vim.diagnostic.setqflist({severity = 'W'})<CR>", "All Workspace Warnings" },
    b = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Buffer Diagnostics Only" },
    c = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Diagnostic Set Loclist" },
  },

  -- scala
  ["/"] = { "<cmd>lua require'metals'.hover_worksheet()<CR>", "Hover Worksheet" }
}

local leader_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local leader_mappings = {
  ["/"] = { "<cmd>lua require(\"Comment.api\").toggle_current_linewise()<CR>", "Comment" },
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  ["B"] = { "<cmd>DBUIToggle<CR>", "Database" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete<CR>", "Close Buffer" },
  ["C"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  --  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["h"] = { "<cmd>AerialToggle!<CR>", "Aerial Toggle" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Find files",
  },
  ["F"] = { "<cmd>Telescope live_grep<cr>", "Find Text" }, -- theme=ivy
  ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },
  ["E"] = { "<cmd>NvimTreeFindFile<cr>", "Find File" },

  d = {
    name = "Debug",
    c = { ":lua require'dap'.continue()<CR>", "Continue" },
    s = { ":lua require'dap'.step_over()<CR>", "StepOver" },
    d = { ":lua require'dap'.step_into()<CR>", "StepInto" },
    f = { ":lua require'dap'.step_out()<CR>", "StepOut" },
    b = { ":lua require'dap'.toggle_breakpoint()<CR>", "TogglePoint" },
    t = { "<cmd>lua require'dap'.repl.toggle()<CR>", "Rel Toggle" },
    B = { ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "Breakpoint" },
    p = { ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", "LogPointMessage" },
    r = { ":lua require'dap'.repl.open()<CR>", "ReplOpen" },
    h = { "<cmd>lua require'dap.ui.widgets'.hover()<CR>", "Dap UI Hover" },
    l = { ":lua require'dap'.run_last()<CR>", "RunLast" },
    e = { ":lua require('dapui').float_element(vim.Nil, { enter = true}) <CR>", "FloatElement" },
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    f = { "<cmd>DiffviewFileHistory<CR>", "File History" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    P = { "<cmd>DiffviewOpen<CR>", "Diff Project" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  m = {
    name = "Markdown",
    p = { "<cmd>Glow<cr>", "Preview"},
    i = { "<cmd>PasteImg<cr>", "Paste Image" },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },

  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
}

local leader_vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local leader_vmappings = {
  ["/"] = { "<ESC><CMD>lua require(\"Comment.api\").toggle_linewise_op(vim.fn.visualmode())<CR>", "Comment" },
}

which_key.setup(setup)
which_key.register(leader_mappings, leader_opts)
which_key.register(leader_vmappings, leader_vopts)
which_key.register(WHICHKEY_CONFIG.g_nmappings, WHICHKEY_CONFIG.g_nopts)

return WHICHKEY_CONFIG
