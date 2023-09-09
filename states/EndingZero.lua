EndingZero = Class{__includes = BaseState}

function EndingZero:enter(params)
    self.score = params.score
end

function EndingZero:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
    function love.mousepressed(x, y, button)
        if button == 1 then
            gStateMachine:change('countdown')
        end
    end

end

function EndingZero:render()
    love.graphics.setFont(scoreFont2)
    love.graphics.printf('Oof! You lost!', 0, 300, virtual_width, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' ..tostring(self.score), 0, 400, virtual_width, 'center')
    love.graphics.draw(tapToStartText, 215, 600)
end