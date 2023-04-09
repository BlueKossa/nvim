local gl = require('galaxyline')
local gls = gl.section
local fileinfo = require('galaxyline.provider_fileinfo')
local diagnostic = require('galaxyline.provider_diagnostic')
local vcs = require('galaxyline.provider_vcs')
local icons = {
    sep = {
        right = '',
        left = '',
    },
    branch = '',
    git = {
        add = '',
        modified = '',
        remove = '',
    },
    lsp = {
        error = '',
        warning = '',
        info = '',
        hint = '',
    },
    line = '',
    current_line = '',
    file = {
        modified = '',
        readonly = '',
        saved = '',
        new = '',
    },
    vim = '',
}

local colors = {
    mode = {
        n = '#199f4b',
        i = '#4db5bd',
        v = '#d19a66',
        V = '#d19a66',
        [''] = '#772F1A',
        R = '#DB504A',
        c = '#A1C349',
        t = '#d19a66',
    },
    bg = '#1e1e1e',
    fg = '#83858C',
    file = {
        modified = '#8B80F9',
        unchanged = '#CFBFF7',
    },

    lsp = {
        error = '#F44747',
        warning = '#FFB627',
        info = '#4FC1FF',
        hint = '#B2CCD6',
    },
    git = {
        add = '#A3BE8C',
        modified = '#EBCB8B',
        remove = '#BF616A',
        branch = '#81A1C1',
    },
}

local modes = {
    n = 'NORMAL',
    i = 'INSERT',
    v = 'VISUAL',
    V = 'VISUAL LINE',
    [''] = 'VISUAL BLOCK',
    R = 'REPLACE',
    c = 'COMMAND',
    t = 'TERMINAL',
}

local function highlight_fg(group, color, gui)
    local cmd = string.format('highlight %s guifg=%s', group, color)
    if gui ~= nil then
        cmd = cmd .. ' gui=' .. gui
    end
    vim.cmd(cmd)
end

local function highlight(group, bg, fg, gui)
    local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
    if gui ~= nil then
        cmd = cmd .. ' gui=' .. gui
    end
    vim.cmd(cmd)
end

local function wrap(side, name, hl, i, len)
    local l_index = i - len
    local r_index = i + 1
    gls[side][l_index] = {
        [name .. 'Left'] = {
            provider = function()
                return icons.sep.right
            end,
            highlight = hl,
        }
    }
    gls[side][r_index] = {
        [name .. 'Right'] = {
            provider = function()
                return icons.sep.left
            end,
            highlight = hl,
        }
    }
end

local function wrapl(name, hl, i, len)
    wrap('left', name, hl, i, len)
end

local function wrapr(name, hl, i, len)
    wrap('right', name, hl, i, len)
end

-- Mode --
local i = 1


i = i + 1
gls.left[i] = {
    Mode = {
        provider = function()
            local mode = vim.fn.mode()
            local mode_text = modes[mode]
            highlight('GalaxyViMode', colors.mode[mode], colors.bg)

            return string.format(' %s %s', icons.vim, mode_text)
        end,
        highlight = 'GalaxyViMode',
    },
}

wrapl('ViMode', 'GalaxyViMode', i, 1)

-- File --
i = i + 3

gls.left[i] = {
    FileIcon = {
        provider = function()
            local icon = fileinfo.get_file_icon()
            if icon == nil then
                icon = icons.file.new
            end
            return string.format(' %s', icon)
        end,
        highlight = 'GalaxyFile',
    },
}
i = i + 1
gls.left[i] = {
    FileName = {
        provider = function()
            local file = fileinfo.get_current_file_name()
            local modified = vim.bo.modified
            if modified then
                highlight('GalaxyFile', colors.file.modified, colors.bg)
            else
                highlight('GalaxyFile', colors.file.unchanged, colors.bg)
            end
            return string.format(' %s ', file)
        end,
        highlight = 'GalaxyFile',
    },
}

