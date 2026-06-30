local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Z I N K Teleport Manager",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by zink",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "zink_Scripts", 
      FileName = "TeleportConfig"
   },
   KeySystem = true,
   KeySettings = {
      Title = "zink Access",
      Subtitle = "Key System",
      Note = "Join Whatsapp Group for Key",
      FileName = "zinkKey", 
      SaveKey = true, 
      GrabKeyFromSite = false,
      Key = {"meow"} 
   }
})

-- Variablen (Vorab definiert, damit alle Funktionen darauf zugreifen können)
local savedLocations = {}
local selectedOption = nil
local currentLocationName = ""
local DropdownTP
local DropdownManage

-- Tabs
local TabMain = Window:CreateTab("Teleport", 4483362458)
local TabManage = Window:CreateTab("DB", 4483362458)
local TabSettings = Window:CreateTab("Einstellungen", 4483362458)

-----------------------------------------------------------------------
-- TAB: TELEPORT
-----------------------------------------------------------------------

TabMain:CreateSection("Neue Position hinzufügen")

TabMain:CreateInput({
   Name = "Name der Position",
   PlaceholderText = "Eingabe...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      currentLocationName = Text
   end,
})

TabMain:CreateButton({
   Name = "Aktuelle Position speichern",
   Callback = function()
      local name = currentLocationName
      local char = game.Players.LocalPlayer.Character
      
      if name and name ~= "" and char and char:FindFirstChild("HumanoidRootPart") then
         savedLocations[name] = char.HumanoidRootPart.Position
         
         local options = {}
         for k, v in pairs(savedLocations) do table.insert(options, k) end
         
         -- Aktualisiere die Dropdowns
         DropdownTP:Refresh(options)
         DropdownManage:Refresh(options)
         
         Rayfield:Notify({Title = "Z I N K", Content = "Position gespeichert: " .. name, Duration = 3})
      else
         Rayfield:Notify({Title = "Fehler", Content = "Kein Name eingegeben oder Charakter nicht gefunden.", Duration = 3})
      end
   end,
})

TabMain:CreateSection("Teleportation")

DropdownTP = TabMain:CreateDropdown({
   Name = "Position auswählen",
   Options = {},
   CurrentOption = "",
   MultipleOptions = false,
   Callback = function(Option)
      selectedOption = type(Option) == "table" and Option[1] or Option
   end,
})

TabMain:CreateButton({
   Name = "Teleportieren",
   Callback = function()
      if selectedOption and savedLocations[selectedOption] then
         local char = game.Players.LocalPlayer.Character
         if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(savedLocations[selectedOption] + Vector3.new(0, 3, 0))
            Rayfield:Notify({Title = "Teleport", Content = "Ziel: " .. selectedOption, Duration = 2})
         end
      else
         Rayfield:Notify({Title = "Error", Content = "Keine Position ausgewählt.", Duration = 3})
      end
   end,
})

-----------------------------------------------------------------------
-- TAB: VERWALTUNG (DB)
-----------------------------------------------------------------------

TabManage:CreateSection("Position löschen")

DropdownManage = TabManage:CreateDropdown({
   Name = "Position zum Löschen wählen",
   Options = {},
   CurrentOption = "",
   MultipleOptions = false,
   Callback = function(Option)
      selectedOption = type(Option) == "table" and Option[1] or Option
   end,
})

TabManage:CreateButton({
   Name = "Position entfernen",
   Callback = function()
      if selectedOption and savedLocations[selectedOption] then
         savedLocations[selectedOption] = nil
         
         local options = {}
         for k, v in pairs(savedLocations) do table.insert(options, k) end
         
         DropdownTP:Refresh(options)
         DropdownManage:Refresh(options)
         
         Rayfield:Notify({Title = "Z I N K", Content = "Position wurde gelöscht.", Duration = 3})
      end
   end,
})

TabManage:CreateButton({
   Name = "Alle Positionen löschen",
   Callback = function()
      savedLocations = {}
      DropdownTP:Refresh({})
      DropdownManage:Refresh({})
      Rayfield:Notify({Title = "Z I N K", Content = "Datenbank geleert.", Duration = 3})
   end,
})

-----------------------------------------------------------------------
-- TAB: EINSTELLUNGEN
-----------------------------------------------------------------------

TabSettings:CreateSection("Charakter")

TabSettings:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 250},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WS_Slider", 
   Callback = function(Value)
      pcall(function()
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end)
   end,
})

TabSettings:CreateSection("Menü")

TabSettings:CreateButton({
   Name = "Skript schließen",
   Callback = function()
      Rayfield:Destroy()
   end,
})

Tabsettings:CreateLabel("https://whatsapp.com/channel/0029Vb8U5jv8aKvRl4Pp1D0P")


Rayfield:Notify({
   Title = "Z I N K geladen",
   Content = "meow",
   Duration = 4,
})