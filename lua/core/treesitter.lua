local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {"c", "lua", "java", "bash", "cmake", "cpp", "css", "cuda", "dart", "gitignore", "go", "gosum", "gomod", "html", "http", "ini", "javascript", "jsdoc", "json", "kotlin", "latex", "llvm", "make", "markdown", "ninja", "python", "proto", "regex", "rust", "scala", "scheme", "scss", "sql", "thrift", "toml", "typescript", "vim", "vue", "yaml", "zig", "wgsl", "slint"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "ron", "capnp", "func" }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  -- https://github.com/windwp/nvim-ts-autotag
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  -- https://github.com/mrjones2014/nvim-ts-rainbow
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  tree_docs = {
    enable = true,
    spec_config = {
      jsdoc = {
        slots = {
          class = {author = true}
        },
        processors = {
          author = function()
            return " * @author zugle"
          end
        }
      }
    }
  }
}
