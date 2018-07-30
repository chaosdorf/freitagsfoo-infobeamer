gl.setup(1024, 250)

local json = require "json"
local current_data

-- title
local computerfont = resource.load_font("Computerfont.ttf")

-- normal text
local cpmono = resource.load_font("CPMono_v07_Plain.otf")

-- user icon
local usericon = resource.load_image("user.png")
local plannericon = resource.load_image("planner.png")

function node.render()
    -- background
    gl.clear(0, 164/255, 183/255, 0.7)
    
    computerfont:write(50, 50, "Freitagsfoo", 100, 246/255, 36/255, 118/255, 1)
    usericon:draw(598, 48, 648, 98)
    cpmono:write(655, 50, current_data["host"], 50, 1, 1, 1, 1)
    plannericon:draw(598, 123, 648, 173)
    cpmono:write(655, 125, current_data["date"], 50, 1, 1, 1, 1, 1)
end

util.file_watch("freitagsfoo.json", function(content)
    current_data = json.decode(content)
end)
