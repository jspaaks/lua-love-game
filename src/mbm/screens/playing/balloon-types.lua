-- property "tenths" determines the ratio of balloons of a certain type

return {
    {
        color = {232 / 255, 86 / 255, 37 / 255, 255 / 255},   -- red
        radius = 8,
        sounds = {
            pop = love.audio.newSource("sounds/pop.wav", "static"),
            score = love.audio.newSource("sounds/hit3.wav", "static")
        },
        tenths = 2,
        value = 5
    },
    {
        color = {219 / 255, 149 / 255, 29 / 255, 255 / 255},  -- orange
        radius = 10,
        sounds = {
            pop = love.audio.newSource("sounds/pop.wav", "static"),
            score = love.audio.newSource("sounds/hit2.wav", "static")
        },
        tenths = 3,
        value = 4
    },
    {
        color = {219 / 255, 222 / 255, 80 / 255, 255 / 255},  -- yellow
        radius = 14,
        sounds = {
            pop = love.audio.newSource("sounds/pop.wav", "static"),
            score = love.audio.newSource("sounds/hit1.wav", "static")
        },
        tenths = 5,
        value = 3,
    },
}
