local aiStartPos = Vector(-51.5, 1.50, 16)
local posDiff = Vector(-3,1.55,8)

function onLoad(saveData)

  if saveState ~= "" then
    local saveData = JSON.decode(saveData)
    setupComplete = saveData.setupComplete
    setupHide = saveData.setupHide
    aiPlayers = saveData.aiPlayers or 0
    soloPvE = saveData.soloPvE or false
    coopPvE = saveData.coopPvE or false
    factionSetup = saveData.factionSetup or false

    if setupComplete ~= true then
      UI.show("modeselect")
    end

    --used for the player mat reset buttons on the bottom right of the table
    PLAYER_OBJ = {
      ["blue"] = {obj = getObjectFromGUID("bed733"), pos = {-45.00, 5.00, -38.00}},
      ["blueBoard"] = {obj = getObjectFromGUID("9b5836"), pos = {-44.94, 1.47, -27.56}},
      ["red"] = {obj = getObjectFromGUID("160849"), pos = {-15.00, 5.00, -38.00}},
      ["redBoard"] = {obj = getObjectFromGUID("ad5f9f"), pos = {-14.94, 1.40, -27.56}},
      ["white"] = {obj = getObjectFromGUID("cbb0b9"), pos = {15.00, 5.00, -38.00}},
      ["whiteBoard"] = {obj = getObjectFromGUID("23f216"), pos = {15.06, 1.37, -27.56}},
      ["green"] = {obj = getObjectFromGUID("6c701a"), pos = {45.00, 5.00, -38.00}},
      ["greenBoard"] = {obj = getObjectFromGUID("a8865b"), pos = {45.06, 1.37, -27.56}}
    }

    STARTING_OBJ = {
      ["eventCards"]              = {obj = getObjectFromGUID("930936"), pos = {22.00, 1.62, -15.07}, rot = {0.02, 180.00, 0.08}},
      ["seekersEvents"]           = {obj = getObjectFromGUID("e306b4"), pos = {-75.45, 2.30, -15.65}, rot = {359.98, 179.97, 0.12}},
      ["bountyEvents"]            = {obj = getObjectFromGUID("e22bc7"), pos = {-73.11, 2.30, -15.72}, rot = {359.98, 179.99, 0.12}},
      ["nonAnomalyEvents"]        = {obj = getObjectFromGUID("ccdeb9"), pos = {-78.07, 2.27, -15.65}, rot = {359.98, 179.99, 0.12}},
      ["relicCards"]              = {obj = getObjectFromGUID("026d80"), pos = {21.99, 1.54, -10.98}, rot = {0.02, 180.01, 0.08}},
      ["pvpRelics"]               = {obj = getObjectFromGUID("780cbc"), pos = {-78.15, 2.28, -12.43}, rot = {359.98, 180.00, 0.12}},
      ["seekersRelics"]           = {obj = getObjectFromGUID("ff5030"), pos = {-75.49, 2.28, -12.58}, rot = {359.98, 180.00, 0.12}},
      ["seekersRelicsPvP"]        = {obj = getObjectFromGUID("3b0cf0"), pos = {-73.10, 2.26, -12.62}, rot = {359.98, 180.00, 0.12}},
      ["bountyRelics"]            = {obj = getObjectFromGUID("77e765"), pos = {-67.79, 2.29, -12.70}, rot = {359.98, 179.98, 0.12}},
      ["bountyRelicsPvP"]         = {obj = getObjectFromGUID("30be90"), pos = {-70.33, 2.29, -12.77}, rot = {359.98, 179.99, 0.12}},

      ["marketBag"]               = {obj = getObjectFromGUID("a403e7"), pos = {22.58, 2.16, 7.09}, rot = {0.02, 180.00, 180.08}},
      ["marketDiscard"]           = {obj = getObjectFromGUID("e67ec1"), pos = {36.93, 1.15, 6.82}, rot = {359.98, 0.00, 359.92}},
      ["seekersMarket"]           = {obj = getObjectFromGUID("72b61b"), pos = {-70.37, 2.82, -2.98}, rot = {359.98, 180.02, 180.12}},
      ["uprisingMarket"]          = {obj = getObjectFromGUID("7f0887"), pos = {-70.37, 2.82, -4.98}, rot = {359.98, 179.98, 180.12}},
      ["timothy"]                 = {obj = getObjectFromGUID("0497f4"), pos = {-70.37, 2.22, -6.96}, rot = {359.98, 180.01, 0.12}},

      ["startingLandmarks"]       = {obj = getObjectFromGUID("a36c60"), pos = {-22.73, 2.13, -4.73}, rot = {0.02, 180.47, 180.08}},
      ["otherLandmarks"]          = {obj = getObjectFromGUID("6d2ce9"), pos = {-22.75, 2.13, -11.74}, rot = {0.02, 179.94, 180.08}},
      ["grailGoats"]              = {obj = getObjectFromGUID("1a2eb9"), pos = {-66.93, 2.20, 12.92}, rot = {359.98, 180.02, 0.12}},
      ["visionStone"]             = {obj = getObjectFromGUID("a4654d"), pos = {-66.93, 2.21, 10.93}, rot = {359.98, 180.02, 0.12}},
      ["altarOfAggression"]       = {obj = getObjectFromGUID("5d59d6"), pos = {-66.83, 2.21, 9.06}, rot = {359.97, 185.76, 0.11}},
      ["ancientTraxxyr"]          = {obj = getObjectFromGUID("9e201f"), pos = {-22.17, 1.51, 2.98}, rot = {0.02, 180.01, 0.08}},

      ["islandsBag"]              = {obj = getObjectFromGUID("1324dc"), pos = {-41.11, 1.61, 27.83}, rot = {0.08, 119.94, 0.03}},
      ["isle1"]                   = {obj = getObjectFromGUID("ca5a8c"), pos = {-51.00, 1.63, 27.43}, rot = {359.92, 299.96, 359.97}},
      ["isle22"]                  = {obj = getObjectFromGUID("a8e8d1"), pos = {-77.26, 2.29, 8.94}, rot = {0.09, 119.99, 0.07}},
      ["isle23"]                  = {obj = getObjectFromGUID("bf7b16"), pos = {-77.26, 2.30, -0.99}, rot = {359.89, 239.98, 0.04}},
      ["earthscapesBag"]          = {obj = getObjectFromGUID("0d19a6"), pos = {22.58, 1.53, -0.99}, rot = {0.02, 180.00, 0.08}},
      ["earthscape24"]            = {obj = getObjectFromGUID("89b3ee"), pos = {-80.31, 2.34, -7.37}, rot = {359.89, 270.03, 359.98}},
      ["earthscape25"]            = {obj = getObjectFromGUID("ab4fa6"), pos = {-73.17, 2.32, -7.52}, rot = {359.88, 270.03, 359.98}},
      ["earthscape26"]            = {obj = getObjectFromGUID("85dac4"), pos = {-77.03, 2.42, -7.65}, rot = {358.47, 29.98, 182.73}},
      ["earthscapesDiscard"]      = {obj = getObjectFromGUID("96b0df"), pos = {35.58, 1.53, -0.99}, rot = {0.02, 180.00, 0.08}},

      ["anomalyPortal1"]          = {obj = getObjectFromGUID("05e607"), pos = {-66.93, 2.21, 0.99}, rot = {359.98, 180.03, 0.12}},
      ["anomalyPortal2"]          = {obj = getObjectFromGUID("186e87"), pos = {-63.37, 2.20, 1.01}, rot = {359.98, 180.48, 0.11}},
      ["anomalyLandmarks"]        = {obj = getObjectFromGUID("124b2f"), pos = {-65.21, 2.80, 3.95}, rot = {359.98, 180.00, 180.12}},

      ["ruleBook"]                = {obj = getObjectFromGUID("bf78dd"), pos = {-30.43, 1.53, 28.10}, rot = {0.02, 179.99, 0.08}},
      ["rulesReference"]          = {obj = getObjectFromGUID("344a43"), pos = {-20.15, 1.52, 28.35}, rot = {0.02, 179.99, 0.08}},
      ["quickReference"]          = {obj = getObjectFromGUID("3a35cf"), pos = {-10.12, 1.52, 28.09}, rot = {0.02, 180.00, 0.08}},
      ["portalSeekersCard"]       = {obj = getObjectFromGUID("73bf98"), pos = {0.18, 1.49, 27.76}, rot = {0.02, 180.18, 0.08}},
      ["talentsSheet1"]           = {obj = getObjectFromGUID("7f22d1"), pos = {22.54, 1.46, 26.77}, rot = {0.02, 180.00, 0.08}},
      ["talentsSheet2"]           = {obj = getObjectFromGUID("244149"), pos = {41.52, 1.53, 26.77}, rot = {0.02, 180.00, 180.08}},
      ["aiTalentList"]            = {obj = getObjectFromGUID("655bfa"), pos = {47.73, 1.42, 1.32}, rot = {0.02, 180.01, 0.08}},
      ["masterTalentList"]        = {obj = getObjectFromGUID("5ee78e"), pos = {47.74, 1.41, -11.55}, rot = {0.02, 180.01, 0.08}},
      ["soloScenarios"]           = {obj = getObjectFromGUID("e1b541"), pos = {66.55, 2.43, 11.33}, rot = {359.98, 179.99, 180.12}},
      ["coopScenarios"]           = {obj = getObjectFromGUID("833888"), pos = {77.05, 2.21, 11.32}, rot = {359.98, 179.99, 0.12}},
      ["griegeScenarios"]         = {obj = getObjectFromGUID("9ce600"), pos = {67.17, 2.56, -4.05}, rot = {357.39, 135.01, 359.03}},
      ["horizonsWrathScenarios"]  = {obj = getObjectFromGUID("fd232a"), pos = {72.35, 2.44, -3.13}, rot = {358.84, 180.04, 358.95}},
      ["uprisingScenarios"]       = {obj = getObjectFromGUID("a4ae21"), pos = {77.70, 2.21, -3.52}, rot = {359.92, 225.02, 0.06}},

      ["grovetendersSheet"]       = {obj = getObjectFromGUID("87b7ad"),           pos = {-46.00, 18.03, 56.97}, rot = {45.00, 180.01, 0.01}},
      ["grovetendersBox"]         = {obj = getObjectFromGUID("GrovetendersBox"),  pos = {-39.54, 20.89, 59.70}, rot = {44.70, 183.80, 7.72}},
      ["brawnenSheet"]            = {obj = getObjectFromGUID("0f20c6"),           pos = {-46.00, 9.00, 48.00}, rot = {45.00, 180.00, 0.00}},
      ["brawnenBox"]              = {obj = getObjectFromGUID("BrawnenBox"),       pos = {-39.41, 11.85, 50.72}, rot = {44.93, 181.82, 3.82}},
      ["naroraSheet"]             = {obj = getObjectFromGUID("17f416"),           pos = {-32.00, 18.00, 57.00}, rot = {45.00, 179.96, 0.08}},
      ["naroraBox"]               = {obj = getObjectFromGUID("NaroraBox"),        pos = {-25.39, 21.06, 59.95}, rot = {44.94, 181.78, 3.37}},
      ["heirsSheet"]              = {obj = getObjectFromGUID("481be7"),           pos = {-32.00, 9.00, 48.00}, rot = {45.00, 180.01, 0.00}},
      ["heirsBox"]                = {obj = getObjectFromGUID("HeirsBox"),         pos = {-25.64, 11.94, 50.80}, rot = {44.94, 181.37, 4.11}},
      ["horizonsWrathSheet"]      = {obj = getObjectFromGUID("783322"),           pos = {-18.00, 18.00, 57.00}, rot = {45.00, 179.96, 0.08}},
      ["horizonsWrathBox"]        = {obj = getObjectFromGUID("HorizonsWrathBox"), pos = {-11.56, 20.89, 59.78}, rot = {44.92, 182.28, 3.86}},
      ["griegeSheet"]             = {obj = getObjectFromGUID("7b5088"),           pos = {-18.00, 9.00, 48.00}, rot = {45.00, 179.98, 0.08}},
      ["griegeBox"]               = {obj = getObjectFromGUID("GriegeBox"),        pos = {-11.43, 11.88, 50.77}, rot = {44.91, 182.48, 3.91}},
      ["uprisingSheet"]           = {obj = getObjectFromGUID("c76d1d"),           pos = {18.00, 18.00, 57.00}, rot = {45.00, 180.01, 0.08}},
      ["uprisingBox"]             = {obj = getObjectFromGUID("UprisingBox"),      pos = {24.27, 20.88, 59.75}, rot = {44.92, 181.99, 4.10}},
      ["whispererSheet"]          = {obj = getObjectFromGUID("2fa099"),           pos = {53.34, 17.85, 56.79}, rot = {45.00, 180.00, 0.00}},
      ["whispererBox"]            = {obj = getObjectFromGUID("e8ce73"),           pos = {59.68, 20.38, 59.18}, rot = {44.81, 182.63, 7.12}},
    }

    --Base Game Isles
    isle1 = getObjectFromGUID("ca5a8c")
    isle2 = "7b97d9"
    isle3 = "502c04"
    isle4 = "ed4943"
    isle5 = "f45d1b"
    isle6 = "870e8c"
    isle7 = "b2c56e"
    isle8 = "5c5f3f"
    --Base Game Earthscapes
    earthscape9 = "0f9e2d"
    earthscape10 = "b98661"
    earthscape11 = "1d0787"
    earthscape12 = "bcdeba"
    earthscape13 = "c7334f"
    earthscape14 = "0419da"
    earthscape15 = "1fa1ee"
    earthscape16 = "86f956"
    --Fortresses
    brawnenFortress17 = "abc6f8"
    heirsFortress18 = "f8d457"
    grovetendersFortress19 = "2b6dc5"
    naroraFortress20 = "a88e98"
    griegeFortress21 = "d7affc"
    --Portal Seekers Isles
    isle22 = getObjectFromGUID("a8e8d1")
    isle23 = getObjectFromGUID("bf7b16")
    --Portal Seekers Earthscapes
    earthscape24 = "89b3ee"
    earthscape25 = "ab4fa6"
    earthscape26 = "85dac4"
    --Fortresses cont.
    horizonsWrathFortress27 = "3a568c"
    theUprisingFortress28 = "95746d"

    isleBag = "1324dc"
    earthscapeBag = "0d19a6"
    brawnenBox = "BrawnenBox"
    grovetendersBox = "GrovetendersBox"
    naroraBox = "NaroraBox"
    heirsBox = "HeirsBox"
    horizonsWrathBox = "HorizonsWrathBox"
    griegeBox = "GriegeBox"
    uprisingBox = "UprisingBox"

    eventCards = getObjectFromGUID("930936")
    seekersEvents = getObjectFromGUID("e306b4")
    bountyEvents = getObjectFromGUID("e22bc7")
    nonAnomalyEvents = getObjectFromGUID("ccdeb9")
    relicCards = getObjectFromGUID("026d80")
    pvpRelics = getObjectFromGUID("780cbc")
    seekersRelics = getObjectFromGUID("ff5030")
    seekersRelicsPvP = getObjectFromGUID("3b0cf0")
    bountyRelics = getObjectFromGUID("77e765")
    bountyRelicsPvP = getObjectFromGUID("30be90")

    marketBag = getObjectFromGUID("a403e7")
    marketDiscard = getObjectFromGUID("e67ec1")
    marketZone = getObjectFromGUID("ae2a5c")
    seekersMarket = getObjectFromGUID("72b61b")
    uprisingMarket = getObjectFromGUID("7f0887")
    timothy = getObjectFromGUID("0497f4")

    startingLandmarks = getObjectFromGUID("a36c60")
    otherLandmarks = getObjectFromGUID("6d2ce9")
    grailGoats = getObjectFromGUID("1a2eb9")
    visionStone = getObjectFromGUID("a4654d")
    altarOfAggression = getObjectFromGUID("5d59d6")

    islandsBag = getObjectFromGUID("1324dc")
    earthscapesBag = getObjectFromGUID("0d19a6")
    earthscapesZone = getObjectFromGUID("bc19cb")
    earthscapesDiscard = getObjectFromGUID("96b0df")
    seekersEarthscapes = getObjectFromGUID("0b887c")

    anomalyPortal1 = getObjectFromGUID("05e607")
    anomalyPortal2 = getObjectFromGUID("186e87")
    anomalyLandmarks = getObjectFromGUID("124b2f")

    --[[if setupHide == true then
      UI.setAttribute("modeselect","animationDuration", "0.0")
      UI.show("modeselectrestore")
      UI.hide("modeselect")
    end]]
  end
