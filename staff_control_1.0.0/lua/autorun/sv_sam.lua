StaffControl = StaffControl or {}
StaffControl.Config = StaffControl.Config or {}
StaffControl.Sam = StaffControl.Sam or {}

/*
    sam.hook_call("SAM.ChangedSteamIDRank", steamid, rank, old_rank, expiry_date, exists)
    sam.hook_call("SAM.ChangedPlayerRank", ply, rank, old_rank, expiry_date)
    ignore
*/

hook.Add('SAM.CanRunCommand', 'StaffControl.Sam._CommandRan', function(p, cmd_name, args, cmd)
    if table.HasValue(StaffControl.Config.BypassUsergroups, ply:GetUserGroup()) then return true end
    if table.HasValue(StaffControl.Config.GloballyAllowedCommands, cmd_name) then return true end
    if not p.isOnDuty then
        StaffControl:Message(p,  'You Cannot Use The Command ' .. cmd_name .. ' Off Duty!')
        return false
    end
    if p.isOnDuty then
        if StaffControl.Config.DisordRelay then
            http.Post('https://relay.yowaitaminute.xyz/', { color = 'color', title = StaffControl.Config.ChatPrefix .. ' Player (' .. p:Nick() .. ') Ran Command', description = cmd_name, webhook = 
            StaffControl.Config.DiscordWebhook }, function(body, len, headers, code)
                if code == 200 then
                    print("[StaffControl - Discord] Sent embed to discord!")
                else
                    print("[StaffControl - Discord] Error sending embed to discord!")
                end
            end)
        return true
    end
end)

hook.Add("PlayerNoClip", "StaffControl.Sam._Noclip", function(ply, desiredState)
    if desiredState == false then return true end 
    if table.HasValue(StaffControl.Config.BypassUsergroups, ply:GetUserGroup()) then return true end
    if not p.isOnDuty then
        StaffControl:Message(p,  'You Cannot Noclip Off Duty!')
        return false
    end
    if p.isOnDuty then
        if StaffControl.Config.DisordRelay then
            http.Post('https://relay.yowaitaminute.xyz/', { color = 'color', title = StaffControl.Config.ChatPrefix .. ' Player (' .. p:Nick() .. ') Ran Noclip', description = cmd_name, webhook = 
            StaffControl.Config.DiscordWebhook }, function(body, len, headers, code)
                if code == 200 then
                    print("[StaffControl - Discord] Sent embed to discord!")
                else
                    print("[StaffControl - Discord] Error sending embed to discord!")
                end
            end)
        return true
    end
end)