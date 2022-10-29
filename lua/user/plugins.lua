local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)

	
	use { 'vim-airline/vim-airline', tag = 'v0.11' }
	use { 'Mofiqul/dracula.nvim', commit = 'ca1fc7a554386c2d31996ee28c8ad70731117bce' }
	use { 'luochen1990/rainbow', tag = 'v3.3.1' }
	use { 'nvim-neo-tree/neo-tree.nvim', tag = '2.43', 
		requires = { 
			"nvim-lua/plenary.nvim", 
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      			"MunifTanjim/nui.nvim",
		} 
	}

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
