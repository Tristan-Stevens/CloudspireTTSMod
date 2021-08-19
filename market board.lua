function onLoad(save_state)
  local params = {
    label = "Refill",
    click_function = "marketFill",
    function_owner = Global,
    position = {0.7, 0.2, -0.85},
    width          = 200,
    height         = 60,
    font_size      = 35,
    color          = {r=.3,g=.3,b=.3},
    font_color     = {r=.8,g=.8,b=.8},
    scale          = {x=1,y=1,z=1},
    tooltip = "Fill empty spots in the market (includes earthscapes)"
  }
  self.createButton(params)

  local params = {
    label = "Refresh",
    click_function = "marketRefresh",
    function_owner = Global,
    position = {1.05, 0.2, -0.85},
    width          = 200,
    height         = 60,
    font_size      = 35,
    color          = {r=.3,g=.3,b=.3},
    font_color     = {r=.8,g=.8,b=.8},
    scale          = {x=1,y=1,z=1},
    tooltip = "Discard the market and create a new one"
  }
  self.createButton(params)

  local params = {
    label = "Market Size",
    input_function = "setMarket",
    function_owner = Global,
    position = {0.3, 0.2, -0.9},
    width          = 200,
    height         = 80,
    font_size      = 35,
    color          = {r=.3,g=.3,b=.3},
    font_color     = {r=.8,g=.8,b=.8},
    scale          = {x=1,y=1,z=1},
    tooltip = "How many market chips are there this game?",
    validation = 2,
    alignment = 4,
  }
  self.createInput(params)

  local params = {
    label = "Reshuffle In",
    click_function = "marketDiscardRefresh",
    function_owner = Global,
    position = {0.98, 0.2, -.1},
    width          = 150,
    height         = 50,
    font_size      = 25,
    color          = {r=.3,g=.3,b=.3},
    font_color     = {r=.8,g=.8,b=.8},
    scale          = {x=1,y=1,z=1},
    tooltip = "Shuffle Market Discard into Market Stack"
  }
  self.createButton(params)

  local params = {
    label = "Reshuffle In",
    click_function = "earthscapesDiscardRefresh",
    function_owner = Global,
    position = {0.88, 0.2, .85},
    width          = 150,
    height         = 50,
    font_size      = 25,
    color          = {r=.3,g=.3,b=.3},
    font_color     = {r=.8,g=.8,b=.8},
    scale          = {x=1,y=1,z=1},
    tooltip = "Shuffle Earthscapes Discard into Earthscape Stack"
  }
  self.createButton(params)
end
