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

-- we need to paginate if there are more than four talks
local current_page = 1

-- we need to know when to switch to the next page
local start_time = sys.now()

-- when to switch pages
-- TODO: calculate this based on the number of pages?
local TRANSITION_TIMEOUT = 5

-- how fast to fade
local OPACITY_STEP = 0.05

-- are we currently fading?
local opacity = 1

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
            
            usericon:draw(40, (row*2.5+1)*39, 80, (row*2.5+1)*39+40, opacity)
            cpmono:write(100, (row*2.5+1)*40, persons_string, 32, 1, 1, 1, opacity)
        end
    end
    
    cpmono:write(20, 570, "Add yours at https://wiki.chaosdorf.de/Einweihungsfeier/Lightningtalks", 21, 1, 1, 1, 1, 1)
end

util.file_watch("freitagsfoo.json", function(content)
    current_data = json.decode(content)
end)
