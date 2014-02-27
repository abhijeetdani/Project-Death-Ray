function OnAfterSceneLoaded(self)
  local creature = Game:GetEntity("creature")
  self:AddObservedEntity(creature)
  Debug:PrintLine("Observed Entity Added")
end

function OnBeforeSceneUnloaded(self)
  local creature = Game:GetEntity("creature")
  self:RemoveObservedEntity(creature)
  Debug:PrintLine("Observed Entity Removed")
end
