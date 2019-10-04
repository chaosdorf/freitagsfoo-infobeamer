gl.setup(1024, 600)

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

function node.render()
    gl.clear(0, 0, 0, 1)
    
    local line_offset = 0
    
    for num, talk in pairs(current_data["talks"]) do
        cpmono:write(15, (num+line_offset)*40, talk["title"], 32, 1, 1, 1, 1, 1)
        
        for num_, person in pairs(talk["persons"]) do
            usericon:draw(700, (num+num_-1+line_offset)*39, 740, (num+num_-1+line_offset)*39+40)
            cpmono:write(735, (num+num_-1+line_offset)*40, person, 32, 1, 1, 1, 1, 1)
            if num_ > 1 then
                line_offset = line_offset + 1
            end
        end
    end
    
    cpmono:write(20, 570, "Add yours at https://wiki.chaosdorf.de/18_Jahre_Chaosdorf_Lightningtalks", 21, 1, 1, 1, 1, 1)
end

util.file_watch("freitagsfoo.json", function(content)
    current_data = json.decode(content)
end)
