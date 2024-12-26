--!strict
local Selection = game:GetService("Selection")

local INITIAL_INDEX: number = 32 -- Adjust this accordingly to your font, UNDERTALE seems to begin at 32
local GLYPH_DATA_CHUNK: string = [[

]] -- .font.gmx file contents go here

local BASE_GLYPH_FORMAT: string = '<glyph character="%d+" x="(%d+)" y="(%d+)" w="(%d+)" h="(%d+)" shift="(%d+)" offset="%d+"/>'
local TRANSLATED_GLYPH_FORMAT: string = "\t\t[%d] = {Vector2.new(%d, %d), Vector2.new(%d, %d), %d}"

-- Returns the source for a ModuleScript
-- which contains all the glyph data
local function convertToSource(): string
    local lines: {string} = {}
    local index: number = INITIAL_INDEX

    local maximumHeight: number = 0
    for x: string, y: string, w: string, h: string, shift: string in string.gmatch(GLYPH_DATA_CHUNK, BASE_GLYPH_FORMAT) do
        local heightNum: number? = tonumber(h)
		if heightNum and heightNum > maximumHeight then
			maximumHeight = heightNum
		end

        table.insert(lines, string.format(TRANSLATED_GLYPH_FORMAT, index, x, y, w, h, shift))
        index += 1
    end

    return "return {\n"
        .. "\timage = \"UPLOADED FONT SHEET GOES HERE\",\n"
        .. `\tmaxHeight = {maximumHeight},\n`
        .. "\tsymbols = {\n"
        .. table.concat(lines, ",\n")
        .. "\n\t}"
        .. "\n}"
end

-- Writes the font data in the form
-- of a module script
local function writeModuleScript()
    local moduleScript = Instance.new("ModuleScript")
    moduleScript.Name = "FontData"
    moduleScript.Source = convertToSource()
    moduleScript.Parent = Selection:Get()[1] or game:GetService("ServerStorage")
end

writeModuleScript()