end

function onSave()
  local saveData = {
    ["setupComplete"] = setupComplete,
    ["setupHide"] = setupHide

    }
    saveData.aiPlayers = aiPlayers
  return JSON.encode(saveData)
end

--[[  for _, guid in ipairs(noninteractable) do
      local obj = getObjectFromGUID(guid)
      if obj then obj.interactable = false end
  end
  return JSON.encode(saveData)
end

noninteractable = {
  "1efbbd", -- market board
  "a81ab5", -- landscapes board
  "87be64", -- custom factions board
  "9b5836", -- playerboard blue
  "ad5f9f", -- playerboard red
  "23f216", -- playerboard white
  "a8865b", -- playerboard green


}--]]

function toggleFunction(playerObj, toggleStatus, toggleID)
    update_isOn(toggleStatus, toggleID)
end

function update_isOn(toggleStatus, toggleID)
    UI.setAttribute(toggleID, "isOn", toggleStatus)
end

function hideWindow()
  UI.hide("modeselect")
  UI.hide("pveselect")
  UI.hide("pvpselect")
  UI.hide("groupMinion")
  UI.show("modeselectrestore")
  setupHide = true
end

function pve()
  UI.hide("modeselect")
  UI.show("pveselect")
end

function pvp()
  UI.hide("modeselect")
  UI.show("pvpselect")
