gl.setup(1024, 600)

function node.render()
    -- background
    gl.clear(246/255, 36/255, 118/255, 1)
    
    local title_screen = resource.render_child("title_screen")
    title_screen:draw(0, 350, 1024, 600)
end
