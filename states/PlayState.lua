PlayState = Class{__includes = BaseState}

pipe_scroll_speed = 130
pipe_height = 1100
pipe_width = 50

bird_width = 100
bird_height = 100

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.score = 0
    self.lastPipeY = -pipe_height + math.random(900) +50
end

function PlayState:update(dt)
    self.timer = self.timer + dt --timer to spawn pipes

    ------------PIPE PAIRES------------------------------
    if self.timer > 5 then
        local y = math.max(-pipe_height + 80,
                math.min(self.lastPipeY + math.random(-200, 200), virtual_height - 600 - pipe_height))
        
        self.lastPipeY = y
        table.insert(self.pipePairs, PipePair(y))
        self.timer = 0
    end

    for k, pair in pairs(self.pipePairs) do
        if not pair.scored then
            if pair.x + pipe_width < self.bird.x then
                sounds['score']:play()
                self.score = self.score + 1
                pair.scored = true
            end
        end
        pair:update(dt)
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end
    ------------BIRD COLLIED-----------------------------
    for k,pair in pairs(self.pipePairs) do
        for l,pipe in pairs(pair.pipes) do
            if self.bird:colliedes(pipe) then
                gStateMachine:change('end0', {score = self.score})
                sounds['explosion']:play()
                sounds['hurt']:play()
            end
        end
    end

    if self.bird.y > virtual_height - 140 then
        sounds['explosion']:play()
        sounds['hurt']:play()
        gStateMachine:change('end0', {score = self.score})
    end
    -----------------------------------------------------
    self.bird:update(dt)

    if self.score > 15 then
        pipe_scroll_speed = 140
    end
    
    if self.score > 35 then
        pipe_scroll_speed = 150
    end
    
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    
    love.graphics.setFont(scoreFont)
    love.graphics.print('Score: ' ..tostring(self.score), 50, 50)
    self.bird:render()
end