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

function node.render()
    gl.clear(0, 0, 0, 1)
    
    local line_offset = 0
    
    for num, talk in pairs(current_data["talks"]) do
        num = num - 0.75 -- index starts at 1
        cpmono:write(40, (num*3)*40, talk["title"], 32, 1, 1, 1, 1, 1)
        
        local persons_string = ""
        
        for num_, person in pairs(talk["persons"]) do
            if(persons_string == "") then
                persons_string = person
            else
                persons_string = persons_string .. ", " .. person
            end
        end
        
        usericon:draw(40, (num*3+1)*39, 80, (num*3+1)*39+40)
        cpmono:write(100, (num*3+1)*40, persons_string, 32, 1, 1, 1, 1, 1)
    end
    
    cpmono:write(20, 375, "Add yours at https://wiki.chaosdorf.de/18_Jahre_Chaosdorf_Lightningtalks", 25, 1, 1, 1, 1, 1)
end

util.file_watch("freitagsfoo.json", function(content)
    current_data = json.decode(content)
end)
