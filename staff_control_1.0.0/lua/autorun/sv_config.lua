StaffControl = StaffControl or {}
StaffControl.Config = StaffControl.Config or {}



StaffControl.Config.ChatPrefix = "[Staff Control]"
StaffControl.Config.ServerName = "[DarkRP Server]"

StaffControl.Config.Staff = {"admin"} -- (staff usergroups)
-- /staffreset to reset user's password /staffreset steamid64
StaffControl.Config.Management = {""} -- management (they can reset users passwords etc)

StaffControl.Config.ChatMessages = {""} -- (chat commands they can use to go on duty)

StaffControl.Config.Model = "" -- (model to set user once on duty)

StaffControl.Config.GloballyAllowedCommands = {"time", "menu"} -- (commands everyone can run)

StaffControl.Config.BypassUsergroups = {""} -- (groups that don't need to be on duty)

StaffControl.Config.AdminSystem = "sam" -- (sam)

StaffControl.Config.DiscordRelay = true -- (use discord logging?)

StaffControl.Config.DiscordWebhook = '' -- (discord webhook)

StaffControl.Config.UseSCBChatbox = true -- (scb) set false if you don't use scb chatbox



