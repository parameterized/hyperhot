
menu = {
	state = 'main',
	btns = {}
}

function menu.addButton(t)
	local state = t.state or 'main'
	local font = t.font or fonts.f18
	local text = t.text or 'undefined'
	if not menu.btns[state] then menu.btns[state] = {} end
	table.insert(menu.btns[state], {text=text, id=t.id, font=font})
end

menu.addButton{text='Play', id='play'}
menu.addButton{text='Exit', id='exit'}

function menu.mousepressed(x, y, btn)
	local mx, my = screen2game(love.mouse.getPosition())
	for i, v in pairs(menu.btns[menu.state]) do
		local w = 70
		local x = math.floor(gsx/2 - w/2)
		local h = 30
		local y = math.floor(gsy/2 - #menu.btns[menu.state]*h/2 + (i-1)*h)
		if mx > x and mx < x + w and my > y and my < y + h then
			if v.id == 'play' then
				gamestate = 'playing'
			elseif v.id == 'exit' then
				love.event.quit()
			end
		end
	end
end

function menu.draw()
	local mx, my = screen2game(love.mouse.getPosition())
	love.graphics.clear(144, 128, 128)
	love.graphics.setShader(shaders.fontAlias)
	for i, v in pairs(menu.btns[menu.state]) do
		love.graphics.setFont(v.font)
		local w = 70
		local x = math.floor(gsx/2 - w/2)
		local h = 30
		local y = math.floor(gsy/2 - #menu.btns[menu.state]*h/2 + (i-1)*h)
		love.graphics.setLineWidth(1)
		if mx > x and mx < x + w and my > y and my < y + h then
			love.graphics.setColor(32, 32, 32, 64)
			love.graphics.rectangle('fill', x, y, w, h)
			love.graphics.rectangle('line', x, y, w, h)
			love.graphics.setColor(32, 32, 32, 128)
			love.graphics.print(v.text, math.floor(gsx/2 - v.font:getWidth(v.text)/2),
								math.floor(y + h/2 - v.font:getHeight(v.text)/2))
		else
			love.graphics.setColor(32, 32, 32, 32)
			love.graphics.rectangle('fill', x, y, w, h)
			love.graphics.rectangle('line', x, y, w, h)
			love.graphics.setColor(32, 32, 32)
			love.graphics.print(v.text, math.floor(gsx/2 - v.font:getWidth(v.text)/2),
								math.floor(y + h/2 - v.font:getHeight(v.text)/2))
		end
	end
	love.graphics.setShader()
end
