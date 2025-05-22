-- Bootstrap plg.nvim
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/plg/start/plg.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/MihneaTs1/plg.nvim',
    install_path,
  })
  vim.cmd('packadd plg.nvim')
end
