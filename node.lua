gl.setup(1024, 600)

local ytrans = 0
local atrans = 0
local transition = true
local screen = "title"

-- colored rectangle
local bluerect = resource.create_colored_texture(0, 164/255, 183/255, 0.7)

function node.render()
    -- background
    gl.clear(246/255, 36/255, 118/255, 1)
    
    if screen == "title" then
        -- rectangle
        bluerect:draw(0, 350 + ytrans, 1024, 600 + (ytrans*1.2), 2 - atrans)
        resource.render_child("title_screen"):draw(0, 350 + ytrans, 1024, 600 + (ytrans*1.2), 1 + atrans)
        
        if transition then
            ytrans = ytrans - 8
            atrans = atrans - 0.025
            if ytrans <= -350 then
                transition = false
                ytrans = 0
                screen = "talks"
            end
        end
    elseif screen == "talks" then
        bluerect:draw(0, 0, 1024, 180)
        resource.render_child("talks_screen"):draw(0, 180, 1024, 600, 1 + atrans)
        if atrans < 0 then
            atrans = atrans + 0.025
        end
    end
end
