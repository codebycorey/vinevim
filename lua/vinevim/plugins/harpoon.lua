return {
    "ThePrimeagen/harpoon",
    keys = {
        {
            "<leader>a",
            function()
                require("harpoon.mark").add_file()
            end,
            desc = "[A]dd to harpoon",
        },
        {
            "<C-e>",
            function()
                require("harpoon.ui").toggle_quick_menu()
            end,
            desc = "Open floating harpoon",
        },
    },
}
