gl.setup(1024, 600)

-- title
local computerfont = resource.load_font("Computerfont.ttf")

-- normal text
local cpmono = resource.load_font("CPMono_v07_Plain.otf")

-- user icon
local usericon = resource.load_image("user.png")
local plannericon = resource.load_image("planner.png")

-- colored rectangle
local bluerect = resource.create_colored_texture(0, 164/255, 183/255, 0.7)

function node.render()
    -- background
    gl.clear(246/255, 36/255, 118/255, 1)
    
    -- rectangle
    bluerect:draw(0, 350, 1024, 600)
    
    computerfont:write(50, 400, "Freitagsfoo", 100, 246/255, 36/255, 118/255, 1)
    usericon:draw(600, 400, 645, 445)
    cpmono:write(650, 400, "FIXME", 50, 1, 1, 1, 1)
    plannericon:draw(600, 475, 645, 520)
    cpmono:write(650, 475, "1970-01-01", 50, 1, 1, 1, 1, 1)
end
