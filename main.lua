---@diagnostic disable: lowercase-global
local love = require"love"
local Timer = require"knife.timer"
local board = require"Board"

function love.load()
    background = love.graphics.newImage("graphics/background.png")
    bg_scroll = 0
    bg_scroll_speed = 50
end
---------------------------------------------------------------------
function love.update(dt)
    bg_scroll = (bg_scroll + bg_scroll_speed * dt) % 998.4
end
---------------------------------------------------------------------
function love.draw()
    love.graphics.draw(background,-bg_scroll,0,0,2.85,2.85)
end