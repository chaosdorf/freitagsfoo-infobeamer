gl.setup(1024, 420)

local json = require "json"
local current_data

-- normal text
local cpmono = resource.load_font("CPMono_v07_Plain.otf")

-- user icon
local usericon = resource.load_image("user.png")

function node.render()
    gl.clear(246/255, 36/255, 118/255, 1)
    
    cpmono:write(20, 375, "Add yours at https://wiki.chaosdorf.de/Freitagsfoo/1970-01-01", 25, 1, 1, 1, 1, 1)
end

local content = resource.load_file("freitagsfoo.json")
current_data = json.decode(content)

pp(current_data)
