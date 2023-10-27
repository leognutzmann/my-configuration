return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")

    local function pick_color()
      local colors = { "String", "Identifier", "Keyword", "Number" }
      return colors[math.random(#colors)]
    end

    local logo = [[
         _              _            _                _             _         
        /\ \           /\ \     _   /\_\             /\ \         /\ \        
       /  \ \         /  \ \   /\_\/ / /         _   \_\ \       /  \ \       
      / /\ \_\       / /\ \ \_/ / /\ \ \__      /\_\ /\__ \   __/ /\ \ \      
     / / /\/_/      / / /\ \___/ /  \ \___\    / / // /_ \ \ /___/ /\ \ \     
    / / / ______   / / /  \/____/    \__  /   / / // / /\ \ \\___\/ / / /     
   / / / /\_____\ / / /    / / /     / / /   / / // / /  \/_/      / / /      
  / / /  \/____ // / /    / / /     / / /   / / // / /            / / /    _  
 / / /_____/ / // / /    / / /     / / /___/ / // / /             \ \ \__/\_\ 
/ / /______\/ // / /    / / /     / / /____\/ //_/ /               \ \___\/ / 
\/___________/ \/_/     \/_/      \/_________/ \_\/                 \/___/_/  
                                                                              
]]

    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
      dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
      dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
      dashboard.button("q", " " .. " Quit", ":qa<CR>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = pick_color()
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        dashboard.section.footer.val = "Gnutzmann Technologies Corp."
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
