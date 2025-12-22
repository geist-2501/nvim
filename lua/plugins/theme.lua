return {
   "vague-theme/vague.nvim",
   lazy = false,
   config = function ()
       vim.opt.background = "dark"
       vim.cmd("colorscheme vague")
   end
}
