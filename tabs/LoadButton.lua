LoadButton = class()

function LoadButton:init()
    self.myColor = color(0, 0, 0, 255)
end

function LoadButton:draw()
    -- Codea does not automatically call this method
    strokeWidth(1)
    fill(0, 0, 255, 255)
    stroke(self.myColor)
    rectMode(CORNER)
    rect(50, 650, 100, 60)
    textMode(CORNER)
    font("Futura-CondensedExtraBold")
    fill(0, 0, 0, 255)
    fontSize(30)
    text("LOAD", 60, 660)
    
end

function LoadButton:touched(touch)
    -- Codea does not automatically call this method
    if 50 < touch.x and touch.x < 150 then
        if 650 < touch.y and touch.y < 720 then
            if touch.state == BEGAN then
                self.myColor = color(255, 255, 255, 255)
            end
            if touch.state == ENDED then
                self.myColor = color(0, 0, 0, 255)
                for k,v in ipairs(spriteList("Documents")) do
                    print(k..": "..v)
                end
            end
        end
    end
end