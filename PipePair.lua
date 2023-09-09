PipePair = Class{}

gap_height = 210                 


function PipePair:enter(params)
    self.score = params.score
end

function PipePair:init(y)

    self.x = virtual_width + 32
    self.y = y

    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + pipe_height + gap_height)
    }

    self.remove = false
    self.remove = false
    end

function PipePair:update(dt)

    if self.x > - pipe_width - 200 then
        self.x = self.x - pipe_scroll_speed * dt
        self.pipes['lower'].x = self.x 
        self.pipes['upper'].x = self.x 
    else
        self.remove = true
    end
end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end