gl.setup(1024, 600)

local TRANSITION_TIMEOUT = 10
local TRANSITION_SPEED = 3

local computerfont = resource.load_font("Computerfont.ttf")
local cpmono = resource.load_font("CPMono_v07_Plain.otf")

local xtrans = 0
local ytrans = 0
local atrans = 0
local bgtrans = - 1
local transition = false
local transition_step = 0 -- to 102
local screen = "background"
local next_screen = "background"
local scheduled_screen = nil
local start_time = sys.now()

-- colored rectangle
local bluerect = resource.create_colored_texture(1, 1, 1, 1)

-- colored background
local redbg = resource.create_colored_texture(0, 0, 0)

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
            if scheduled_screen == nil then
                next_screen = "talks"
                start_time = sys.now()
            else
                next_screen = scheduled_screen
                scheduled_screen = nil
                start_time = sys.now() - TRANSITION_TIMEOUT/1.5
            end
        end
    elseif screen == "initial" and next_screen == "talks" and transition then
        resource.render_child("talks_title"):draw(0, -180 + ytrans, 1024, 0 + ytrans, 1)
        
        transition_step = transition_step + TRANSITION_SPEED
        ytrans = 1.75 * transition_step
        
        if transition_step >= 100 then
            transition = false
            ytrans = 0
            atrans = - 1
            transition_step = 0
            screen = "talks"
            if scheduled_screen == nil then
                next_screen = "title"
                start_time = sys.now()
            else
                next_screen = scheduled_screen
                scheduled_screen = nil
                start_time = sys.now() - TRANSITION_TIMEOUT/1.5
            end
        end
    elseif screen == "initial" and next_screen == "next" and transition then
        resource.render_child("next_title"):draw(0, -180 + ytrans, 1024, 0 + ytrans, 1)
        
        transition_step = transition_step + TRANSITION_SPEED
        ytrans = 1.75 * transition_step
        
        if transition_step >= 100 then
            transition = false
            ytrans = 0
            atrans = - 1
            transition_step = 0
            screen = "next"
            if scheduled_screen == nil then
                next_screen = "title"
                start_time = sys.now()
            else
                next_screen = scheduled_screen
                scheduled_screen = nil
                start_time = sys.now() - TRANSITION_TIMEOUT/1.5
            end
        end
    elseif screen == "initial" and next_screen == "background" and transition then
        bgtrans = bgtrans - 0.025
        
        if bgtrans <= - 1 then
            transition = false
            transition_step = 0
            screen = "background"
            if scheduled_screen == nil then
                next_screen = "background"
                start_time = sys.now()
            else
                next_screen = scheduled_screen
                scheduled_screen = nil
                start_time = sys.now() - TRANSITION_TIMEOUT/1.5
            end
        end
    elseif screen == "background" and not transition then
        if next_screen ~= "background" then
            screen = "initial"
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
            if scheduled_screen == nil then
                next_screen = "title"
                start_time = sys.now()
            else
                next_screen = scheduled_screen
                scheduled_screen = nil
                start_time = sys.now() - TRANSITION_TIMEOUT/1.5
            end
        end
    elseif screen == "title" and next_screen == "next" and transition then
        resource.render_child("title_background"):draw(0, 0, 1024, 350, 1 + atrans)
        resource.render_child("next_title"):draw(0, 350 + ytrans, 1024, 600 + (ytrans*1.2), 0 - atrans)
        resource.render_child("title_screen"):draw(0, 350 + ytrans, 1024, 600 + (ytrans*1.2), 1 + atrans)
        
        transition_step = transition_step + TRANSITION_SPEED
        ytrans = - 3.5 * transition_step
        atrans = - 0.01 * transition_step
        
        if transition_step >= 100 then
            transition = false
            ytrans = 0
            transition_step = 0
            screen = "next"
            if scheduled_screen == nil then
                next_screen = "title"
                start_time = sys.now()
            else
                next_screen = scheduled_screen
                scheduled_screen = nil
                start_time = sys.now() - TRANSITION_TIMEOUT/1.5
            end
        end
    elseif screen == "title" and next_screen == "initial" and transition then
        resource.render_child("title_background"):draw(0, 0, 1024, 350, 1 + atrans)
        resource.render_child("title_screen"):draw(0, 350 + ytrans, 1024, 600 + ytrans)
        
        transition_step = transition_step + TRANSITION_SPEED
        ytrans = 3.5 * transition_step
        atrans = - 0.01 * transition_step
        
        if transition_step >= 100 then
            transition = false
            ytrans = 0
            transition_step = 0
            screen = "initial"
            next_screen = "background"
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
        resource.render_child("talks_screen"):draw(0, 180, 1024, 600, 1 + atrans)
        resource.render_child("talks_title"):draw(0, 0 - ytrans, 1024, 180 - (ytrans*1.2), 1 + atrans)
        resource.render_child("title_screen"):draw(0, 0 - ytrans, 1024, 180 - (ytrans*1.2), 0 - atrans)
        
        transition_step = transition_step + TRANSITION_SPEED
        ytrans = - 3.5 * transition_step
        atrans = - 0.01 * transition_step
        if transition_step >= 100 then
            transition = false
            transition_step = 0
            ytrans = 0
            screen = "title"
            if scheduled_screen == nil then
                next_screen = "talks"
                start_time = sys.now()
            else
                next_screen = scheduled_screen
                scheduled_screen = nil
                start_time = sys.now() - TRANSITION_TIMEOUT/1.5
            end
        end
    elseif screen == "talks" and next_screen == "initial" and transition then
        resource.render_child("talks_title"):draw(0, 0 + ytrans, 1024, 180 + ytrans)
        resource.render_child("talks_screen"):draw(0, 180, 1024, 600, 1 + atrans)
        
        transition_step = transition_step + TRANSITION_SPEED
        ytrans = - 2.25 * transition_step
        atrans = - 0.01 * transition_step
        if transition_step >= 100 then
            transition = false
            transition_step = 0
            ytrans = 0
            screen = "initial"
            next_screen = "background"
            start_time = sys.now()
        end
    elseif screen == "talks" and next_screen == "next" and transition then
        resource.render_child("talks_title"):draw(0 + xtrans, 0, 1024 + xtrans, 180, 1)
        resource.render_child("talks_screen"):draw(0 + xtrans, 180, 1024 + xtrans, 600, 1)
        resource.render_child("next_title"):draw(1024 + xtrans, 0, 2048 + xtrans, 180, 1)
        resource.render_child("next_screen"):draw(1024 + xtrans, 180, 2048 + xtrans, 600)
        transition_step = transition_step + TRANSITION_SPEED
        xtrans = - 10.04 * transition_step
        if transition_step >= 100 then
            transition = false
            transition_step = 0
            xtrans = 0
            screen = "next"
            next_screen = "title"
            start_time = sys.now()
        end
    elseif screen == "next" and not transition then
        resource.render_child("next_title"):draw(0, 0, 1024, 180, 1)
        resource.render_child("next_screen"):draw(0, 180, 1024, 600, 1 + atrans)
        
        if atrans < 0 then
            atrans = atrans + 0.025
        end
        
        if sys.now() > start_time + TRANSITION_TIMEOUT then
            transition = true
        end
    elseif screen == "next" and next_screen == "title" and transition then
        resource.render_child("next_screen"):draw(0, 180, 1024, 600, 1 + atrans)
        resource.render_child("next_title"):draw(0, 0 - ytrans, 1024, 180 - (ytrans*1.2), 1 + atrans)
        resource.render_child("title_screen"):draw(0, 0 - ytrans, 1024, 180 - (ytrans*1.2), 0 - atrans)
        
        transition_step = transition_step + TRANSITION_SPEED
        ytrans = - 3.5 * transition_step
        atrans = - 0.01 * transition_step
        if transition_step >= 100 then
            transition = false
            transition_step = 0
            ytrans = 0
            screen = "title"
            if scheduled_screen == nil then
                next_screen = "next"
                start_time = sys.now()
            else
                next_screen = scheduled_screen
                scheduled_screen = nil
                start_time = sys.now() - TRANSITION_TIMEOUT/1.5
            end
        end
    elseif screen == "next" and next_screen == "talks" and transition then
        resource.render_child("next_title"):draw(0 + xtrans, 0, 1024 + xtrans, 180, 1)
        resource.render_child("next_screen"):draw(0 + xtrans, 180, 1024 + xtrans, 600, 1)
        resource.render_child("talks_title"):draw(-1024 + xtrans, 0, 0 + xtrans, 180, 1)
        resource.render_child("talks_screen"):draw(-1024 + xtrans, 180, 0 + xtrans, 600)
        transition_step = transition_step + TRANSITION_SPEED
        xtrans = 10.04 * transition_step
        if transition_step >= 100 then
            transition = false
            transition_step = 0
            xtrans = 0
            screen = "talks"
            next_screen = "title"
            start_time = sys.now()
        end
    elseif screen == "next" and next_screen == "initial" and transition then
        resource.render_child("next_title"):draw(0, 0 + ytrans, 1024, 180 + ytrans)
        resource.render_child("next_screen"):draw(0, 180, 1024, 600, 1 + atrans)
        
        transition_step = transition_step + TRANSITION_SPEED
        ytrans = - 2.25 * transition_step
        atrans = - 0.01 * transition_step
        if transition_step >= 100 then
            transition = false
            transition_step = 0
            ytrans = 0
            screen = "initial"
            next_screen = "background"
            start_time = sys.now()
        end
    else
        bgtrans = 0
        computerfont:write(100, 50, ":-(", 200, 1, 1, 1, 1)
        cpmono:write(50, 300, "Something happened.", 50, 1, 1, 1, 1, 1)
        cpmono:write(15, 450, "Unexpected state: screen=" .. screen .. ", next_screen=" .. next_screen .. ", transition=" .. tostring(transition), 20, 1, 1, 1, 1, 1)
        cpmono:write(5, 550, "Please create an issue at https://github.com/chaosdorf/freitagsfoo-infobeamer/", 20, 1, 1, 1, 1, 1)
    end
end

node.alias("freitagsfoo")
node.event("data", function(data, suffix)
    if suffix == "screen" then
        if not transition then
            -- changing the next screen during a transition breaks stuff
            if data ~= screen then
                -- next_screen == screen breaks stuff
                if not (screen == "background" and data == "initial") then
                    next_screen = data
                    scheduled_screen = nil
                    -- trigger the transition if we can
                    if screen ~= "background" then
                        transition = true
                        transition_step = 0
                        start_time = sys.now()
                    end
                end
            end
        else
            -- schedule the change for after the current transition,
            -- so that it doesn't get lost
            scheduled_screen = data
        end
    end
end)
