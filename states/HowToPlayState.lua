HowToPlayState = Class {__includes = BaseState}

function HowToPlayState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
        sounds['startmusic']:pause()
        sounds['gamemusic']:play()
    end
    function love.mousepressed(x, y, button)
        if button == 1 then
            gStateMachine:change('countdown')
            sounds['startmusic']:pause()
            sounds['gamemusic']:play()
        end
    end
end

function HowToPlayState:render()
    love.graphics.draw(InfoImg, 35, 150)
    love.graphics.draw(tapToStartText, 225, 600)
end
