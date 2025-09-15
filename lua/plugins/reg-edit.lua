local M = {}

-- Read registers: lowercase a-z + common special registers
function M.read_registers()
    local regs = {}
    local special = {}

    -- Lowercase registers a-z
    for i = string.byte('a'), string.byte('z') do
        local r = string.char(i)
        local ok, val = pcall(vim.fn.getreg, r)
        regs[r] = ok and val or ""
    end


    for i = string.byte('0'), string.byte('9') do
        local r = string.char(i)
        local ok, val = pcall(vim.fn.getreg, r)
        regs[r] = ok and val or ""
    end

    -- Special registers
    for _, r in ipairs(special) do
        local ok, val = pcall(vim.fn.getreg, r)
        regs[r] = ok and val or ""
    end

    return regs
end

-- Write registers from a table { reg = value }
function M.write_registers(reg_table)
    for reg, val in pairs(reg_table) do
        -- Only write if register is valid
        if type(val) == "string" then
            vim.fn.setreg(reg, val)
        end
    end
end

-- Pretty print registers in the form: a: 'value'
function M.print_registers()
    M.read_registers()
    local regs = M.read_registers()
    for reg, val in pairs(regs) do
        -- Escape single quotes inside value
        val = val:gsub("'", "\\'")
        print(string.format("%s: '%s'", reg, val))
    end
end



vim.api.nvim_create_user_command("PrintRegisters", function()
    M.print_registers()
end, {})

return M