wrapl('File', 'GalaxyFile', i, 2)
i = i + 2

-- LSP --
gls.left[i] = {
    LspError = {
        provider = function()
            local count = diagnostic.get_diagnostic_error()
            if count == 0 or count == nil then
                return ''
            end
            highlight('GalaxyLspError', colors.bg, colors.lsp.error)
            return string.format('%s %s', icons.lsp.error, count)
        end,
        highlight = 'GalaxyLspError',
    },
}
i = i + 1 
gls.left[i] = {
    LspWarn = {
        provider = function()
            local count = diagnostic.get_diagnostic_warn()
            if count == 0 or count == nil then
                return ''
            end
            highlight('GalaxyLspWarning', colors.bg, colors.lsp.warning)
            return string.format('%s %s', icons.lsp.warning, count)
        end,
        highlight = 'GalaxyLspWarning',
    },
}
i = i + 1
gls.left[i] = {
    LspInfo = {
        provider = function()
            local count = diagnostic.get_diagnostic_info()
            if count == 0 or count == nil then
                return ''
            end
            highlight('GalaxyLspInfo', colors.bg, colors.lsp.info)
            return string.format('%s %s', icons.lsp.info, count)
        end,
        highlight = 'GalaxyLspInfo',
    },
}
i = i + 1
gls.left[i] = {
    LspHint = {
        provider = function()
            local count = diagnostic.get_diagnostic_hint()
            if count == 0 or count == nil then
                return ''
            end
            highlight('GalaxyLspHint', colors.bg, colors.lsp.hint)
            return string.format('%s %s', icons.lsp.hint, count)
        end,
        highlight = 'GalaxyLspHint',
    },
}



gls.left[i + 2] = {
    Clear = {
        provider = function()
            return ' '
        end,
        highlight = { colors.bg, colors.bg },
    },
}


local i = 1
gls.right[i] = {
    DiffAdd = {
        provider = function()
            local count = vcs.diff_add()
            if count == nil then
                count = '0 '
            end
            highlight('GalaxyDiffAdd', colors.bg, colors.git.add)
            return string.format(' %s %s', icons.git.add, count)
        end,
        highlight = 'GalaxyDiffAdd',
    },
}
i = i + 1
gls.right[i] = {
    DiffModified = {
        provider = function()
            local count = vcs.diff_modified()
            if count == nil then
                count = '0 '
            end
            highlight('GalaxyDiffModified', colors.bg, colors.git.modified)
            return string.format(' %s %s', icons.git.modified, count)
        end,
        highlight = 'GalaxyDiffModified',
    },
}
i = i + 1
gls.right[i] = {
    DiffRemove = {
        provider = function()
            local count = vcs.diff_remove()
            print(count)
            if count == nil then
                count = '0 '
            end
            highlight('GalaxyDiffRemove', colors.bg, colors.git.remove)
            return string.format(' %s %s', icons.git.remove, count)
        end,
        highlight = 'GalaxyDiffRemove',
    },
}
i = i + 2
gls.right[i] = {
    GitBranch = {
        provider = function()
            local branch = vcs.get_git_branch()
            if branch == nil then
                return ''
            end
            highlight('GalaxyGitBranch', colors.git.branch, colors.bg)
            return string.format(' %s %s ', icons.branch, branch)
        end,
        highlight = 'GalaxyGitBranch',
    },
}

wrapr('Git', 'GalaxyGitBranch', i, 1)
i = i + 3


gls.right[i] = {
    LineInfo = {
        provider = function()
            local line = vim.fn.line('.')
            local col = vim.fn.col('.')
            local total = vim.fn.line('$')
            highlight('GalaxyLineInfo', colors.fg, colors.bg)
            return string.format('%s %s  %s %s-%s ', icons.line, total, icons.current_line, line, col)
        end,
        highlight = 'GalaxyLineInfo',
    },
}
wrapr('LineInfo', 'GalaxyLineInfo', i, 1)


