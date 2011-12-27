
if exists("b:did_ropemode_plugin")
    finish " only load once
endif

let b:did_ropemode_plugin = 1

python << EOF

import vim
from os.path import join, dirname, abspath
from sys import path as pythonpath

script_file = vim.eval ('expand("<sfile>:p")')
this_dir = join (dirname (script_file), '..')

ropemode_dir = join (this_dir, 'ropemode')
ropevim_dir  = join (this_dir, 'ropevim')

def add_if_necessary (directory):
    if directory not in pythonpath:
        pythonpath.insert (0, directory)

add_if_necessary (ropemode_dir)
add_if_necessary (ropevim_dir)

import ropevim

EOF

fun! RopeOmni(findstart, base) "{{{
    call RopeCodeAssist()
endfunction "}}}