end

function showModeSelect()
  UI.hide("pveSelect")
  UI.hide("pvpSelect")
  UI.hide("modeselectrestore")
  UI.show("modeselect")
end

playerSeats = {
  ["white"] = false,
  ["red"] = false,
  ["green"] = false,
  ["blue"] = false
    }

statType = {
  "230c33",
  "1b1386",
  "08a9b1",
  "61eed6",
  "f23024",
  "6a7e7d",
  "a36c60",
  "6d2ce9",
  "a403e7"
    }

scriptRunning = false
refreshCount = 3

function onScriptingButtonDown(index, player)
  if player == "Grey" or index == 10 then return end
  local chipBag = getObjectFromGUID(statType[index])
  if chipBag.getQuantity() ~= 0 then
      chipBag.takeObject({position = Player[player].getPointerPosition() + Vector(0,2,0), rotation = Vector(0, 180, 180)})
    else
      printToColor("That bag is empty!", player)
  end
end


function pvpSetup()
  local pvpSetupConditions = {

    ["eventsSeekers"] = UI.getAttribute("eventsSeekers","isOn"),
    ["eventsBounty"] = UI.getAttribute("eventsBounty","isOn"),
    ["relicsSeekers"] = UI.getAttribute("relicsSeekers","isOn"),
    ["relicsBounty"] = UI.getAttribute("relicsBounty","isOn"),
    ["earthscapesSeekers"] = UI.getAttribute("earthscapesSeekers","isOn"),
    ["islesSeekers"] = UI.getAttribute("islesSeekers","isOn"),
    ["marketSeekers"] = UI.getAttribute("marketSeekers","isOn"),
    ["marketUprising"] = UI.getAttribute("marketUprising","isOn"),
    ["marketTimothy"] = UI.getAttribute("marketTimothy","isOn"),
    ["landmarksSeekers"] = UI.getAttribute("landmarksSeekers","isOn"),
    ["anomalyPvP"] = UI.getAttribute("anomalyPvP","isOn")

    }

  local centerIsleLocation = {0.20, 1.60, 0.00}

  local pvpTileLocations1 = {

      [1] = Vector(-1.52, 1.60, -6.96),
      [2] = Vector(-6.68, 1.61, -1.99),
      [3] = Vector(-4.96, 1.61, 4.97),
      [4] = Vector(1.92, 1.60, 6.96),
      [5] = Vector(7.09, 1.59, 1.99),
      [6] = Vector(5.36, 1.59, -4.97)

  }

  local pvpTileLocations2 = {

      [1] = Vector(-6.69, 1.61, 1.99),
      [2] = Vector(-1.52, 1.60, 6.96),
      [3] = Vector(5.36, 1.59, 4.97),
      [4] = Vector(7.09, 1.59, -1.99),
      [5] = Vector(1.92, 1.60, -6.96),
      [6] = Vector(-4.96, 1.61, -4.97)

  }

  if pvpSetupConditions["anomalyPvP"] ~= "True" then
    eventCards.putObject(nonAnomalyEvents)
  end

  if pvpSetupConditions["eventsSeekers"] == "True" then
    eventCards.putObject(seekersEvents)
  end

  if pvpSetupConditions["eventsBounty"] == "True" then
    eventCards.putObject(bountyEvents)
  end

  eventCards.flip()
  eventCards.shuffle()

  if pvpSetupConditions["relicsSeekers"] == "True" then
    relicCards.putObject(seekersRelics)
    relicCards.putObject(seekersRelicsPvP)
  end

  if pvpSetupConditions["relicsBounty"] == "True" then
    relicCards.putObject(bountyRelics)
    relicCards.putObject(bountyRelicsPvP)
  end

  relicCards.putObject(pvpRelics)
  relicCards.flip()
  relicCards.shuffle()

  if pvpSetupConditions["marketSeekers"] == "True" then
    seekersBag = seekersMarket.getObjects()
    for i in ipairs(seekersBag) do
      marketBag.putObject(seekersMarket.takeObject())
    end
  end

  if pvpSetupConditions["marketUprising"] == "True" then
    uprisingBag = uprisingMarket.getObjects()
    for i in ipairs(uprisingBag) do
      marketBag.putObject(uprisingMarket.takeObject())
    end
  end

  if pvpSetupConditions["marketTimothy"] == "True" then
    marketBag.putObject(timothy)
  end

  marketBag.shuffle()

  if pvpSetupConditions["landmarksSeekers"] == "True" then
    startingLandmarks.putObject(grailGoats)
    otherLandmarks.putObject(visionStone)
    otherLandmarks.putObject(altarOfAggression)
  end

  startingLandmarks.shuffle()
  otherLandmarks.shuffle()

  if pvpSetupConditions["islesSeekers"] == "True" and pvpSetupConditions["anomalyPvP"] == "False" then
    islandsBag.putObject(isle22)
    islandsBag.putObject(isle23)
  end

  math.randomseed(os.time())

  if pvpSetupConditions["anomalyPvP"] == "True" then
    anomalyRandom = math.random(2)

    if anomalyRandom == 1 then
      isle22.setPosition(Vector(-32.50, 1.60, 6.96))
      isle22.setRotation(Vector(0, math.random(1,6)*60, 180))
      isle23.setPosition(Vector(-34.23, 1.60, -0.04))
      isle23.setRotation(Vector(0, math.random(1,6)*60, 180))
    else
      isle22.setPosition(Vector(-34.23, 1.60, -0.04))
      isle22.setRotation(Vector(0, math.random(1,6)*60, 180))
      isle23.setPosition(Vector(-32.50, 1.60, 6.96))
      isle23.setRotation(Vector(0, math.random(1,6)*60, 180))
    end
    anomalyPortal1.setPosition(Vector(-39.39, 1.54, 4.97))
    anomalyPortal2.setPosition(Vector(0.20, 1.67, 0.00))
    anomalyLandmarks.shuffle()

    for i in ipairs(anomalyLandmarks.getObjects()) do
      if i <= 3 then
        local anomalyLandmark = anomalyLandmarks.takeObject()
        anomalyLandmark.setPosition(Vector(-41.11, 1.74, 5.96 - (i*2)))
        anomalyLandmark.setRotation(Vector(0,180,180))
      else
        break
      end
    end


  end

  islandsBag.shuffle()

  isle1.setPosition(centerIsleLocation)
  isle1.setRotation(Vector(0, math.random(1,6)*60, 0))
  isle1.setLock(true)

  local chiralityRandom = math.random(2)
  if chiralityRandom == 1 then
    for i in ipairs(pvpTileLocations1) do
      local isleTile = islandsBag.takeObject()
      isleTile.setPosition(pvpTileLocations1[i])
      isleTile.setRotation(Vector(0, math.random(1,6)*60, 180))
    end
  else
    for i in ipairs(pvpTileLocations2) do
      local isleTile = islandsBag.takeObject()
      isleTile.setPosition(pvpTileLocations2[i])
      isleTile.setRotation(Vector(0, math.random(1,6)*60, 180))
    end
  end

  if pvpSetupConditions["earthscapesSeekers"] == "True" then
    for _, seekersEarthscape in ipairs(seekersEarthscapes.getObjects()) do
      earthscapesBag.putObject(seekersEarthscape)
    end
  end

  earthscapesBag.shuffle()

  UI.hide("pvpselect")

  setupComplete = true

