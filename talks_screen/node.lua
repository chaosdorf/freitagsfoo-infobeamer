gl.setup(1024, 420)

local json = require "json"
local current_data

-- normal text
local cpmono = resource.load_font("CPMono_v07_Plain.otf")

-- user icon
local usericon = resource.load_image("user.png")

function node.render()
    gl.clear(246/255, 36/255, 118/255, 1)
    
    local line_offset = 0
    
    for num, talk in pairs(current_data["talks"]) do
        cpmono:write(40, (num+line_offset)*40, talk["title"], 32, 1, 1, 1, 1, 1)
        
        for num_, person in pairs(talk["persons"]) do
            usericon:draw(700, (num+num_-1+line_offset)*39, 740, (num+num_-1+line_offset)*39+40)
            cpmono:write(760, (num+num_-1+line_offset)*40, person, 32, 1, 1, 1, 1, 1)
            if num_ > 1 then
                line_offset = line_offset + 1
            end
        end
    end
    
    cpmono:write(20, 375, "Add yours at https://wiki.chaosdorf.de/Freitagsfoo/" .. current_data["date"], 25, 1, 1, 1, 1, 1)
end

util.file_watch("freitagsfoo.json", function(content)
    current_data = json.decode(content)
end)
