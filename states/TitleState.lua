TitleState = Class{__includes = BaseState}

local buttonX = 135
local buttonY = 500
local buttonWidth = 300
local buttonHeight = 300

function TitleState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('info')
    end
    function love.mousepressed(x, y, button)
        if button == 1 then
            gStateMachine:change('info')
        end
    end
end


function TitleState:render()
    love.graphics.draw(logo, 17, 150 )
    love.graphics.draw(playButton, buttonX, buttonY)
end