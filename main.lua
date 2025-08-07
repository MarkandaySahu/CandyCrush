---@diagnostic disable: lowercase-global
local love = require"love"
local Board = require"Board"

function Search(key,table)
    for _, value in pairs(table) do
        if (key == value) then
           return true
        end
    end
    return false
end
---------------------------------------------------------------------------------------------load
function love.load()
    math.randomseed(os.time())
    background = love.graphics.newImage("graphics/background.png")
    background2 = love.graphics.newImage("graphics/background.png")
    bg_scroll = 0
    bg_scroll_speed = 50

    play = false--state variable
    Time = 10

    board = Board()
    board:insertTiles_initial()
    board.tiles[1].box = true--box will be at first tile initially.
end
---------------------------------------------------------------------------------------------load
function love.mousepressed(x,y,button)
    if button == 1 then
        if play == false then
            if x > love.graphics.getWidth()/2-120 and x < love.graphics.getWidth()/2+120 then
                if y > love.graphics.getHeight()/2-50 and y < love.graphics.getHeight()/2+40 then
                    play = true
                end
                if y > love.graphics.getHeight()/2+50 and y < love.graphics.getHeight()/2+140 then
                    love.event.quit()
                end
            end
        end
    end
end

---------------------------------------------------------------------------------------------update
function love.update(dt)
    if play == true then
        Time = Time - dt
        if Time < 0 then
            love.event.quit()
        end
        board:match_remove(board.tiles[1].val)
        board:insertTiles()
        bg_scroll = (bg_scroll + bg_scroll_speed * dt) % 1920

        b_Index = board:box_index()
    end
end
---------------------------------------------------------------------------------------------update
function love.keypressed(key)
    if play == true then
        if key == "space" then
            Index = board:select()
        end
        if key == "w" then
            if Index then
                if Index>8 then
                    local temp = board.tiles[Index].val
                    board.tiles[Index].val = board.tiles[Index-8].val
                    board.tiles[Index-8].val = temp

                    local temp = board.tiles[Index].box
                    board.tiles[Index].box = board.tiles[Index-8].box
                    board.tiles[Index-8].box = temp

                    Index = nil
                end
            else
                if b_Index>8 then
                    if board.tiles[b_Index-8].render == true then
                        local temp = board.tiles[b_Index].box
                        board.tiles[b_Index].box = board.tiles[b_Index-8].box
                        board.tiles[b_Index-8].box = temp
                    end
                end
            end
        end
        if key == "s" then
            if Index then
                if (0<Index) and (Index<57) then
                    local temp = board.tiles[Index].val
                    board.tiles[Index].val = board.tiles[Index+8].val
                    board.tiles[Index+8].val = temp

                    local temp = board.tiles[Index].box
                    board.tiles[Index].box = board.tiles[Index+8].box
                    board.tiles[Index+8].box = temp

                    Index = nil
                end
            else
                if (0<b_Index) and (b_Index<57) then
                    if board.tiles[b_Index+8].render == true then
                        local temp = board.tiles[b_Index].box
                        board.tiles[b_Index].box = board.tiles[b_Index+8].box
                        board.tiles[b_Index+8].box = temp
                    end
                end
                
            end
        end
        L1 = {1,9,17,25,33,41,49,57,65,73}
        L2 = {8,16,24,32,40,48,56,64,72,80}

        if Search(b_Index,L2) then
            goto continue1
        end
        if key == "d" then
            if Index then
                local temp = board.tiles[Index].val
                board.tiles[Index].val = board.tiles[Index+1].val
                board.tiles[Index+1].val = temp

                local temp = board.tiles[Index].box
                board.tiles[Index].box = board.tiles[Index+1].box
                board.tiles[Index+1].box = temp

                Index = nil
            else
                if board.tiles[b_Index+1].render == true then
                    local temp = board.tiles[b_Index].box
                    board.tiles[b_Index].box = board.tiles[b_Index+1].box
                    board.tiles[b_Index+1].box = temp
                end
            end
        end
        ::continue1::
        if Search(b_Index,L1) then
            goto continue2
        end
        if key == "a" then
            if Index then
                local temp = board.tiles[Index].val
                board.tiles[Index].val = board.tiles[Index-1].val
                board.tiles[Index-1].val = temp

                local temp = board.tiles[b_Index].box
                board.tiles[Index].box = board.tiles[Index-1].box
                board.tiles[Index-1].box = temp

                Index = nil
            else
                if board.tiles[b_Index-1].render == true then
                    local temp = board.tiles[b_Index].box
                    board.tiles[b_Index].box = board.tiles[b_Index-1].box
                    board.tiles[b_Index-1].box = temp
                end
            end
        end
        ::continue2::
    end
end
---------------------------------------------------------------------------------------------draw
function love.draw()
    if play == true then
        love.graphics.draw(background,-bg_scroll,0,0,2.85,2.85)
        love.graphics.draw(background2,-bg_scroll +1920,0,0,2.85,2.85)
        board:draw()
        
        love.graphics.setColor(1,1,150/255)
        love.graphics.rectangle("fill",love.graphics.getWidth()-900,love.graphics.getHeight()/2-400,700,700)
        love.graphics.setColor(0,0,0)
        love.graphics.setFont(love.graphics.newFont(24))
        love.graphics.printf("match 3 or more tiles along x-axis.",400,love.graphics.getHeight()/2-240,love.graphics.getWidth(),"center")
        love.graphics.printf("Score: "..board.score.."  ".."Time: "..math.floor(Time),400,love.graphics.getHeight()/2-140,love.graphics.getWidth(),"center")

        love.graphics.setColor(1,1,1)

    else--Main menu screen
        love.graphics.setColor(1,1,185/255)
        love.graphics.rectangle("fill",love.graphics.getWidth()/2-300,love.graphics.getHeight()/2-300,600,600)
        love.graphics.setColor(241/255,86/255,1)
        love.graphics.setFont(love.graphics.newFont(48))
        love.graphics.printf("Match 3 X",0,love.graphics.getHeight()/2-200,love.graphics.getWidth(),"center")

        love.graphics.setColor(105/255,196/255,164/255)

        --buttons
        love.graphics.setFont(love.graphics.newFont(24))
        love.graphics.rectangle("fill",love.graphics.getWidth()/2-120,love.graphics.getHeight()/2-50,240,90)
        love.graphics.rectangle("fill",love.graphics.getWidth()/2-120,love.graphics.getHeight()/2+50,240,90)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("START",0,love.graphics.getHeight()/2-30,love.graphics.getWidth(),"center")
        love.graphics.printf("EXIT",0,love.graphics.getHeight()/2+70,love.graphics.getWidth(),"center")
    end
end
---------------------------------------------------------------------------------------------draw