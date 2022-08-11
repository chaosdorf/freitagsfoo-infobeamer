gl.setup(1024, 180)

-- title
local computerfont = resource.load_font("Computerfont.ttf")

function node.render()
    -- background
    gl.clear(1, 1, 1, 1)
    
    computerfont:write(75, 25, "Next Talk", 100, 0, 0, 0, 1)
end
