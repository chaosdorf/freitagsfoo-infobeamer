gl.setup(1024, 600)

local ytrans = 0
local atrans = 0
local transition = false
local screen = "title"
local start_time = sys.now()

-- colored rectangle
local bluerect = resource.create_colored_texture(0, 164/255, 183/255, 0.7)

function node.render()
    -- background
    gl.clear(246/255, 36/255, 118/255, 1)
    
    if screen == "title" then
        -- rectangle
        resource.render_child("talks_title"):draw(0, 350 + ytrans, 1024, 600 + (ytrans*1.2), 0 - atrans)
        resource.render_child("title_screen"):draw(0, 350 + ytrans, 1024, 600 + (ytrans*1.2), 1 + atrans)
        
        if sys.now() > start_time + 10 then
            transition = true
        end
        
        if transition then
            ytrans = ytrans - 8
            atrans = atrans - 0.025
            if ytrans <= -350 then
                transition = false
                ytrans = 0
                screen = "talks"
                start_time = sys.now()
            end
        end
    elseif screen == "talks" then
        resource.render_child("talks_title"):draw(0, 0 - ytrans, 1024, 180 - ytrans)
        resource.render_child("talks_screen"):draw(0, 180, 1024, 600, 1 + atrans)
        if atrans < 0 and not transition then
            atrans = atrans + 0.025
        end
        
        if sys.now() > start_time + 10 then
            transition = true
        end
        
        if transition then
            ytrans = ytrans - 8
            atrans = atrans - 0.025
            if ytrans <= -350 then
                transition = false
                ytrans = 0
                atrans = 0
                screen = "title"
                start_time = sys.now()
            end
        end
    end
end
