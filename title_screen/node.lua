gl.setup(1024, 250)

local TIME_PER_HOST = 4

local json = require "json"
-- This gets overwritten when the correct data has been fetched.
local current_data = {
    ["host"] = "...",
    ["date"] = "..."
}

-- keeps track of which hosts we're currently displaying
local host_index = 1 -- indexing starts with 1
local start_time = sys.now()

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
    if(start_time + TIME_PER_HOST < sys.now()) then
        host_index = host_index + 1
        if(host_index > #current_data["hosts"]) then
            host_index = 1
        end
        start_time = sys.now()
    end
    cpmono:write(655, 50, current_data["hosts"][host_index], 50, 1, 1, 1, 1)
    plannericon:draw(598, 123, 648, 173)
    cpmono:write(655, 125, current_data["date"], 50, 1, 1, 1, 1, 1)
end

util.file_watch("freitagsfoo.json", function(content)
    current_data = json.decode(content)
end)
