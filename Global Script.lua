--[[ Lua code. See documentation: https://api.tabletopsimulator.com/ --]]

--[[ The onLoad event is called after the game save finishes loading. --]]

local aiPlayers = 0
local aiStartPos = Vector(-51.5, 1.50, 16)
local posDiff = Vector(-3,1.55,8)

function onLoad(saveState)

  if saveState ~= "" then
    local saveData = JSON.decode(saveState)
    setupComplete = saveData.setupComplete
    setupHide = saveData.setupHide
  end

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
  alterOfAggression = getObjectFromGUID("5d59d6")

  islandsBag = getObjectFromGUID("1324dc")
  earthscapesBag = getObjectFromGUID("0d19a6")
  earthscapesZone = getObjectFromGUID("bc19cb")
  earthscapesDiscard = getObjectFromGUID("96b0df")
  isle22 = getObjectFromGUID("a8e8d1")
  isle23 = getObjectFromGUID("bf7b16")
  isle1 = getObjectFromGUID("ca5a8c")
  seekersEarthscapes = getObjectFromGUID("0b887c")

  anomalyPortal1 = getObjectFromGUID("05e607")
  anomalyPortal2 = getObjectFromGUID("186e87")
  anomalyLandmarks = getObjectFromGUID("124b2f")

  if setupComplete ~= true then
    UI.show("modeselect")
  end
  if setupHide == true then
    UI.setAttribute("modeselect","animationDuration", "0.0")
    UI.show("modeselectrestore")
    UI.hide("modeselect")
  end

  for _, guid in ipairs(noninteractable) do
      local obj = getObjectFromGUID(guid)
      if obj then obj.interactable = false end
  end
  return JSON.encode(saveData)
end

noninteractable = {
  "1efbbd", -- market board
  "a81ab5", -- landscapes board
  "9b5836", -- playerboard blue
  "ad5f9f", -- playerboard red
  "23f216", -- playerboard white
  "a8865b", -- playerboard green

}

--[[ The onUpdate event is called once per frame. --]]
function onUpdate()
    --[[ print("onUpdate loop!") --]]
end

function onSave()
  local saveData = {
    ["setupComplete"] = setupComplete,
    ["setupHide"] = setupHide,
    }
  return JSON.encode(saveData)
end

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
  "61eed6",
  "c9a9b5",
  "f23024",
  "71485d",
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
    otherLandmarks.putObject(alterOfAggression)
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

function pveSetup()
  local pveSetupConditions = {
    ["relicsSeekersPvE"] = UI.getAttribute("relicsSeekersPvE","isOn"),
    ["relicsBountyPvE"] = UI.getAttribute("relicsBountyPvE","isOn"),
    ["earthscapesSeekersPvE"] = UI.getAttribute("earthscapesSeekersPvE","isOn"),
    ["landmarksSeekersPvE"] = UI.getAttribute("landmarksSeekersPvE","isOn"),
    ["marketSeekersPvE"] = UI.getAttribute("marketSeekersPvE","isOn"),
    ["marketUprisingPvE"] = UI.getAttribute("marketUprisingPvE","isOn"),
    ["marketTimothyPvE"] = UI.getAttribute("marketTimothyPvE","isOn"),

    }

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
      otherLandmarks.putObject(alterOfAggression)
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
      obj.setPosition(startpos)
      obj.setRotation(vector(0,180,0))
      obj.setLock(true)
      obj.setVar("factionSetup", true)

      factionBag = getObjectFromGUID(factionBoxGUID)
      chips = factionBag.getObjects()
      aiSetup = false
      playerSeats[player] = true

      startLuaCoroutine(self, "PickFactionCoroutine")

      scriptRunning = true
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
      factionBag = getObjectFromGUID(factionBoxGUID)
      chips = factionBag.getObjects()
      aiSetup = true
      startpos = aiStartPos - Vector(0, 0, 10*aiPlayers)
      aiPlayers = aiPlayers + 1

      startLuaCoroutine(self, "PickFactionCoroutine")

      scriptRunning = true

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
