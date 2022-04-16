local options = {
    -- Line Numbers
    number = true,
    relativenumber = true,

    -- Tabs and Indents
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,
    smartcase = true,
    showtabline = 4,

    -- Turn off Search Highlight
    hlsearch = false,
    incsearch = true,
    ignorecase = true,

    -- Keep Buffers Open
    hidden = true,

    -- Turn off error bells
    errorbells = false,

    -- Text Display
    wrap = false,

    -- history
    swapfile = false,
    backup = false,
    undofile = true,
    --undodir = '$HOME/.vim/undodir',
    writebackup = false,

    -- Scrolling
    scrolloff = 8,
    cursorline = true,

    signcolumn = "yes",
    colorcolumn = "80",

    showmode = false,
    --completeopt = { "menuone", "noselect" }, -- "noinsert"

    cmdheight = 1,
    updatetime = 300, -- 50

    termguicolors = true,
    clipboard = "unnamedplus",

    mouse = "a",

    splitbelow = true,
    splitright = true,

    guicursor = "",
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
    vim.opt[k] = v
end
