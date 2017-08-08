
ssx = love.graphics.getWidth()
ssy = love.graphics.getHeight()
gsx = 480
gsy = 270
gameScale = 2
time = 0

function screen2game(x, y)
	x = x - (ssx-gameScale*gsx)/2
	x = x / gameScale
	y = y - (ssy-gameScale*gsy)/2
	y = y / gameScale
	return math.floor(x), math.floor(y)
end

love.filesystem.setIdentity(love.window.getTitle())
math.randomseed(love.timer.getTime())

love.graphics.setDefaultFilter('nearest', 'nearest', 0)
love.graphics.setLineStyle('rough')

gamestate = 'menu'

gfx = {
	gamepad = {
		base = love.graphics.newImage('gfx/gamepad/base.png'),
		a = love.graphics.newImage('gfx/gamepad/a.png'),
		b = love.graphics.newImage('gfx/gamepad/b.png'),
		x = love.graphics.newImage('gfx/gamepad/x.png'),
		y = love.graphics.newImage('gfx/gamepad/y.png'),
		back = love.graphics.newImage('gfx/gamepad/back.png'),
		guide = love.graphics.newImage('gfx/gamepad/guide.png'),
		start = love.graphics.newImage('gfx/gamepad/start.png'),
		leftstick = love.graphics.newImage('gfx/gamepad/leftstick.png'),
		rightstick = love.graphics.newImage('gfx/gamepad/rightstick.png'),
		leftshoulder = love.graphics.newImage('gfx/gamepad/leftshoulder.png'),
		rightshoulder = love.graphics.newImage('gfx/gamepad/rightshoulder.png'),
		dpup = love.graphics.newImage('gfx/gamepad/dpup.png'),
		dpdown = love.graphics.newImage('gfx/gamepad/dpdown.png'),
		dpleft = love.graphics.newImage('gfx/gamepad/dpleft.png'),
		dpright = love.graphics.newImage('gfx/gamepad/dpright.png')
	}
}
function recSetFilter(e)
	if type(e) == "table" then
		for _, v in pairs(e) do
			recSetFilter(v)
		end
	else
		e:setFilter('nearest', 'nearest')
	end
end
recSetFilter(gfx)

shaders = {
	fontAlias = love.graphics.newShader('shaders/fontAlias.glsl')
}

fonts = {
	f10 = love.graphics.newFont(10),
	f12 = love.graphics.newFont(12),
	f18 = love.graphics.newFont(18),
	f24 = love.graphics.newFont(24)
}
for _, v in pairs(fonts) do
	v:setFilter('nearest', 'nearest', 0)
end

canvases = {
	game = love.graphics.newCanvas(gsx, gsy)
}
for _, v in pairs(canvases) do
	v:setFilter('nearest', 'nearest')
end
