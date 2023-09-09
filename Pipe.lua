Pipe = Class{}

local pipe_image = love.graphics.newImage('assets/pipe.png')

pipe_scroll_speed = 130
pipe_height = 50
pipe_width = 20

function Pipe:init(orientation, y)
    self.x = virtual_width
    self.y = y

    self.width = pipe_width
    self.height = pipe_height
    self.orientation = orientation
end

function Pipe:render()   
    love.graphics.draw(pipe_image, self.x, 
    (self.orientation == 'top' and self.y + pipe_height or self.y),
    0, 1, self.orientation == 'top' and -1 or 1)
end

