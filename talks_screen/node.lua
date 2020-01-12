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
    
    local num__ = 1 -- sadly, Lua doesn't let us use num after the loop
    for num, talk in pairs(current_data["talks"]) do
        num__ = num
        -- display only talks for the current page
        if num > (current_page - 1) * 4 and num <= current_page * 4 then
            local row = (num - 1) % 4 + 1 -- modulo, but indices start at 1
            row = row - 0.9 -- index starts at 1
            cpmono:write(40, (row*2.5)*40, talk["title"], 32, 1, 1, 1, opacity)
            
            local persons_string = ""
            
            for num_, person in pairs(talk["persons"]) do
                if(persons_string == "") then
                    persons_string = person
                else
                    persons_string = persons_string .. ", " .. person
                end
            end
            
            usericon:draw(40, (row*2.5+1)*39, 80, (row*2.5+1)*39+40, opacity)
            cpmono:write(100, (row*2.5+1)*40, persons_string, 32, 1, 1, 1, opacity)
        end
    end
    
    -- we need more than one page so display pagination
    if num__ > 4 then
        local count_pages = math.ceil(num__ / 4)
        local text = current_page .. "/" .. count_pages
        cpmono:write(950, 5, text, 23, 1, 1, 1, opacity)
        -- fade out after some time
        if sys.now() > start_time + TRANSITION_TIMEOUT then
            opacity = opacity - OPACITY_STEP
            -- when we are not seen anymore, switch to the next page
            if opacity <= 0 then
                current_page = current_page + 1
                -- wrap around
                if current_page > count_pages then
                    current_page = 1
                end
                start_time = sys.now()
            end
        else
            -- fade back in
            if opacity < 1 then
                opacity = opacity + OPACITY_STEP
            end
        end
    else
        -- we might fall down to just one page
        current_page = 1
        start_time = sys.now()
        opacity = 1
    end
    
    cpmono:write(20, 390, "Add yours at https://wiki.chaosdorf.de/Freitagsfoo/" .. current_data["date"], 25, 1, 1, 1, 1, 1)
end

util.file_watch("freitagsfoo.json", function(content)
    current_data = json.decode(content)
end)
