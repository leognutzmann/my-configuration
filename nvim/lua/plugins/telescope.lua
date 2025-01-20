return {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
  
        -- Modificação do find_command
        find_command = {
          "git",
          "ls-files",
          "--exclude-standard", -- Respeita o .gitignore
          "--cached", -- Arquivos rastreados
          "--other", -- Arquivos não rastreados
          "--ignored", -- Arquivos ignorados
          "--hidden",
        },
  
        -- Configuração do live_grep
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--hidden",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
      },
    },
  }
  