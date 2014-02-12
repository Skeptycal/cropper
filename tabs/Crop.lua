Crop = class()

function Crop:init(w, h)
    -- you can accept and set parameters here
    self.w = w
    self.h = h
    self.nw = CropSlider(WIDTH/2 - w/2*sx, HEIGHT/2 + h/2*sy)
    self.ne = CropSlider(WIDTH/2 + w/2*sx, HEIGHT/2 + h/2*sy)
    self.sw = CropSlider(WIDTH/2 - w/2*sx, HEIGHT/2 - h/2*sy)
    self.se = CropSlider(WIDTH/2 + w/2*sx, HEIGHT/2 - h/2*sy)
    
    -- related sliders
    self.nw.nx, self.nw.ny = self.sw, self.ne
    self.ne.nx, self.ne.ny = self.se, self.nw
    self.sw.nx, self.sw.ny = self.nw, self.se
    self.se.nx, self.se.ny = self.ne, self.sw
end

function Crop:draw()
    -- Codea does not automatically call this method    
    noSmooth()
    strokeWidth(1)
    stroke(0, 0, 0, 255)
    fill(203, 203, 203, 64)
    rectMode(CORNERS)
    rect(self.sw.x, self.sw.y, self.ne.x, self.ne.y)
    strokeWidth(1)
    stroke(255, 255, 255, 255)
    rect(self.sw.x-1, self.sw.y-1, self.ne.x+1, self.ne.y+1)
    
    stroke(0, 0, 0, 129)
    local cx = 0.5 * (self.sw.x + self.ne.x)
    local cy = 0.5 * (self.sw.y + self.ne.y)
    line(cx, self.sw.y, cx, self.ne.y)
    line(self.sw.x, cy, self.ne.x, cy)
    
    self.nw:draw()
    self.ne:draw()
    self.sw:draw()
    self.se:draw()   
    
    local cw = math.floor(math.abs(self.sw.x - self.ne.x)/sx)
    local ch = math.floor(math.abs(self.sw.y - self.ne.y)/sy)
    fill(0, 0, 0, 255)
    fontSize(28)
    t = ""..cw.."x"..ch
    tw, th = textSize(t)
    text(t, WIDTH-tw/2-10, HEIGHT-th/2)
end

function Crop:touched(touch)
    -- Codea does not automatically call this method
    local cornerMoved = self.nw:touched(touch)
            or self.ne:touched(touch)
            or self.sw:touched(touch)
            or self.se:touched(touch)
        
    if not cornerMoved then
        -- check if need to move the entire box
        if self:touchedInside(touch) then
            for i, c in pairs(
                    {self.ne, self.nw, self.sw, self.se}) do
                c.x = c.x + touch.deltaX
                c.y = c.y + touch.deltaY
            end
        end
    end
end

function Crop:touchedInside(touch)
    local cw = math.abs(self.ne.x - self.sw.x)
    local ch = math.abs(self.ne.y - self.sw.y)
    local left = touch.x - math.min(self.sw.x, self.ne.x)
    local right = math.max(self.ne.x, self.sw.x) - touch.x
    local top = math.max(self.ne.y, self.sw.y) - touch.y
    local bottom = touch.y - math.min(self.sw.y, self.ne.y)
    local M = 0.1
    return (touch.state == MOVING)
        and right >= cw*M and left >= cw*M
        and top >= ch*M and bottom >= ch*M
end

function Crop:getCrop()
    left = (math.min(self.sw.x, self.ne.x) - WIDTH/2)/sx + math.floor(self.w/2)
    right = (math.max(self.sw.x, self.ne.x) - WIDTH/2)/sx + math.ceil(self.w/2)
    top = (math.max(self.sw.y, self.ne.y) - HEIGHT/2)/sy + math.ceil(self.h/2)
    bottom = (math.min(self.sw.y, self.ne.y) - HEIGHT/2)/sy + math.floor(self.h/2)
    
    return math.ceil(left), math.floor(right), 
            math.floor(top), math.ceil(bottom)
end
    
