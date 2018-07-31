gl.setup(1024, 600)

local ytrans = 0
local atrans = 0
local transition = false
local transition_step = 0 -- to 102
local screen = "title"
local start_time = sys.now()

-- colored rectangle
local bluerect = resource.create_colored_texture(0, 164/255, 183/255, 0.7)

function node.render()
    -- background
    gl.clear(246/255, 36/255, 118/255, 1)
    
    if screen == "title" and not transition then
        resource.render_child("title_background"):draw(0, 0, 1024, 350, 1)
        resource.render_child("title_screen"):draw(0, 350, 1024, 600, 1)
        
        if sys.now() > start_time + 10 then
            transition = true
        end
    elseif screen == "title" and transition then
        resource.render_child("title_background"):draw(0, 0, 1024, 350, 1 + atrans)
        resource.render_child("talks_title"):draw(0, 350 + ytrans, 1024, 600 + (ytrans*1.2), 0 - atrans)
        resource.render_child("title_screen"):draw(0, 350 + ytrans, 1024, 600 + (ytrans*1.2), 1 + atrans)
        
        transition_step = transition_step + 3
        ytrans = - 3.5 * transition_step
        atrans = - 0.01 * transition_step
        
        if ytrans <= -350 then
            transition = false
            ytrans = 0
            transition_step = 0
            screen = "talks"
            start_time = sys.now()
        end
    elseif screen == "talks" and not transition then
        resource.render_child("talks_title"):draw(0, 0, 1024, 180, 1)
        resource.render_child("talks_screen"):draw(0, 180, 1024, 600, 1 + atrans)
        
        if atrans < 0 then
            atrans = atrans + 0.025
        end
        
        if sys.now() > start_time + 10 then
            transition = true
        end
    elseif screen == "talks" and transition then
        resource.render_child("talks_title"):draw(0, 0 - ytrans, 1024, 180 - ytrans)
        resource.render_child("talks_screen"):draw(0, 180, 1024, 600, 1 + atrans)
        
        transition_step = transition_step + 3
        ytrans = - 3.5 * transition_step
        atrans = - 0.01 * transition_step
        if ytrans <= -350 then
            transition = false
            transition_step = 0
            ytrans = 0
            atrans = 0
            screen = "title"
            start_time = sys.now()
        end
    end
end
