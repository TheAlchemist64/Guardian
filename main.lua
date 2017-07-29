tween = require 'tween'
Camera = require 'hump.camera'

function love.load()
	--Initialize Map
	MAP_SIZE = 20
	TILE_SIZE = 32
	map = {}
	for x=1,MAP_SIZE do
		map[x] = {}
		for y=1,MAP_SIZE do
			map[x][y] = {}
		end
	end
	--Initialize Player
	player = {x=1, y=1, tween=nil, 
		getX=function(self) 
			return (self.x - 1) * TILE_SIZE + TILE_SIZE/4
		end,
		getY=function(self)
			return (self.y - 1) * TILE_SIZE + TILE_SIZE/4
		end,
		center=function(self)
			return self:getX() + TILE_SIZE/4, self:getY() + TILE_SIZE/4
		end}
	--Initialize Camera
	camera = Camera(player:center())
end

function love.update(dt)
	--Move Player
	if player.tween then player.tween:update(dt) end
	--Move Camera
	local px, py = player:center()
	local dx,dy = px - camera.x, py - camera.y
    camera:move(dx/2, dy/2)
end

function love.draw()
	camera:attach()
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
	love.graphics.setColor(255,255,0)
	love.graphics.rectangle('fill',
							player:getX(), 
							player:getY(),
							TILE_SIZE/2, TILE_SIZE/2)
	camera:detach()
end

function love.mousereleased(x, y, button)
	if button == 1 then
		x, y = camera:mousePosition()
		local newx = math.floor(x/TILE_SIZE) + 1
		local newy = math.floor(y/TILE_SIZE) + 1
		player.tween = tween.new(2, player, {x=newx, y=newy})
	end
end