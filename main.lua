
require 'loadassets'
require 'camera'
require 'menu'

function love.load()

end

function love.update(dt)
	time = time + dt
end

function love.mousepressed(x, y, btn, isTouch)
	if gamestate == 'menu' then
		menu.mousepressed(x, y, btn)
	elseif gamestate == 'playing' then

	end
end

function love.keypressed(k, scancode, isrepeat)
	if k == 'escape' then
		gamestate = 'menu'
	end
end

function love.gamepadpressed(joystick, button)
	if not mainJoystick then
		if button == 'start' then
			mainJoystick = joystick
		end
	else

	end
end

function love.joystickremoved(joystick)
	if joystick.id == mainJoystick.id then
		mainJoystick = nil
	end
end

function love.draw()
	love.graphics.setCanvas(canvases.game)
	if gamestate == 'menu' then
		menu.draw()
		love.graphics.setColor(255, 255, 255, mainJoystick and 255 or 32)
		love.graphics.draw(gfx.gamepad.base, math.floor(gsx - gfx.gamepad.base:getWidth()*1.5),
							math.floor(gsy - gfx.gamepad.base:getHeight()*1.5))
		if not mainJoystick then
			love.graphics.setColor(255, 255, 255, 32 + (math.sin(time*3)*0.5+0.5)*224)
			love.graphics.draw(gfx.gamepad.start, math.floor(gsx - gfx.gamepad.start:getWidth()*1.5),
								math.floor(gsy - gfx.gamepad.start:getHeight()*1.5))
		end
	elseif gamestate == 'playing' then
		love.graphics.clear(128, 192, 192)
		if mainJoystick then
			love.graphics.setColor(64, 64, 64)
			local jx, jy = mainJoystick:getGamepadAxis('leftx'), mainJoystick:getGamepadAxis('lefty')
			love.graphics.circle('fill', gsx/2 + jx*gsx/2, gsy/2 + jy*gsy/2, 6)
		else
			love.graphics.setColor(64, 64, 64)
			local mx, my = screen2game(love.mouse.getPosition())
			love.graphics.circle('fill', mx, my, 6)
		end
	end
	love.graphics.setCanvas()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(canvases.game, 0, 0, 0, gameScale, gameScale)
end
