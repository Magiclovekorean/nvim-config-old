local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
            if not ok then
                return  -- Si no està instal·lat encara, sortim sense error
            end

            ts_configs.setup {
                ensure_installed = {
                    "html", "css", "javascript", "jsdoc", "typescript", "tsx", "jsx",
                    "python", "vue", "svelte", "json", "jsonc", "yaml", "markdown",
                    "markdown_inline", "http", "regex", "bash", "gitattributes", "gitignore",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            }
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Colorscheme
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end,
    },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            -- Afegir fitxer actual a Harpoon
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

            -- Obrir menú ràpid
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            -- Navegar pels fitxers marcats
            vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
        end,
    },
})

