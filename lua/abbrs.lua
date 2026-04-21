-- Ensure the semicolon is treated as part of the word

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

-- =============================================================================
-- COMMON WORD ABBREVIATIONS (Prefix: ee)
-- =============================================================================

-- 1. CONNECTIVES & ADVERBS
smart_abbr("ee", "be", "",    "because")
smart_abbr("ee", "ho", "",    "however")
smart_abbr("ee", "th", "",    "therefore")
smart_abbr("ee", "al", "",    "although")
smart_abbr("ee", "fu", "y",   "furthermore")
smart_abbr("ee", "es", "y",   "especially")
smart_abbr("ee", "pa", "y",   "particularly")

-- 2. ACTION & PROCESS (Root: 2 chars)
-- n = tion/ion, g = ing, d = ed
smart_abbr("ee", "fu", "",    "function")
smart_abbr("ee", "fu", "s",   "functions")
smart_abbr("ee", "fu", "al",  "functional")

smart_abbr("ee", "ge", "",    "generate")
smart_abbr("ee", "ge", "g",   "generating")
smart_abbr("ee", "ge", "d",   "generated")
smart_abbr("ee", "ge", "n",   "generation")

smart_abbr("ee", "op", "",    "operate")
smart_abbr("ee", "op", "g",   "operating")
smart_abbr("ee", "op", "n",   "operation")
smart_abbr("ee", "op", "s",   "operations")

smart_abbr("ee", "re", "",    "require")
smart_abbr("ee", "re", "s",   "requires")
smart_abbr("ee", "re", "d",   "required")
smart_abbr("ee", "re", "n",   "requirement")

-- 3. DESCRIPTION & QUANTITY
smart_abbr("ee", "di", "",    "different")
smart_abbr("ee", "di", "a",   "difference")
smart_abbr("ee", "di", "s",   "differences")

smart_abbr("ee", "st", "",    "standard")
smart_abbr("ee", "st", "s",   "standards")

smart_abbr("ee", "po", "",    "possible")
smart_abbr("ee", "po", "y",   "possibly")

smart_abbr("ee", "ne", "",    "necessary")
smart_abbr("ee", "ne", "y",   "necessarily")

-- 4. SYSTEM & STRUCTURE
smart_abbr("ee", "sy", "",    "system")
smart_abbr("ee", "sy", "s",   "systems")
smart_abbr("ee", "sy", "a",   "systematic")

smart_abbr("ee", "co", "",    "component")
smart_abbr("ee", "co", "s",   "components")

smart_abbr("ee", "en", "",    "environment")
smart_abbr("ee", "en", "s",   "environments")

smart_abbr("ee", "st", "u",   "structure")
smart_abbr("ee", "st", "us",  "structures")

-- 5. TIME & FREQUENCY
smart_abbr("ee", "im", "y",   "immediately")
smart_abbr("ee", "fr", "y",   "frequently")
smart_abbr("ee", "cu", "y",   "currently")
smart_abbr("ee", "te", "y",   "temporarily")

-- 6. MISC COMMON
smart_abbr("ee", "ex", "",    "example")
smart_abbr("ee", "ex", "s",   "examples")
smart_abbr("ee", "th", "u",   "through")
smart_abbr("ee", "be", "t",   "between")

-- =============================================================================
-- ELECTRICAL ABBREVIATIONS
-- =============================================================================

-- 1. THE ORIGINALS & CORE PASSIVES
-- Components (root), Properties (a), Plurals (s), Plural Properties (as)
smart_abbr("el", "ca", "",   "capacitor")
smart_abbr("el", "ca", "a",  "capacitance")
smart_abbr("el", "ca", "s",  "capacitors")
smart_abbr("el", "ca", "as", "capacitances")

smart_abbr("el", "in", "",   "inductor")
smart_abbr("el", "in", "a",  "inductance")
smart_abbr("el", "in", "s",  "inductors")
smart_abbr("el", "in", "as", "inductances")

smart_abbr("el", "re", "",   "resistor")
smart_abbr("el", "re", "a",  "resistance")
smart_abbr("el", "re", "s",  "resistors")
smart_abbr("el", "re", "as", "resistances")

-- 2. POWER & NETWORK ANALYSIS
smart_abbr("el", "im", "",   "impedance")
smart_abbr("el", "im", "s",  "impedances")
-- Impedance/Admittance usually serve as both the noun and property
smart_abbr("el", "ad", "",   "admittance")
smart_abbr("el", "ad", "s",  "admittances")

smart_abbr("el", "vo", "",   "voltage")
smart_abbr("el", "vo", "s",  "voltages")

smart_abbr("el", "cu", "",   "current")
smart_abbr("el", "cu", "s",  "currents")

smart_abbr("el", "co", "",   "conductor")
smart_abbr("el", "co", "a",  "conductance")
smart_abbr("el", "co", "s",  "conductors")
smart_abbr("el", "co", "as", "conductances")

-- 3. SEMICONDUCTORS & ACTIVE COMPONENTS
smart_abbr("el", "tr", "",   "transistor")
smart_abbr("el", "tr", "s",  "transistors")

smart_abbr("el", "di", "",   "diode")
smart_abbr("el", "di", "s",  "diodes")

smart_abbr("el", "ga", "",   "gain")
smart_abbr("el", "ga", "s",  "gains")

smart_abbr("el", "ph", "",   "phase")
smart_abbr("el", "ph", "s",  "phases")

-- 4. PHYSICAL PROPERTIES & BEHAVIOR
-- Corrected "paracitic" to "parasitic"
smart_abbr("el", "pa", "",   "parasitic")
smart_abbr("el", "pa", "s",  "parasitics")

smart_abbr("el", "ef", "",   "efficient")
smart_abbr("el", "ef", "a",  "efficiency")
smart_abbr("el", "ef", "as", "efficiencies")

smart_abbr("el", "th", "",   "thermal")
smart_abbr("el", "th", "a",  "threshold")
smart_abbr("el", "th", "as", "thresholds")

smart_abbr("el", "ma", "",   "magnetic")
smart_abbr("el", "ma", "a",  "magnetism")

smart_abbr("el", "rs", "",   "resonance")
smart_abbr("el", "rs", "a",  "resonant")

-- 5. SPECIAL SYMBOLS & HELPERS
vim.cmd([[iabbrev So Ω]])    -- Ohm
vim.cmd([[iabbrev Sm µ]])    -- Micro
vim.cmd([[iabbrev Sd °]])    -- Degree
vim.cmd([[iabbrev Spm ±]])   -- Plus-Minus

-- Brackets with cursor positioning
vim.cmd([[iabbrev Scb {}<Left>]])
vim.cmd([[iabbrev Sb ()<Left>]])
vim.cmd([[iabbrev SB []<Left>]])
