local gwidth = vim.api.nvim_list_uis()[1].width
local gheight = vim.api.nvim_list_uis()[1].height
local width = math.floor(gwidth * 0.8)
local height = math.floor(gheight * 0.8)

local buf
local win

local open_todo_float = function(path)
    buf = vim.api.nvim_create_buf(false, true)
    win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = (gheight - height) / 2,
        col = (gwidth - width) / 2,
        style = 'minimal',
        border = 'double',
        title = 'Focus',
        title_pos = 'left',
    })
    vim.cmd.edit(path)
    vim.opt.number = true
    local line = vim.api.nvim_buf_get_lines(buf, 0, 3, false)
    local line3 = vim.fn.substitute(line[3], '\\s*$', '', '')
    -- if line3 ~= '- [ ]' then
    -- vim.api.nvim_put({ '- [ ] ' }, 'l', false, true)
    -- vim.api.nvim_win_set_cursor(win, { 3, 6 })
    -- end

    vim.keymap.set('n', '<leader>q', function()
        vim.cmd('w')
        vim.api.nvim_win_close(win, true)
        vim.api.nvim_buf_delete(buf, { force = true })
    end, { buffer = buf })

    vim.keymap.set('n', '<leader>tdo', function()
        vim.api.nvim_put({ '✓ ' }, 'c', false, false)
        vim.cmd('w')
    end, { buffer = buf })
end

local focus_path = '/Users/andrey.koptev/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/GradeUp/Todo.md'
local education_path =
'/Users/andrey.koptev/Library/Mobile Documents/com~apple~CloudDocs/Obsidian/GradeUp/Readers/Облачный Go/Основное из книги.md'

local open_focus = function()
    open_todo_float(focus_path)
end

local open_education = function()
    open_todo_float(education_path)
end


vim.keymap.set('n', '<leader>tdf', open_focus, {})
vim.keymap.set('n', '<leader>tde', open_education, {})
