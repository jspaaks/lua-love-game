return {
    {
        color = {232 / 255, 86 / 255, 37 / 255, 255 / 255},   -- red
        n = 2,
        radius = 5,
        sounds = {
            pop = love.audio.newSource("sounds/pop.wav", "static"),
            score = love.audio.newSource("sounds/hit3.wav", "static")
        },
        value = 7
    },
    {
        color = {219 / 255, 149 / 255, 29 / 255, 255 / 255},  -- orange
        n = 2,
        radius = 10,
        sounds = {
            pop = love.audio.newSource("sounds/pop.wav", "static"),
            score = love.audio.newSource("sounds/hit2.wav", "static")
        },
        value = 5
    },
    {
        color = {219 / 255, 222 / 255, 80 / 255, 255 / 255},  -- yellow
        n = 2,
        radius = 14,
        sounds = {
            pop = love.audio.newSource("sounds/pop.wav", "static"),
            score = love.audio.newSource("sounds/hit1.wav", "static")
        },
        value = 3,
    },
}
