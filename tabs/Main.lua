-- Cropper
-- simple app to aid in image cropping

-- Use this function to perform your initial setup
function setup()
    displayMode(FULLSCREEN)
    img = readImage("Documents:ty")
  
    w, h = spriteSize(img)  
    sx, sy = 1.0, 1.0
    crop = Crop(w, h)
    
    filename = Filename()
    loadbutton = LoadButton()
    
    local c = color(88, 89, 135, 255)
    
    cropbutton = Button("CROP", 250, 650, 100, 60, c)
    cropbutton.clicked = cropSelection
    
    savebutton = Button("SAVE", 355, 650, 100, 60, c)
    savebutton.clicked = saveSelection
    
    -- line based rect
    do
        local _rect = rect
        lrect = function(x, y, w, h)
            pushStyle()
            noStroke()
            _rect(x, y, w, h)
            popStyle()
            pushStyle()
            smooth()
            lineCapMode(PROJECT)
            local x1, x2 = x-w/2, x+w/2
            local y1, y2 = y-h/2, y+h/2
            line(x1, y1, x2, y1)
            line(x2, y1, x2, y2)
            line(x2, y2, x1, y2)
            line(x1, y2, x1, y1)
            popStyle()
        end
    end
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(111, 111, 187, 255)
    resetStyle()

    -- This sets the line thickness
    noSmooth()
    strokeWidth(1)
    
    -- Do your drawing here   
    rectMode(CENTER)
    fill(92, 92, 92, 255)
    --lrect(WIDTH/2.0, HEIGHT/2.0, w*sx+2, h*sy+2)
    stroke(214, 209, 42, 255)
    --noFill()
    lrect(WIDTH/2.0, HEIGHT/2.0, math.ceil(w*sx+2), h*sy+2)

    smooth() 
    pushMatrix()
    translate(WIDTH/2, HEIGHT/2)
    scale(sx,sy)
    sprite(img)
    popMatrix()
      
    crop:draw()
    filename:draw()
    loadbutton:draw() 
    cropbutton:draw()
    savebutton:draw()
end

function touched(touch)
    crop:touched(touch)
    loadbutton:touched(touch)
    cropbutton:touched(touch)
    savebutton:touched(touch)
end

function cropAndSave()    
    newImg = getCroppedImage()
    startSave(newImg)
end

function getCroppedImage()
    left, right, top, bottom = crop:getCrop()
    return img:copy(
        left, bottom,
        (right - left)+1,
        (top - bottom)+1)
end   

function startSave(img)
    filename.img = img
    showKeyboard()
end

function keyboard(key)
    filename:keyboard(key)
end

function finishSave(newImg)
    saveImage("Documents:"..filename.name, newImg)
    print("saved as "..filename.name)
    hideKeyboard()
    cropIt(newImg)
end

function cropIt(newImg)
    -- crop the image   
    img = newImg
    w, h = spriteSize(img)
    crop = Crop(w, h)
end

function cropSelection(_)
    cropIt(getCroppedImage())
end

function saveSelection(_)
    startSave(img)
end