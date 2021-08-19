--[[ Lua code. See documentation: https://api.tabletopsimulator.com/ --]]

--[[ The onLoad event is called after the game save finishes loading. --]]

local aiPlayers = 0
local aiStartPos = Vector(-51.5, 1.50, 16)
local posDiff = Vector(-3,1.55,8)

function onLoad()

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
  isle22 = getObjectFromGUID("a8e8d1")
  isle23 = getObjectFromGUID("bf7b16")
  isle1 = getObjectFromGUID("ca5a8c")
  seekersEarthscapes = getObjectFromGUID("0b887c")

  anomalyPortal1 = getObjectFromGUID("05e607")
  anomalyPortal2 = getObjectFromGUID("186e87")
  anomalyLandmarks = getObjectFromGUID("124b2f")

end

--[[ The onUpdate event is called once per frame. --]]
function onUpdate()
    --[[ print("onUpdate loop!") --]]
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
end

function pve()
  UI.hide("modeselect")
  UI.show("pveselect")
end

function pvp()
  UI.hide("modeselect")
  UI.show("pvpselect")
end


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

function onScriptingButtonDown(index, player)
  if player == "Grey" or index == 10 then return end
  local chipBag = getObjectFromGUID(statType[index])
  if chipBag.getQuantity() ~= 0 then
      chipBag.takeObject({position = Player[player].getPointerPosition() + Vector(0,2,0), rotation = Vector(0, 180, 180)})
    else
      print("That bag is empty!")
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

end

function setupFaction(args)
  
  
  local obj, player, factionBoxGUID = table.unpack(args)
  local pos = Player[player].getHandTransform().position

  obj.clearButtons()
  startpos = (Vector(pos.x,0,pos.z) + posDiff)
  obj.setPosition(startpos)
  obj.setRotation(vector(0,180,0))
  obj.setLock(true)

  factionBag = getObjectFromGUID(factionBoxGUID)
  chips = factionBag.getObjects()
  aiSetup = false

  startLuaCoroutine(self, "PickFactionCoroutine")
end

function setupFactionAI(args)

  local obj, factionBoxGUID = table.unpack(args)
  obj.clearButtons()

  if aiPlayers < 4 then
    factionBag = getObjectFromGUID(factionBoxGUID)
    chips = factionBag.getObjects()
    aiSetup = true
    startpos = aiStartPos - Vector(0, 0, 10*aiPlayers)
    aiPlayers = aiPlayers + 1

    startLuaCoroutine(self, "PickFactionCoroutine")

  else

    print("Too many AIs!")

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
      chipTypeToPosition[chipTypes] = chipTypeToPosition[chipTypes] + vector(1.5,0,0)
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
  return 1
end