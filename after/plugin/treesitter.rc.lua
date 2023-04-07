local status, ts = pcall(require, 'nvim-treesitter.config')
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {}
  },
  indent = {
    enable = true,
    disable = {}
  },
  ensure_installed = {
    'c',
    'lua',
    'vim',
    'tsx',
    'json',
    'css',
    'go',
    'javascript',
    'rust'
  },
  autotag = {
    enable = true
  }
}
