return {
    "tpope/vim-fugitive",
    config = function()
        vim.opt.statusline = '  %< %{FugitiveHead()}  %f %m %r %w %= Ln %l, Col %c  %{&fileencoding?&fileencoding:&encoding}  '
    end,

}
