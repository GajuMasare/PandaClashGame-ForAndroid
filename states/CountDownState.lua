CountDownState = Class {__includes = BaseState}

countdown_speed = 0.75

function CountDownState:init()
    self.count = 3
    self.timer = 0
end

function CountDownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > countdown_speed then
        self.timer = self.timer % countdown_speed
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change('play')
        end
    end
end

function CountDownState:render()
    love.graphics.setFont(font)
    love.graphics.printf(tostring(self.count), virtual_width / 2 - 15, virtual_height / 2 - 60, 100)
end
