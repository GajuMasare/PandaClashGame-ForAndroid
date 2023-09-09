Bird = Class{}

local gravity = 15

function Bird:init()
    self.image = love.graphics.newImage('assets/bird.png')
    self.width = self.image:getWidth() 
    self.height = self.image:getHeight() 

    self.x = virtual_width / 2 - (self.width / 2) --its x and y will be center at the start
    self.y = virtual_height / 2 - (self.height / 2)

    self.dy = 0 --y velocity 0 at start
end

function Bird:colliedes(pipe)
    if (self.x + 2) + (self.width - 4) >= (pipe.x + 100) and self.x + 2 <= (pipe.x + 100) + pipe_width then
        if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + pipe_height then
            return true
        end
    end
    return false
end

function Bird:update(dt)  
    self.dy = self.dy + gravity * dt  -- appling gravitying velocity
    self.y = self.y + self.dy -- moving the bird image to the dy

    function love.mousepressed(x, y, button)
        if button == 1 then
            self.dy = -5.5
            sounds['jump']:play()
        end
    end

    if love.keyboard.wasPressed('space') then
        self.dy = -5.5
        sounds['jump']:play()
    end
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end
