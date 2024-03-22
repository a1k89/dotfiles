local setup, treesitter = pcall(require, "nvim-treesitter.configs")
if not setup then return end

treesitter.setup {
    ensure_installed = {
        "http",
        "python",
        "javascript",
        "typescript",
        "go",
        "lua",
        "luadoc",
        "query",
        "vim",
        "vimdoc",
        "bash"
    },
    sync_install = false,
    indent = { enable = true },
    autotag = { enable = true },
    highlight = {
        enable = true
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['ii'] = '@conditional.inner',
                ['ai'] = '@conditional.outer',
                ['il'] = '@loop.inner',
                ['al'] = '@loop.outer',
                ['at'] = '@comment.outer',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
    },
}


local parsers = require("nvim-treesitter.parsers").get_parser_configs()
parsers.asm = {
    install_info = {
        url = 'https://github.com/rush-rs/tree-sitter-asm.git',
        files = {
            'src/parser.c',
        },
        branch = 'main',
    },
}
vim.cmd('autocmd BufNewFile,BufRead .* setfiletype bash')
