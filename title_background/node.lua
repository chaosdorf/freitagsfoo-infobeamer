gl.setup(1024, 350)

-- title
local computerfont = resource.load_font("Computerfont.ttf")

-- pesthoernchen
local pesthoernchen = resource.load_image("pesthoernchen.png")

function node.render()
  -- background
  gl.clear(246/255, 36/255, 118/255, 1)
  
  -- program in the upper left corner
  computerfont:write(43, 25, "10 FOO", 60, 0, 164/255, 183/255, 0.7)
  computerfont:write(25, 85, "20 GOTO FOO", 60, 0, 164/255, 183/255, 0.7)
  
  -- pesthoernchen
  util.draw_correct(pesthoernchen, 700, 100, 950, 325)
end
