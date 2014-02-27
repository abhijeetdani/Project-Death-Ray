function OnObjectEnter(self, object)
  if(object:GetKey() == "ball") then
    local rigidBody = object:GetComponentOfType("vHavokRigidBody")
    if rigidBody ~= nil then
      rigidBody:SetLinearVelocity(Vision.hkvVec3())
      rigidBody:SetPosition(Vision.hkvVec3(-1850, 1200, 130))
    end
  end
end
