tween = require "tween"

function love.load()
	--Initialize Map
	MAP_SIZE = 20
	TILE_SIZE = 16
	map = {}
	for x=1,MAP_SIZE do
		map[x] = {}
		for y=1,MAP_SIZE do
			map[x][y] = {}
		end
	end
	--Initialize Player
	player = {x=10, y=10, tween=nil}
end

function love.update(dt)
	if player.tween then player.tween:update(dt) end
end

function love.draw()
	--Draw Map
	for x, col in ipairs(map) do
		for y, tile in ipairs(col) do
			local dmns = {(x-1) * TILE_SIZE, (y-1) * TILE_SIZE, TILE_SIZE, TILE_SIZE}
			love.graphics.setColor(0, 0, 255);
			love.graphics.rectangle('fill', unpack(dmns))
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle('line', unpack(dmns))
		end
	end
	--Draw Player
	love.graphics.setColor(200,200,255)
	love.graphics.rectangle('fill',
							player.x * TILE_SIZE + TILE_SIZE/4, 
							player.y * TILE_SIZE + TILE_SIZE/4,
							TILE_SIZE/2, TILE_SIZE/2)
end

function love.mousereleased(x, y, button)
	if button == 1 then
		--player.x = math.floor(x/TILE_SIZE)
		--player.y = math.floor(y/TILE_SIZE)
		player.tween = tween.new(2, player, {x=math.floor(x/TILE_SIZE), y=math.floor(y/TILE_SIZE)})
	end
end