function DrawMouse(self, x, y, color)
	local size = self.MouseSize
	local dsize = size * 2
	local c = color or Vision.V_RGBA_GREEN

	Debug.Draw:Line2D(x,         y,      x + dsize, y + size,  c)
  Debug.Draw:Line2D(x,         y,      x + size,  y + dsize, c)
  Debug.Draw:Line2D(x + dsize, y+size, x + size,  y + dsize, c)
end

function OnAfterSceneLoaded(self)
	Debug:Enable(true)
	Debug:SetupLines(5)

	self.Controls = Input:CreateMap("Controls")
	self.Controls:MapTrigger("MouseClick", "MOUSE", "CT_MOUSE_LEFT_BUTTON")
	self.Controls:MapTrigger("X", "MOUSE", "CT_MOUSE_ABS_X")
	self.Controls:MapTrigger("Y", "MOUSE", "CT_MOUSE_ABS_Y")
end

function OnThink(self)
	local MouseX = self.Controls:GetTrigger("X")
	local MouseY = self.Controls:GetTrigger("Y")
	
	local dt = Timer:GetTimeDiff()
	local goal = Game:GetEntity("food") 
		if goal ~= nil then
			local start = self:GetPosition()
      local dest = goal:GetPosition()
			local path = AI:FindPath(start,dest, 20.0, -1)
			if path ~= nil then
				local numPoints = table.getn(path)
				local endPoint = path[numPoints]
				self.path = path
				self.pathProgress = 0
				self.pathLength = AI:GetPathLength(path)
			end
		else
			Debug:PrintLine("Didn't press somewhere!")
		end
	if self.path ~= nil and self.pathLength ~= 0 then
		self.pathProgress = self.pathProgress + dt * self.MovementSpeed

		if self.pathProgress > self.pathLength then
			self.pathProgress = self.pathLength
		end
		
		local point = AI:GetPointOnPath(self.path, self.pathProgress)
    local numPoint = table.getn(self.path)
		self:SetPosition(point)

		if self.pathProgress == self.pathLength then
			self.path = nil
		end
	end

	DrawMouse(self, MouseX, MouseY)
end

function OnExpose(self)
	self.MovementSpeed = 1000
	self.MouseSize = 5
end