gl.setup(1024, 180)

-- title
local computerfont = resource.load_font("Computerfont.ttf")

function node.render()
    -- background
    gl.clear(17/255, 224/255, 123/255, 1)
    
    computerfont:write(75, 25, "Talks", 100, 109/255, 4/255, 211/255, 1)
end
