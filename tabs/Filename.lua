Filename = class()

function Filename:init()
    -- you can accept and set parameters here
    self.name = nil
    self.img = nil
end

function Filename:draw()
    -- Codea does not automatically call this method
    buffer = keyboardBuffer()
    if buffer then
        fill(0, 0, 0, 255)
        fontSize(28)
        smooth()
        tw, th = textSize(buffer)
        text(buffer, WIDTH/2, HEIGHT-th/2)
    end
end

function Filename:keyboard(key)
    if key == RETURN then
        self.name = keyboardBuffer()
        finishSave(self.img)
    end
end