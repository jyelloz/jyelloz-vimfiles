require'lualine'.setup{
  options = {
    theme = 'base16',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode', 'paste'},
    lualine_b = {'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}
