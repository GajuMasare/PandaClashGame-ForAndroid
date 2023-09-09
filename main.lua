Class = require 'class'
push = require 'push' 

require 'Bird'
require 'Pipe'
require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/TitleState'
require 'states/CountDownState'
require 'states/HowToPlayState'
require 'states/PlayState'
require 'states/EndingZero'

--actual phone window
window_width = 360     
window_height = 800

--virtual screen which will resize to actaul phone window
virtual_height = 1146
virtual_width = 570

--images
local backgound = love.graphics.newImage('assets/background.png')
local ground = love.graphics.newImage('assets/ground.png')
logo = love.graphics.newImage('assets/logo.png')
playButton = love.graphics.newImage('assets/playButton.png')
InfoImg = love.graphics.newImage('assets/info.png')
tapToStartText = love.graphics.newImage('assets/tabToPlayText.png')


--backgound data
local backgroundScrollTo = 0 
local background_scroll_speed = 15
local background_looping_point = 853

--ground data
local groundScroolTo = 0
local ground_scroll_speed = 100
local ground_looping_point = 1703

---------------------------------------------------------------------------------------------
function love.load()
    font = love.graphics.newFont('fonts/font.ttf',87)
    scoreFont = love.graphics.newFont('fonts/flappy.ttf',30)
    scoreFont2 = love.graphics.newFont('fonts/flappy.ttf',50)
    mediumFont = love.graphics.newFont('fonts/flappy.ttf', 30)
    love.graphics.setFont(font)

    --display setting
    love.graphics.getDefaultFilter('nearest', 'nearest')
    push:setupScreen(virtual_width, virtual_height ,window_width, window_height,{
        vsync = true,
        fullscreen = true,
        resize = true
    })

    sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/explosion.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['win'] = love.audio.newSource('sounds/win.wav', 'static'),
        ['startmusic'] = love.audio.newSource('sounds/startmusic.mp3', 'static'),
        ['gamemusic'] = love.audio.newSource('sounds/gamemusic.mp3', 'static')
    }

    sounds['startmusic']:setLooping(true)
    sounds['startmusic']:play()

    --state machine
    gStateMachine = StateMachine {
        ['title'] = function() return TitleState() end,
        ['info'] = function() return HowToPlayState() end,
        ['countdown'] = function() return CountDownState() end,
        ['play'] = function() return PlayState() end,
        ['end0'] = function() return EndingZero() end
    }
    gStateMachine:change('title')
    love.keyboard.keysPressed = {} --initical empty (part 1)
end


function love.resize(w,h)
    push:resize(w,h) -- making virtual screen responsive
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true -- calling keypressed with the key (part 2)

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then --if the key is pressed then return true or false (part 3)
        return true
    else
        return false
    end
end
-----------------------------------------------------------------------------------------------------
function love.update(dt)
    backgroundScrollTo = (backgroundScrollTo + background_scroll_speed * dt) % background_looping_point
    groundScroolTo = (groundScroolTo + ground_scroll_speed * dt) % ground_looping_point 

    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end
-----------------------------------------------------------------------------------------------------
function love.draw()
    push:start()

    love.graphics.draw(backgound, -backgroundScrollTo, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroolTo, virtual_height -140)
    push:finish()

end