end

function soloIsOn()
    soloPvE = true
    coopPvE = false
end

function coopIsOn()
    soloPvE = false
    coopPvE = true
end

function pveSetup()

  local pveSetupConditions = {
    ["relicsSeekersPvE"] = UI.getAttribute("relicsSeekersPvE","isOn"),
    ["relicsBountyPvE"] = UI.getAttribute("relicsBountyPvE","isOn"),
    ["earthscapesSeekersPvE"] = UI.getAttribute("earthscapesSeekersPvE","isOn"),
    ["landmarksSeekersPvE"] = UI.getAttribute("landmarksSeekersPvE","isOn"),
    ["marketSeekersPvE"] = UI.getAttribute("marketSeekersPvE","isOn"),
    ["marketUprisingPvE"] = UI.getAttribute("marketUprisingPvE","isOn"),
    ["marketTimothyPvE"] = UI.getAttribute("marketTimothyPvE","isOn"),
    --["soloPvE"] = UI.getAttribute("soloPvE","isOn"),
    --["coopPvE"] = UI.getAttribute("coopPvE","isOn"),

    }

    if soloPvE then
      for player, args in pairs(PLAYER_OBJ) do
        if (player == "white") then
          args.obj.setPosition({0.00, 5.00, -38.00})
        elseif (player == "whiteBoard" ) then
          args.obj.setPosition({0.00, 1.39, -27.56})
        else
        args.obj.setPosition({0.00, 5.00, -2000.00})
      end
    end
  end

  if coopPvE then
    for player, args in pairs(PLAYER_OBJ) do
      if (player == "white") then
        args.obj.setPosition({15.00, 5.00, -38.00})
      elseif (player == "red") then
        args.obj.setPosition({-15.00, 5.00, -38.00})
      elseif (player == "whiteBoard") then
        args.obj.setPosition({15.06, 1.37, -27.56})
      elseif (player == "redBoard") then
        args.obj.setPosition({-14.94, 1.40, -27.56})
      else
        args.obj.setPosition({0.00, 5.00, -2000.00})
      end
    end
  end

    if pveSetupConditions["relicsSeekersPvE"] == "True" then
      relicCards.putObject(seekersRelics)
    end

    if pveSetupConditions["relicsBountyPvE"] == "True" then
      relicCards.putObject(bountyRelics)
    end

    relicCards.flip()
    relicCards.shuffle()

    if pveSetupConditions["marketSeekersPvE"] == "True" then
      seekersBag = seekersMarket.getObjects()
      for i in ipairs(seekersBag) do
        marketBag.putObject(seekersMarket.takeObject())
      end
    end

    if pveSetupConditions["marketUprisingPvE"] == "True" then
      uprisingBag = uprisingMarket.getObjects()
      for i in ipairs(uprisingBag) do
        marketBag.putObject(uprisingMarket.takeObject())
      end
    end

    if pveSetupConditions["marketTimothyPvE"] == "True" then
      marketBag.putObject(timothy)
    end

    marketBag.shuffle()

    if pveSetupConditions["landmarksSeekersPvE"] == "True" then
      startingLandmarks.putObject(grailGoats)
      otherLandmarks.putObject(visionStone)
      otherLandmarks.putObject(altarOfAggression)
    end

    startingLandmarks.shuffle()
    otherLandmarks.shuffle()

    if pveSetupConditions["earthscapesSeekersPvE"] == "True" then
      for _, seekersEarthscape in ipairs(seekersEarthscapes.getObjects()) do
        earthscapesBag.putObject(seekersEarthscape)
      end
    end

    earthscapesBag.shuffle()

    nonAnomalyEvents.putObject(eventCards)

  UI.hide("pveselect")

  setupComplete = true

