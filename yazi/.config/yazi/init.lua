-- No Status Bar
local old_layout = Tab.layout

Status.redraw = function()
	return {}
end
Tab.layout = function(self, ...)
	self._area = ui.Rect({
		x = self._area.x,
		y = self._area.y,
		w = self._area.w,
		h = self._area.h + 1,
	})
	return old_layout(self, ...)
end

-- Full Bolder
local type = ui.Border.PLAIN
local old_build = Tab.build

Tab.build = function(self, ...)
	local bar = function(c, x, y)
		if x <= 0 or x == self._area.w - 1 then
			return ui.Bar(ui.Bar.TOP)
		end

		return ui.Bar(ui.Bar.TOP)
			:area(ui.Rect({
				x = x,
				y = math.max(0, y),
				w = ya.clamp(0, self._area.w - x, 1),
				h = math.min(1, self._area.h),
			}))
			:symbol(c)
	end

	local c = self._chunks
	self._chunks = {
		c[1]:pad(ui.Pad.y(1)),
		c[2]:pad(ui.Pad(1, c[3].w > 0 and 0 or 1, 1, c[1].w > 0 and 0 or 1)),
		c[3]:pad(ui.Pad.y(1)),
	}

	local style = th.mgr.border_style
	self._base = ya.list_merge(self._base or {}, {
		ui.Border(ui.Border.ALL):area(self._area):type(type):style(style),
		ui.Bar(ui.Bar.RIGHT):area(self._chunks[1]):style(style),
		ui.Bar(ui.Bar.LEFT):area(self._chunks[3]):style(style),

		bar("┬", c[1].right - 1, c[1].y),
		bar("┴", c[1].right - 1, c[1].bottom - 1),
		bar("┬", c[2].right, c[2].y),
		bar("┴", c[2].right, c[2].bottom - 1),
	})

	old_build(self, ...)
end
