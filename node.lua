gl.setup(1024, 600)

local TRANSITION_TIMEOUT = 10
local TRANSITION_SPEED = 3

local ytrans = 0
local atrans = 0
local bgtrans = - 1
local transition = false
local transition_step = 0 -- to 102
local screen = "initial"
local next_screen = "title"
local start_time = sys.now()

-- colored rectangle
local bluerect = resource.create_colored_texture(0, 164/255, 183/255, 0.7)

-- colored background
local redbg = resource.create_colored_texture(246/255, 36/255, 118/255)

function node.render()
    resource.render_child("background"):draw(0, 0, 1024, 600, 1)
    redbg:draw(0, 0, 1024, 600, 1 + bgtrans)
    
    if screen == "initial" and not transition then
        
        if bgtrans < 0 then
            bgtrans = bgtrans + 0.025
        end
        
        if sys.now() > start_time + 1 then
            transition = true
            transition_step = 0
            start_time = sys.now()
        end
    elseif screen == "initial" and next_screen == "title" and transition then
        resource.render_child("title_screen"):draw(0, 600 - ytrans, 1024, 850 - ytrans, 1)
        
        transition_step = transition_step + TRANSITION_SPEED
        ytrans = 2.5 * transition_step
        
        if transition_step >= 100 then
            transition = false
            ytrans = 0
            atrans = - 1
            transition_step = 0
            screen = "title"
            next_screen = "talks"
            start_time = sys.now()
        end
    elseif screen == "title" and not transition then
        resource.render_child("title_background"):draw(0, 0, 1024, 350, 1 + atrans)
        resource.render_child("title_screen"):draw(0, 350, 1024, 600, 1)
        
        if atrans < 0 then
            atrans = atrans + 0.025
        end
        
        if sys.now() > start_time + TRANSITION_TIMEOUT then
            transition = true
        end
    elseif screen == "title" and next_screen == "talks" and transition then
        resource.render_child("title_background"):draw(0, 0, 1024, 350, 1 + atrans)
        resource.render_child("talks_title"):draw(0, 350 + ytrans, 1024, 600 + (ytrans*1.2), 0 - atrans)
        resource.render_child("title_screen"):draw(0, 350 + ytrans, 1024, 600 + (ytrans*1.2), 1 + atrans)
        
        transition_step = transition_step + TRANSITION_SPEED
        ytrans = - 3.5 * transition_step
        atrans = - 0.01 * transition_step
        
        if transition_step >= 100 then
            transition = false
            ytrans = 0
            transition_step = 0
            screen = "talks"
            next_screen = "title"
            start_time = sys.now()
        end
    elseif screen == "talks" and not transition then
        resource.render_child("talks_title"):draw(0, 0, 1024, 180, 1)
        resource.render_child("talks_screen"):draw(0, 180, 1024, 600, 1 + atrans)
        
        if atrans < 0 then
            atrans = atrans + 0.025
        end
        
        if sys.now() > start_time + TRANSITION_TIMEOUT then
            transition = true
        end
    elseif screen == "talks" and next_screen == "title" and transition then
        resource.render_child("talks_title"):draw(0, 0 - ytrans, 1024, 180 - (ytrans*1.2), 1 + atrans)
        resource.render_child("title_screen"):draw(0, 0 - ytrans, 1024, 180 - (ytrans*1.2), 0 - atrans)
        resource.render_child("talks_screen"):draw(0, 180, 1024, 600, 1 + atrans)
        
        transition_step = transition_step + TRANSITION_SPEED
        ytrans = - 3.5 * transition_step
        atrans = - 0.01 * transition_step
        if transition_step >= 100 then
            transition = false
            transition_step = 0
            ytrans = 0
            screen = "title"
            next_screen = "talks"
            start_time = sys.now()
        end
    end
end