end

function setupFaction(args)
  if scriptRunning ~= true then
    obj, player, factionBoxGUID = table.unpack(args)

    if playerSeats[player] == true then
      printToColor("You already have a faction!", player)
    else
      local pos = Player[player].getHandTransform().position

      obj.clearButtons()
      startpos = (Vector(pos.x,0,pos.z) + posDiff)
      clonedFactionSheet = obj.clone()
      Wait.frames(function()
      clonedFactionSheet.setPosition(startpos)
      clonedFactionSheet.setRotation(vector(0,180,0))
      clonedFactionSheet.setLock(true)
      clonedFactionSheet.clearButtons()
      clonedFactionSheet.setVar("factionSetup", true)
      obj.setVar("factionSetup", true)
      end, 1)

      factionBag = getObjectFromGUID(factionBoxGUID).clone()
      Wait.frames(function()
      chips = factionBag.getObjects()
      aiSetup = false
      playerSeats[player] = true

      startLuaCoroutine(self, "PickFactionCoroutine")

      scriptRunning = true
    end, 1)
    end
  else
    printToColor("Please wait for existing setup operations to complete",player)
  end
end

function setupFactionAI(args)
  if scriptRunning ~= true then
    obj, player, factionBoxGUID = table.unpack(args)
    obj.clearButtons()
    obj.setVar("factionSetup", true)

    if aiPlayers < 4 then
      factionBag = getObjectFromGUID(factionBoxGUID).clone()
      Wait.frames(function()
      chips = factionBag.getObjects()
      aiSetup = true
      startpos = aiStartPos - Vector(0, 0, 10*aiPlayers)
      aiPlayers = aiPlayers + 1

      startLuaCoroutine(self, "PickFactionCoroutine")

      scriptRunning = true
    end, 1)

    else

      printToColor("Too many AIs!",player)

    end
  else
    printToColor("Please wait for existing setup operations to complete",player)
  end
