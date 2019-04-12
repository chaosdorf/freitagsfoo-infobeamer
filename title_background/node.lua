gl.setup(1024, 350)

-- title
local computerfont = resource.load_font("Computerfont.ttf")

-- pesthoernchen
local pesthoernchen = resource.load_image("pesthoernchen.png")

function node.render()
  -- background
  gl.clear(109/255, 4/255, 211/255, 1)
  
  -- program in the upper left corner
  computerfont:write(43, 25, "10 FOO", 60, 17/255, 224/255, 123/255, 1)
  computerfont:write(25, 85, "20 GOTO 10", 60, 17/255, 224/255, 123/255, 1)
  
  -- pesthoernchen
  util.draw_correct(pesthoernchen, 700, 100, 950, 325)
end
