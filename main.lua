function love.load()
  sprites = {}
  sprites.background = love.graphics.newImage('sprites/background.png')
  sprites.bullet = love.graphics.newImage('sprites/bullet.png')
  sprites.player = love.graphics.newImage('sprites/player.png')
  sprites.zombie = love.graphics.newImage('sprites/zombie.png')

  player = {}
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()
  player.x = screenWidth/2
  player.y = screenHeight/2
  player.speed = 5 * 60 -- pixels * default frame rate

  zombies = {}
end

-- updates 60fps default
function love.update(dt)
  if love.keyboard.isDown('w') then -- up
      player.y = player.y - player.speed*dt
  end

  if love.keyboard.isDown('a') then -- left
    player.x = player.x - player.speed*dt
  end

  if love.keyboard.isDown('s') then -- right
    player.y = player.y + player.speed*dt
  end

  if love.keyboard.isDown('d') then -- down
    player.x = player.x + player.speed*dt
  end

  for i, z in ipairs(zombies) do
    z.x = z.x + ( math.cos(getAngleBetweenPlayerAndZombie(z) ) * z.speed*dt )
    z.y = z.y + ( math.sin(getAngleBetweenPlayerAndZombie(z) ) * z.speed*dt )
  --  z.y = z.y + 5
  end

end


function love.draw()
  love.graphics.draw(sprites.background, 0, 0)

    -- if player.x >= screenWidth then
    --   player.x = screenWidth
    -- end
    --
    -- if player.y >= screenHeight then
    --   player.y = screenHeight
    -- end
  love.graphics.draw(sprites.player, player.x, player.y, getAngleBetweenPlayerAndMouse() , nil, nil, sprites.player:getWidth()/2, sprites.player:getHeight()/2) --love.graphics.draw(drawable, x, y, r, sx, sy, offset x axis, offset y axis, kx, ky)

  for i, z in ipairs(zombies) do
    love.graphics.draw(sprites.zombie, z.x, z.y, getAngleBetweenPlayerAndZombie(z),nil,nil,sprites.zombie:getWidth()/2, sprites.zombie:getHeight()/2)
  end
end

-- call back function when a key is pressed. Event driven
function love.keypressed(key)
  if key == "space" then
    table.insert(zombies, spawnZombie())
  end
end

-- creates new zombie object. Note, not the image!
function spawnZombie()
  local zombie = {}
  zombie.x = math.random(0, screenWidth )
  zombie.y = math.random(0, screenHeight)
  zombie.speed =  5 * 60 -- pixels * default frame rate
  return zombie
end

-- returns anlge between two points, p1(x1,y1), and p2(x2,y2) in radians
function getAngleBetweenPlayerAndMouse()
  return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end

-- returns anlge between two points, p1(x1,y1), and z1(x2,y2) in radians.
--z1 is the zombie object
function getAngleBetweenPlayerAndZombie(enemy)
  return math.atan2(player.y - enemy.y, player.x - enemy.x)
end



-- To do
--1. Work on wrap around screen for the player object.
