gl.setup(1024, 180)

-- title
local computerfont = resource.load_font("Computerfont.ttf")

function node.render()
    -- background
    gl.clear(0, 164/255, 183/255, 0.7)
    
    computerfont:write(75, 25, "Talks", 100, 246/255, 36/255, 118/255, 1)
end