end

function PickFactionCoroutine()
  local chipTypeToPositionAI = {

    ["minion"] = Vector(2,0,0),
    ["hero"] = Vector(2,0,1.5),
    ["faction"] = Vector(7,0,3),
    ["fortress"] = Vector(17,0,1),
    ["box"] = Vector(-1,0,0),
    ["rules"] = Vector(15,3,2),
    ["dice"] = Vector(2,0,-2),
    ["spire"] = Vector(2,0,3)

    }

  local chipTypeToPosition = {

    ["minion"] = Vector(-6,0,6.5),
    ["hero"] = Vector(-6,0,9),
    ["faction"] = Vector(9.5,0,3.5),
    ["fortress"] = Vector(0,1,0),
    ["box"] = Vector(7.5,0,3.5),
    ["rules"] = Vector(9,0,-1.5),
    ["dice"] = Vector(7,0,5.5),
    ["spire"] = Vector(2,0,9)

    }

    for i in ipairs(chips) do

      local spawnedChip = factionBag.takeObject({position = startpos + Vector(i*2,0,0)})

      coroutine.yield(0)

      local chipTypes = spawnedChip.getVar("chipType")
      local count = spawnedChip.getVar("count")

      if aiSetup == false then
        spawnedChip.setPosition(startpos + chipTypeToPosition[chipTypes])
        spawnedChip.setRotation(Vector(0,180,0))
        chipTypeToPosition[chipTypes] = chipTypeToPosition[chipTypes] + Vector(1.5,0,0)
        chipPos = spawnedChip.getPosition()

      else

        spawnedChip.setPosition(startpos + chipTypeToPositionAI[chipTypes])

      if chipTypes == "fortress" then
        spawnedChip.setRotation(Vector(0,270,0))
      else
        spawnedChip.setRotation(Vector(0,180,0))
      end

      chipTypeToPositionAI[chipTypes] = chipTypeToPositionAI[chipTypes] + vector(1.5,0,0)
      chipPos = spawnedChip.getPosition()

    end

    for j = 1,count-1 do
      spawnedChip.clone({
      position = Vector(chipPos) + Vector(0, j, 0)
      })
    end
  end

  coroutine.yield(0)

  scriptRunning = false
  factionBag.destruct()

  return 1
end

function combineLandmarks(obj, player)
  for i in ipairs(startingLandmarks.getObjects()) do
    otherLandmarks.putObject(startingLandmarks.takeObject())
  end
  otherLandmarks.shuffle()
end

function setMarket(obj, player, input, selected)
  inputNumber = tonumber(input)
  if inputNumber ~= nil then
    if inputNumber >= 1 and inputNumber <= 6 then
      refreshCount = inputNumber
    else
      printToColor("Invalid Number. Please pick a number between 1 and 6.", player)
    end
  end
end

