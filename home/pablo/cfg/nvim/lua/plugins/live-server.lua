return {
  'barrett-ruth/live-server.nvim',
  build = 'yarn global add live-server',
  config = true,
  args = { 'port=7000', '--browser=firefox' } 
}
