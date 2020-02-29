gl.setup(1024, 420)

local json = require "json"

-- This gets overwritten when the correct data has been fetched.
local current_data = {
    ["date"] = "...",
    ["talks"] = {
        [1] = {
            ["title"] = "...",
            ["persons"] = {},
        },
    },
}

-- normal text
local cpmono = resource.load_font("CPMono_v07_Plain.otf")

-- user icon
local usericon = resource.load_image("user.png")

local talk_index = 1

function node.render()
    gl.clear(0, 0, 0, 1)

    local talk = current_data["talks"][talk_index]

    local persons_string = ""
    for num_, person in pairs(talk["persons"]) do
        if(persons_string == "") then
            persons_string = person
        else
            persons_string = persons_string .. ", " .. person
        end
    end

    cpmono:write(30, 15, talk["title"], 32, 1, 1, 1)
    usericon:draw(45, 60, 75, 90)
    cpmono:write(75, 65, persons_string, 20, 1, 1, 1)
    
    local description_left = talk["description"]
    local line_index = 0
    while description_left ~= "" do
        local index_to_split = description_left:find("\n")
        if index_to_split == nil then
            -- just one line left
            cpmono:write(45, 100 + (30 * line_index), description_left, 25, 1, 1, 1)
            line_index = line_index + 1
            break
        end
        local current_line = description_left:sub(1, index_to_split-1)
        description_left = description_left:sub(index_to_split+1, description_left:len())
        cpmono:write(45, 100 + (30 * line_index), current_line, 25, 1, 1, 1)
        line_index = line_index + 1
    end
    
    cpmono:write(20, 390, "Details at https://wiki.chaosdorf.de/Freitagsfoo/" .. current_data["date"], 25, 1, 1, 1, 1, 1)
end

util.file_watch("freitagsfoo.json", function(content)
    current_data = json.decode(content)
end)

node.alias("next_screen")
node.event("data", function(data, suffix)
    if suffix == "talk_index" then
        talk_index = tonumber(data)
    end
end)
