local factionBoxGUID = "" -- Insert the faction box GUID here and everything else should be fine

function onLoad(save_state)
  local params = {
    label = "Play Faction",
    click_function = "pickFaction",
    function_owner = self,
    position = {0.7, 0.1, -0.9},
    width          = 360,
    height         = 10,
    font_size      = 60,
    tooltip = "Loads this faction and all materials into your play area"
  }
  self.createButton(params)

  local params = {
    label = "Setup AI",
    click_function = "aiFaction",
    function_owner = self,
    position = {0.7, 0.1, 0.9},
    width          = 360,
    height         = 10,
    font_size      = 60,
    tooltip = "Does a limited setup of this faction for use as an AI player in solo and co-op"
  }
  self.createButton(params)
end

function pickFaction(obj, player)
  Global.call("setupFaction", {self, player, factionBoxGUID})
end

function aiFaction(obj)
  Global.call("setupFactionAI", {self, factionBoxGUID})
end
