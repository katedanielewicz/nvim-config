-- Ensure the semicolon is treated as part of the word
vim.opt.iskeyword:append(";")

local function smart_abbr(prefix, root, suffix, result_root)
    -- 1. Create the Lowercase Version
    local lhs_low = prefix .. root .. suffix
    local rhs_low = result_root
    vim.cmd(string.format("iabbrev %s %s", lhs_low, rhs_low))

    -- 2. Create the Capitalized Version
    -- Uppercase the first letter of the root only
    local root_cap = root:gsub("^%l", string.upper)
    -- Uppercase the first letter of the result word
    local result_cap = result_root:gsub("^%l", string.upper)
    
    local lhs_cap = prefix .. root_cap .. suffix
    vim.cmd(string.format("iabbrev %s %s", lhs_cap, result_cap))
end

-- USAGE EXAMPLES:
smart_abbr("cd", "ab", "", "smart_abbr(\"\", \"\", \"\", \"\")")

-- Components (Prefix: el, Suffix: empty)
smart_abbr("el", "ca", "", "capacitor")
smart_abbr("el", "in",  "", "inductor")
smart_abbr("el", "re",  "", "resistor")
smart_abbr("el", "pa", "",  "paracitic") 
smart_abbr("el", "ef", "", "efficient")

smart_abbr("el", "ca", "a", "capacitance")
smart_abbr("el", "in",  "a", "inductance")
smart_abbr("el", "re",  "a", "resistance")
smart_abbr("el", "ef", "a", "efficiency")

smart_abbr("el", "ca", "s", "capacitors")
smart_abbr("el", "in",  "s", "inductors")
smart_abbr("el", "re",  "s", "resistors")
smart_abbr("el", "pa", "s", "paracitics") 

smart_abbr("el", "ca", "as", "capacitances")
smart_abbr("el", "in",  "as", "inductances")
smart_abbr("el", "re",  "as", "resistances")
smart_abbr("el", "ef", "as", "efficiencies")


-- 3. Special Symbols
vim.cmd([[iabbrev So Ω]])
vim.cmd([[iabbrev Sm µ]])
vim.cmd([[iabbrev Sd °]])
vim.cmd([[iabbrev Spm ±]])

-- 4. Brackets with cursor positioning
-- We use <Left> to move the cursor inside the brackets
vim.cmd([[iabbrev Scb {}<Left>]])
vim.cmd([[iabbrev Sb ()<Left>]])
vim.cmd([[iabbrev SB []<Left>]])
