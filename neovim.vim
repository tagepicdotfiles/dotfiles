set number " Number in line bar

" Fucking indents
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Extensions
call plug#begin()

" Libraries
Plug 'nvim-lua/plenary.nvim' " Telescope
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Telescope TODO: Remove after stable support in neovim
Plug 'nvim-lua/popup.nvim' " telescope-zioxide
" TODO: Install extensions
Plug 'mfussenegger/nvim-dap' " Debugger

"" Better language support
Plug 'lepture/vim-jinja'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'elzr/vim-json'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'rust-lang/rust.vim'
Plug 'burner/vim-svelte'
Plug 'sheerun/vim-polyglot'

"" Fuzzy finding
Plug 'nvim-telescope/telescope.nvim'
Plug 'jvgrootveld/telescope-zoxide' " Better change dir guessing

"" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'weilbith/nvim-code-action-menu' " Lsp code action menu
Plug 'kosayoda/nvim-lightbulb' " Light bulb icon for code action-menu
Plug 'anott03/nvim-lspinstall' " Lsp auto-install servers

"" Auto-completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp' " nvim-lsp support

"" Colorscheme
Plug 'joshdick/onedark.vim'
" Plug 'navarasu/onedark.nvim'

"" Status bar
Plug 'itchyny/lightline.vim'
Plug 'j-hui/fidget.nvim' " Lsp progress bar

"" Snippets
Plug 'norcalli/snippets.nvim'

"" Marks
Plug 'chentau/marks.nvim'

"" Git gutter
Plug 'airblade/vim-gitgutter'

"" Dashboard
Plug 'glepnir/dashboard-nvim'

"" Commenting toggle
Plug 'tpope/vim-commentary'

""" Wraps (quotes, tags) manager
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim' " Shortcuts

"" Copilot support
Plug 'github/copilot.vim'

"" Discord status
"Plug 'vimsence/vimsence'

" Tips for me to learn vim
Plug 'michaelb/vim-tips'

" Load extensions
call plug#end()


" Keybindings
"" Normal mode
nmap ff <cmd>CodeActionMenu<CR>

map cd :lua vim.lsp.buf.definition()<CR>
""" Dap / Debugging
nmap gdb <cmd>:lua require'dap'.toggle_breakpoint()<CR>
nmap gdr <cmd>:lua require'dap'.repl.open()<CR>
nmap gdc <cmd>:lua require'dap'.continue()<CR>
nmap gds <cmd>:lua require'dap'.step_over()<CR>
nmap gdS <cmd>:lua require'dap'.step_into()<CR>

""" Telescope
"""" Unbind gt as I use x and z
nmap gt <Nop>

nmap gtf <cmd>Telescope find_files<CR>
nmap gtl <cmd>Telescope lsp_document_symbols<CR>
nmap gtg <cmd>Telescope live_grep<CR>

""" Tab navigation
nmap tn <cmd>:tabnew<CR>
nmap z <cmd>tabprev<CR>
nmap x <cmd>tabnext<CR>

""" Sessions
nmap gss <cmd>SessionSave<CR>
nmap gsl <cmd>SessionLoad<CR>

"" Insert mode
imap <C-s> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>


" Plugin config

"" Onedark
" let g:onedark_config = {
"     \ 'style': 'warmer',
" \}
" set termguicolors
colorscheme onedark

"" Lightline
let g:lightline = {'colorscheme': 'jellybeans', 'active': {}}
set noshowmode " This hides the -- insert -- thing

"" Git gutter
let g:gitgutter_highlight_lines = 0
let g:gitgutter_highlight_linenrs = 1

"" Dashboard
let g:dashboard_default_executive = 'telescope'
let g:dashboard_custom_shortcut={
\ 'last_session'       : '',
\ 'find_history'       : '',
\ 'find_file'          : '',
\ 'new_file'           : '',
\ 'change_colorscheme' : '',
\ 'find_word'          : '',
\ 'book_marks'         : '',
\ }

"" Vimsence
let g:vimsence_small_text = 'NeoVim'
let g:vimsence_small_image = 'neovim'

" Lua plugin config
lua << EOF
-- Fidget.nvim
require"fidget".setup{}

-- Nvim-cmp
local cmp = require"cmp"

cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
    }),
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-Space>'] = cmp.mapping.confirm { -- Accept current selection
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<C-d>'] = cmp.mapping.close(),
    }
})

-- nvim-lspconfig
local servers = {"pyright", "rust_analyzer", "dartls"}
local lspconfig = require"lspconfig"
for _, server in pairs(servers) do
    lspconfig[server].setup{
        flags = {
            debounce_text_changes = 150,
        }
    }
end

-- Snippets
require"snippets".snippets = {
    python = {
        mit = [[
# The MIT License (MIT)
#
# Copyright (c) ${=os.date("%Y")}-present tag-epic
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

]],
    undefined = [[
# These have different behaviour when not provided and set to None.
        # This only adds them if they are provided (not Undefined)
        ]],
    reason = [[
headers = {"Authorization": str(authentication)}

        # These have different behaviour when not provided and set to None.
        # This only adds them if they are provided (not Undefined)
        if reason is not UNDEFINED:
            headers["X-Audit-Log-Reason"] = reason
        ]]
    }
}

-- Telescope
require'telescope'.load_extension('zoxide')

-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
}
EOF