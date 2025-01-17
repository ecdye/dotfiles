-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- {
  --   'zbirenbaum/copilot-cmp',
  --   event = 'InsertEnter',
  --   config = function()
  --     require('copilot_cmp').setup()
  --   end,
  --   dependencies = {
  --     'zbirenbaum/copilot.lua',
  --     cmd = 'Copilot',
  --     config = function()
  --       require('copilot').setup {
  --         suggestion = { enabled = false },
  --         panel = { enabled = false },
  --       }
  --     end,
  --   },
  -- },
  { -- Included for better git commit formatting and further git integration
    'tpope/vim-fugitive',
  }
}