function marketRefresh(obj, player)
  for i, marketChips in ipairs(marketZone.getObjects()) do
    marketDiscard.putObject(marketChips)
  end

  if #marketBag.getObjects() >= refreshCount then
    for j = 1, refreshCount do
      marketBag.takeObject({position = Vector(24.41 + (j*1.5), 1.46, 8.15), rotation = Vector(0, 180.00, 0)})
    end
  else
    printToColor("Insufficient Market Chips Remaining in Stack",player)
  end

  for k, earthscapes in ipairs(earthscapesZone.getObjects()) do
    earthscapes.setPosition(Vector(36.11, (#earthscapesDiscard.getObjects()*.2) + 1.65, 0.06))
    earthscapes.setRotation(Vector(0,180,0))
  end

  if #earthscapesBag.getObjects() ~= 0 then
    earthscapesBag.takeObject({position = Vector(29.74, 1.55, 0.06), rotation = Vector(0, 180, 0)})
  else
    printToColor("No Earthscapes Remaining",player)
  end
end

function marketFill(obj, player)
  if (#marketBag.getObjects() - #marketZone.getObjects()) >= refreshCount then
    for i = 1, refreshCount do
      spawnPos = Vector(24.41 + (i*1.5), 1.46, 8.15)
      checkPos = false

      for j, marketChips in ipairs(marketZone.getObjects()) do
        if spawnPos.x - .5 <= marketChips.getPosition().x and marketChips.getPosition().x <= spawnPos.x + .5 then
          checkPos = true
        end

      end
      if checkPos == false then
        marketBag.takeObject({position = spawnPos, rotation = Vector(0,180,0)})
      end
    end
  else
    printToColor("Insufficient Market Chips Remaining in Stack",player)
  end

  if #earthscapesBag.getObjects() ~= 0 then
    if #earthscapesZone.getObjects() == 0 then
      earthscapesBag.takeObject({position = Vector(29.74, 1.55, 0.06), rotation = Vector(0, 180, 0)})
    end
  else
    printToColor("No Earthscapes Remaining",player)
  end
end


function marketDiscardRefresh()
  for i in ipairs(marketDiscard.getObjects()) do
    marketBag.putObject(marketDiscard.takeObject())
  end
  marketBag.shuffle()
end

function earthscapesDiscardRefresh()
  for _, earthscapes in ipairs(earthscapesDiscard.getObjects()) do
    earthscapesBag.putObject(earthscapes)
  end
  earthscapesBag.shuffle()
end

function addCSHealth(params)
  -- jump value is the height of the chip/tile that is used for health/upgrades
  -- 0.2 for tiles of height 0.2
  -- 0.16 for chips
  local jump = params.jump or 0.16
  local chip = params.chip
  local chip_to_add = params.chip_to_add

	local pos = chip.getPosition()

  chip.setPosition(Vector(pos.x, pos.y + jump, pos.z))

  local health_chip_stack = getObjectFromGUID(chip_to_add)

	health_chip_stack.takeObject({
		position = Vector(pos),
		rotation = Vector({0, 180, 0}),
		smooth = false,
    callback_function = function(new_health_chip)
			chip.addAttachment(new_health_chip)
		end
	})
end

--[[if tutorialScenarioButton ~= nil then
  testButton.createButton({
    label="Brawnen Ch.1",
    position={0, -0.05, 0},
    rotation={0,0,180},
    click_function="setUpBrawnenCh1Scenario",
    function_owner=self,
    height=1500, width=5000,
    font_color={0,0,0},
    font_size=1000,
  })
end]]

function lookForCorrectContainer(gamePiece)
  getItemFromContainer(gamePiece, isleBag)
  if getObjectFromGUID(gamePiece) == nil then
    getItemFromContainer(gamePiece, earthscapeBag)
  elseif getObjectFromGUID(gamePiece) == nil then
      getItemFromContainer(gamePiece, earthscapeBag)
  elseif getObjectFromGUID(gamePiece) == nil then
      getItemFromContainer(gamePiece, brawnenBox)
  elseif getObjectFromGUID(gamePiece) == nil then
      getItemFromContainer(gamePiece, grovetendersBox)
  elseif getObjectFromGUID(gamePiece) == nil then
      getItemFromContainer(gamePiece, naroraBox)
  elseif getObjectFromGUID(gamePiece) == nil then
      getItemFromContainer(gamePiece, heirsBox)
  elseif getObjectFromGUID(gamePiece) == nil then
      getItemFromContainer(gamePiece, horizonsWrathBox)
  elseif getObjectFromGUID(gamePiece) == nil then
      getItemFromContainer(gamePiece, griegeBox)
  elseif getObjectFromGUID(gamePiece) == nil then
      getItemFromContainer(gamePiece, uprisingBox)
  end
end

  function getItemFromContainer(gamePiece, container)
  local vectorPos = getObjectFromGUID(container).getPosition()
  for _, containedObject in ipairs(getObjectFromGUID(container).getObjects()) do
  -- Iterate through each contained object
    vectorPos = Vector(vectorPos.x, vectorPos.y+5, vectorPos.z)
    if containedObject.guid == gamePiece then
        getObjectFromGUID(container).takeObject({
          index = containedObject.index,
          position = vectorPos
          })
        break -- Stop iterating
      end
  end
end

function placeGamePiece(gamePiece, pos, rot)
  if getObjectFromGUID(gamePiece) == nil then
    lookForCorrectContainer(gamePiece)
  end
    Wait.time(function()
      if gamePiece == null then
        --getObjects()
        --gamePiece = getObjectFromGUID(gamePieceGuid)
        print("somethings null")
      end
      getObjectFromGUID(gamePiece).setRotationSmooth(rot)
      getObjectFromGUID(gamePiece).setPositionSmooth(pos)
    end, 1)
 end

function setUpBrawnenCh1Scenario()

  local waitTime = 0

  Wait.time(function()
    placeGamePiece(brawnenFortress17, {-1.51, 1.70, -11.11}, {359.92, 269.99, 1.28})
  end,waitTime)
  waitTime = waitTime + 1.5

  Wait.time(function()
    placeGamePiece(earthscape16, {-2.88, 1.64, -6.68}, {0.05, 150.00, 0.06})
  end, waitTime)

  waitTime = waitTime + 1.5

Wait.time(function()
  placeGamePiece(earthscape15, {1.11, 1.63, -6.95}, {359.92, 269.64, 0.02})
end, waitTime)

waitTime = waitTime + 1.5

Wait.time(function()
  placeGamePiece(isle1, {0.23, 1.71, -1.90}, {0.80, 299.88, 358.46})
end, waitTime)

waitTime = waitTime + 1.5

Wait.time(function()
  placeGamePiece(isle4, {7.09, 1.59, -3.98}, {0.06, 60.00, 359.95})
end, waitTime)

waitTime = waitTime + 1.5

Wait.time(function()
  placeGamePiece(isle8, {5.36, 1.59, 2.98}, {359.94, 239.97, 0.05})
end, waitTime)

waitTime = waitTime + 1.5

Wait.time(function()
  placeGamePiece(grovetendersFortress19, {0.15, 1.71, 6.02}, {0.03, 30.01, 1.23})
end, waitTime)

waitTime = waitTime + 1.5

Wait.time(function()
  placeGamePiece(earthscape10, {10.10, 1.69, 1.25}, {359.94, 209.98, 2.15})
end, waitTime)

waitTime = waitTime + 1.5

Wait.time(function()
  placeGamePiece(earthscape13, {6.26, 1.76, -1.91}, {359.93, 270.03, 0.01})
end, waitTime)



end

---------------------------
--Tutorial Scenario Setup--
---------------------------

  --[[if tutorialScenarioButton ~= nil then

    getObjectFromGUID(tutorialScenarioButton).createButton({
      label="Tutorial Scenario",
      position={0, -0.05, 0},
      rotation={0,0,180},
      click_function="setUpTutorialScenario",
      function_owner=self,
      height=1500, width=5000,
      font_color={0,0,0},
      font_size=1000,
    })
  end

  if getObjectFromGUID(testButton2) ~= nil then

    getObjectFromGUID(testButton2).createButton({
      label="Test Spawner",
      position={0, -0.05, 0},
      rotation={0,0,180},
      click_function="spawnObject",
      function_owner=self,
      height=1500, width=5000,
      font_color={0,0,0},
      font_size=1000,
    })
  end]]

  function spawnObject()
    local object = spawnObjectData({
    data = {
        Name = "Custom_Tile",
        Transform = {
            posX = 0,
            posY = 3,
            posZ = 0,
            rotX = 0,
            rotY = 180,
            rotZ = 0,
            scaleX = 2,
            scaleY = 2,
            scaleZ = 2
        },
        ColorDiffuse = {
            r = 0.3,
            g = 0.5,
            b = 0.8
        }
    },
    callback_function = function(spawned_object)
        log(spawned_object.getBounds())
    end
})
object.setPositionSmooth({10, 5, 10})
end


function setUpTutorialScenario()
  local delayAdd = 0.5
	local delaySum = delayAdd

  Wait.time(function()
    brawnenFortress17.setPosition({-1.56, 1.63, -11.16})
    brawnenFortress17.setRotation({359.92, 269.96, 0.02})
    end, delaySum)
  delaySum = delaySum+delayAdd

  Wait.time(function()
    earthscape16.setPositionSmooth({-2.88, 1.64, -6.68})
    earthscape16.setRotationSmooth({0.05, 150.00, 0.06})
    end, delaySum)
  delaySum = delaySum+delayAdd

  Wait.time(function()
    earthscape15.setPositionSmooth({1.11, 1.63, -6.95})
    earthscape15.setRotationSmooth({359.92, 269.64, 0.02})
    end, delaySum)
  delaySum = delaySum+delayAdd

  Wait.time(function()
    isle1.setPositionSmooth({0.23, 1.71, -1.90})
    isle1.setRotationSmooth({0.80, 299.88, 358.46})
    end, delaySum)
  delaySum = delaySum+delayAdd

  Wait.time(function()
    isle4.setPositionSmooth({7.09, 1.59, -3.98})
    isle4.setRotationSmooth({0.06, 60.00, 359.95})
    end, delaySum)
  delaySum = delaySum+delayAdd

  Wait.time(function()
    isle8.setPositionSmooth({5.36, 1.59, 2.98})
    isle8.setRotationSmooth({359.94, 239.97, 0.05})
    end, delaySum)
  delaySum = delaySum+delayAdd

  Wait.time(function()
    grovetendersFortress19.setPositionSmooth({0.15, 1.71, 6.02})
    grovetendersFortress19.setRotationSmooth({0.03, 30.01, 1.23})
    end, delaySum)
  delaySum = delaySum+delayAdd

  Wait.time(function()
    earthscape10.setPositionSmooth({10.10, 1.69, 1.25})
    earthscape10.setRotationSmooth({359.94, 209.98, 2.15})
    end, delaySum)
  delaySum = delaySum+delayAdd

  Wait.time(function()
    earthscape13.setPositionSmooth({6.26, 1.76, -1.91})
    earthscape13.setRotationSmooth({359.93, 270.03, 0.01})
    end, delaySum)
  delaySum = delaySum+delayAdd

end

---------------------------
--   Brawnen ch1 Setup   --
---------------------------

  --[[if brawnenCh1ScenarioButton ~= nil then

    getObjectFromGUID(brawnenCh1ScenarioButton).createButton({
      label="Brawnen Ch.1",
      position={0, -0.05, 0},
      rotation={0,0,180},
      click_function="setUpBrawnenCh1Scenario",
      function_owner=self,
      height=1500, width=5000,
      font_color={0,0,0},
      font_size=1000,
    })
  end]]
