function OnAfterSceneLoaded()
   local camShape = Game:GetEntity("camPosEntity")
   local mainCam = Game:GetCamera()
   mainCam:SetUseEulerAngles(true)
   mainCam:SetPosition(camShape:GetPosition())
   mainCam:SetOrientation(camShape:GetOrientation())
end
