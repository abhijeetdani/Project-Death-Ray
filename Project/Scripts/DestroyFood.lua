function OnObjectEnter(self, object)
if object:GetKey() == "creature" then
  local rigidBody = self:GetChild(0):GetComponentOfType("vHavokRigidBody")
  if rigidBody ~= nil then
    Debug:PrintLine("rigidBodyFound")
    rigidBody:Remove()
    self:GetChild(0):SetVisible(false)
    local creature = Game:GetEntity("creature")
    self:SetVisible(false)
    self:Remove()
  else
    Debug:PrintLine("rigidBody Not Found******************")
  end
end
end