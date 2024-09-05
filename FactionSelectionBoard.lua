local factions = {
  {name = 'Brawnen', GUID = 'BrawnenBox',factionColour = {.7,.7,.7}, previewImage = 'BrawnenCard'},
  {name = 'Grovetenders', GUID = 'GrovetendersBox',factionColour = {.28,.26,.09}},
  {name = 'Heirs', GUID = 'HeirsBox',factionColour = {.29,.14,.27}},
  {name = 'Narora', GUID = 'NaroraBox',factionColour = {0,.41,.47}},
  {name = 'Griege', GUID = 'GriegeBox',factionColour = {.26,.17,.09}},
  {name = 'Horizons Wrath', GUID = 'HorizonsWrathBox',factionColour = {.01,.20,.25}},
  {name = 'Uprising', GUID = 'UprisingBox',factionColour = {.44,.41,.38}},
}

function onLoad(saveState)

  if saveState ~= "" then
    local saveData = JSON.decode(saveState)
    factionSetup = saveData.factionSetup
  end

  if factionSetup ~= true then

    local x = -1.3
    local y = 0.22
    local z = -0.8

    for i in ipairs(factions) do
      local params = {
        label = factions[i].name,
        click_function = "preview_"..factions[i].name,
        function_owner = self,
        position = {x, y, z},
        width          = 400,
        height         = 30,
        font_size      = 50,
        tooltip = "Displays the information for the "..factions[i].name,
      }
      z = z + .25
      self.setVar(params.click_function,
        function(obj, player)
            displayFactionInfo(obj, player, factions[i].name)
        end)
      self.createButton(params)
    end

  end
  return JSON.encode(saveData)
end

function onSave()
  local saveData = {
    ["factionSetup"] = factionSetup
  }
  return JSON.encode(saveData)
end

function displayFactionInfo(obj, player, factionName)
  local buttonsTable = self.getButtons()
  local buttonColour = {1,1,1}
  local factionGUID = ""
  for i in ipairs(buttonsTable) do
    if buttonsTable[i].label == "Play Faction" then
      self.removeButton(i-1)
    end
    if buttonsTable[i].label == factionName then
      for n in ipairs(factions) do
        if factionName == factions[n].name then
          buttonColour = factions[n].factionColour
          factionGUID = factions[n].GUID
        end
      end
      self.editButton({index = i-1, color = buttonColour})
    else
      self.editButton({index = i-1, color = {1,1,1}})
    end
  end

  local params = {
    label = "Play Faction",
    click_function = "pickFaction "..factionName,
    function_owner = self,
    position = {1.2, 0.2, 0.8},
    width          = 360,
    height         = 10,
    font_size      = 60,
    tooltip = "Loads the "..factionName.." and all their materials into your play area"
  }

  self.setVar(params.click_function,
    function(obj, player)
        pickFaction(obj, player, factionGUID)
    end)

  self.createButton(params)
end

function pickFaction(obj, player, factionGUID)
  Global.call("setupFaction", {self, player, factionGUID})
end
