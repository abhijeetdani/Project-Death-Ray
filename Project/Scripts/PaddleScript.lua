function OnAfterSceneLoaded(self)
   self.map = Input:CreateMap("CameraMap")
   self.w, self.h = Screen:GetViewportSize()
   self.map:MapTrigger("X", {0, 0, self.w, self.h}, "CT_TOUCH_NORM_X")
   
   local ballEntity = Game:GetEntity("ball")
   self:AddObservedEntity(ballEntity)
end

function OnBeforeSceneUnloaded(self)
  local ballEntity = Game:GetEntity("ball")
  self:RemoveObservedEntity(ballEntity)
end

function OnObjectEnter(self, object)
  local rigidBody = object:GetComponentOfType("vHavokRigidBody")
  local paddleRB = self:GetChild(0):GetComponentOfType("vHavokRigidBody")
  if rigidBody ~= nil and paddleRB ~= nil then
    local vec1 = rigidBody:GetLinearVelocity()
    local vec2 = paddleRB:GetLinearVelocity()
    vec1.y = -vec1.y
    vec2 = vec2 * 0.5
    vec1 = vec1 + vec2
    vec1.z = 0
    vec1:normalize()
    rigidBody:SetLinearVelocity(vec1 * 4000) 
  end
end


function OnThink(self)
    local moveDelta = 2000 --movespeed
    local leftBorder = -2750
    local rightBorder = -650
    
    local x = self.map:GetTrigger("X")
    
    if(x > 0.5) or Input:IsKeyPressed(Vision.KEY_RIGHT) then
      vector = Vision.hkvVec3()
      vector.x = moveDelta;
      self:IncPosition(vector * Timer:GetTimeDiff())
      local newPos = self:GetPosition()
      
      -- make sure it does not move outside the borders
      if(newPos.x >= rightBorder) then
        newPos.x = rightBorder
        self:SetPosition(newPos)
      end
    elseif (x > 0.0) or Input:IsKeyPressed(Vision.KEY_LEFT) then
      vector = Vision.hkvVec3()
      vector.x = -moveDelta;
      self:IncPosition(vector * Timer:GetTimeDiff())
      local newPos = self:GetPosition()
      
      -- make sure it does not move outside the borders
      if(newPos.x <= leftBorder) then
        newPos.x = leftBorder
        self:SetPosition(newPos)
      end
    end
end
