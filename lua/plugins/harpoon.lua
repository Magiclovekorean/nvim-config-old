return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- Basic keymaps
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toggle menu" })
        vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end, { desc = "Harpoon: Previous file" })
        vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end, { desc = "Harpoon: Next file" })
        
        -- NEW: Remove current file from Harpoon list
        vim.keymap.set("n", "<C-h>", function()
            harpoon:list():remove()
        end, { desc = "Harpoon: Remove current file" })

        -- Grep inside Harpoon files (Telescope)
        vim.keymap.set("n", "<leader>hg", function()
            local conf = require("telescope.config").values
            local themes = require("telescope.themes")
            local file_paths = {}
            
            for _, item in ipairs(harpoon:list().items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new(
                themes.get_ivy({ prompt_title = "Grep Harpoon Files" }),
                {
                    finder = require("telescope.finders").new_oneshot_job(
                       vim.tbl_flatten({
                            "rg", "--color=never", "--no-heading",
                            "--with-filename", "--line-number", "--column",
                            "", "--", unpack(file_paths)
                        }), {}
                    ),
                    previewer = conf.grep_previewer({}),
                    sorter = conf.generic_sorter({}),
                }
            ):find()
        end, { desc = "Harpoon: Grep files" })

        -- Harpoon files list (Telescope)
        vim.keymap.set("n", "<leader>ht", function()
            local conf = require("telescope.config").values
            local themes = require("telescope.themes")
            local file_paths = {}

            for _, item in ipairs(harpoon:list().items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new(
                themes.get_ivy({ prompt_title = "Harpoon Files" }),
                {
                    finder = require("telescope.finders").new_table({ results = file_paths }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }
            ):find()
        end, { desc = "Harpoon: List files" })
    end,
}

