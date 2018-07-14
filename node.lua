gl.setup(1024, 600)

local ytrans = 0
local atrans = 0
local transition = true

-- colored rectangle
local bluerect = resource.create_colored_texture(0, 164/255, 183/255, 0.7)

function node.render()
    -- background
    gl.clear(246/255, 36/255, 118/255, 1)
    
    -- rectangle
    bluerect:draw(0, 350 + ytrans, 1024, 600 + (ytrans*1.2), 2 - atrans)
    local title_screen = resource.render_child("title_screen")
    title_screen:draw(0, 350 + ytrans, 1024, 600 + (ytrans*1.2), 1 + atrans)
    
    if transition then
        ytrans = ytrans - 8
        atrans = atrans - 0.025
        if ytrans <= -350 then
            transition = false
        end
    end
end
