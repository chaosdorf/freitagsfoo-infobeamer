gl.setup(1024, 250)

local TIME_PER_HOST = 3

local json = require "json"
-- This gets overwritten when the correct data has been fetched.
local current_data = {
    ["hosts"] = {
        [1] = "...",
    },
    ["date"] = "..."
}

-- keeps track of which hosts we're currently displaying
local host_index = 1 -- indexing starts with 1
local start_time = sys.now()
local animation_state = 0
local host_alpha = 1

-- title
local computerfont = resource.load_font("Computerfont.ttf")

-- normal text
local cpmono = resource.load_font("CPMono_v07_Plain.otf")

-- user icon
local usericon = resource.load_image("user.png")
local plannericon = resource.load_image("planner.png")

function node.render()
    -- background
    gl.clear(1, 1, 1, 1)
    
    computerfont:write(50, 50, "Freitagsfoo", 100, 0, 0, 0, 1)
    usericon:draw(598, 48, 648, 98)
    if(#current_data["hosts"] > 1) then
        if(animation_state == 0) then -- animation hasn't started or has finished
            host_alpha = 1 -- just to be sure
            if(start_time + TIME_PER_HOST < sys.now()) then
                animation_state = 1
                start_time = sys.now()
            end
        elseif(animation_state == 1) then -- fade out
            host_alpha = host_alpha - 0.04
            if(start_time + 0.5 < sys.now()) then
                host_alpha = 0 -- just to be sure
                host_index = host_index + 1
                if(host_index > #current_data["hosts"]) then
                    host_index = 1
                end
                start_time = sys.now()
                animation_state = 2
            end
        elseif(animation_state == 2) then -- fade in
            host_alpha = host_alpha + 0.04
            if(start_time + 0.5 < sys.now()) then
                animation_state = 0
                start_time = sys.now()
            end
        end
    else
        host_index = 1
    end
    cpmono:write(655, 50, current_data["hosts"][host_index] or "...", 50, 0, 0, 0, host_alpha)
    plannericon:draw(598, 123, 648, 173)
    cpmono:write(655, 125, current_data["date"], 50, 0, 0, 0, 1)
end

util.file_watch("freitagsfoo.json", function(content)
    current_data = json.decode(content)
end)
