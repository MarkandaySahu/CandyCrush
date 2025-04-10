local love = require"love"

function Board()
    function Search(key,table)
        for _, value in pairs(table) do
            if (key == value) then
               return true
            end
        end
        return false
    end
    Colors = {
        [1] = {r = 0,g = 0,b = 0},
        [2] = {r = 0,g = 0,b = 1},
        [3] = {r = 0,g = 1,b = 0},
        [4] = {r = 0,g = 1,b = 1},
        [5] = {r = 1,g = 0,b = 0},
        [6] = {r = 1,g = 0,b = 1},
        [7] = {r = 1,g = 1,b = 0},
        [8] = {r = 1,g = 1,b = 1}
    }
    return{
        score = 0,
        tiles = {},
        match_remove =function (self,i_val)
           local L = {1,9,17,25,33,41,49,57,65,73}
           local L2 = {8,16,24,32,40,48,56,64,72,80}
           local var,match=i_val,1
            for k, tile in pairs(self.tiles) do
                if var==tile.val and (not Search(k,L)) then
                    match = match + 1
                    if match >= 3 and (Search(k,L2)) then
                        while match > 0 do
                            self.tiles[k-match-1].render = false
                            match = match - 1
                        end
                        match = 1
                        Time = Time + 4
                        self.score = self.score + 10
                    end
                elseif match >= 3 and (not Search(k,L)) then
                    while match > 0 do
                        self.tiles[k-match].render = false
                        match = match - 1
                    end
                    match = 1
                    Time = Time + 4
                    self.score = self.score + 10
                end
                var = tile.val
                if Search(k,L) then
                    match = 1
                end
            end
        end,
        insertTiles=function (self)
            for _, tile in pairs(self.tiles) do
                if tile.render == false then
                    tile.val = math.random(1,8)
                    tile.render = true
                end
            end
        end,
        select =function (self)
            for _, tile in pairs(self.tiles) do
                tile.selected =false
                if tile.box == true then
                    tile.selected = true
                    I = _
                end
            end
            return I
        end,
        box_index=function (self)
            for _, tile in pairs(self.tiles) do
                if tile.box == true then
                    return _
                end
            end
        end,
        insertTiles_initial =function (self)
            for y = 1, 8 do
                for x = 1, 8 do
                    local tile = {
                        box = false,
                        selected = false,
                        render = true,
                        val = math.random(1,8),
                        x = x * 96,
                        y = y * 96
                    }
                    table.insert(self.tiles,tile)
                end
            end
        end,
        draw =function (self)
            for _, tile in pairs(self.tiles) do
                if tile.render == true then
                    love.graphics.setColor(Colors[tile.val].r,Colors[tile.val].g,Colors[tile.val].b)
                    love.graphics.rectangle("fill",tile.x,tile.y,80,80)
                    if tile.box == true then
                        love.graphics.setLineWidth(6)
                        love.graphics.setColor(1,0,0)
                        love.graphics.rectangle("line",tile.x-8,tile.y-8,96,96)
                    end
                end
            end
            love.graphics.setColor(1,1,1)
        end
    }
end

return Board