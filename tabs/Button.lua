Button = class()

function Button:init(label, x, y, w, h, fillColor)
    -- you can accept and set parameters here
    self.label = label
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.fillColor = fillColor or color(145, 135, 163, 255)
    local c = color(0, 0, 0, 255)
    self.strokeColor = self.fillColor:mix(c, 0.3)
    self._strokeColor = self.strokeColor
    self._fillColor = self.fillColor
end

function Button:draw()
    -- Codea does not automatically call this method
    strokeWidth(1.5)
    fill(self.fillColor)
    stroke(self.strokeColor)
    rectMode(CORNER)
    rect(self.x, self.y, 100, 60)
    textMode(CORNER)
    font("Georgia-Italic")
    fill(0, 0, 0, 255)
    fontSize(30)
    text(self.label, self.x+10, self.y+10)
end

function Button:touched(touch)
    -- Codea does not automatically call this method
    local x, y = self.x, self.y
    local w, h = self.w, self.h
    local clicked = false

    if (x <= touch.x and touch.x <= x+w) then
        if (y <= touch.y and touch.y <= y+h) then
            if touch.state == BEGAN then
                self.pressed = true
                local black = color(0, 0, 0, 255)
                self.fillColor = self.fillColor:mix(black, 0.8)
                self.strokeColor = self.strokeColor:mix(black, 0.2)
                sound(DATA, "ZgJANwAiQHM6QEBAAAAAADQfND7Cvvs+fwBAf0BAQEA8QEBA")
            elseif touch.state == ENDED and self.pressed then
                clicked = true
            end
        end
    end
    
    if self.pressed and touch.state == ENDED then
        -- reset state
        self.pressed = false
        self.strokeColor = self._strokeColor
        self.fillColor = self._fillColor
    end
    
    if clicked then
        self:clicked()
    end
end

function Button:clicked()
    -- redefine this in subclasses
end