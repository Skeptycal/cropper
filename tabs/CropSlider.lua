CropSlider = class()

function CropSlider:init(x, y)
    -- you can accept and set parameters here
    self.x = math.floor(x)
    self.y = math.floor(y)
    self.nx = nil
    self.ny = nil
end

function CropSlider:draw()
    -- Codea does not automatically call this method
    strokeWidth(1.5)
    stroke(18, 18, 18, 255)
    fill(255, 255, 255, 229)
    ellipse(self.x, self.y, 12)
end

function CropSlider:touched(touch)
    -- Codea does not automatically call this method
    if touch.state == MOVING then
        if self:touchedCloseToMe(touch) then
            self.x, self.y = touch.x, touch.y
            self.nx.x = self.x
            self.ny.y = self.y
            return true
        end
    end
    return false
end

function CropSlider:touchedCloseToMe(touch)
    local R = 25
    local hor = math.abs(touch.x - self.x)
    local vert = math.abs(touch.y - self.y)
    return hor < R and vert < R
end


