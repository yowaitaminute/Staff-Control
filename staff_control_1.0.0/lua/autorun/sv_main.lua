StaffControl = StaffControl or {}
StaffControl.Config = StaffControl.Config or {}
StaffControl.Sam = StaffControl.Sam or {}

local path = 'staffcontrol.json'

hook.Add('PlayerSay', 'StaffControl_Hook1', function(p,t)
    if not table.HasValue(StaffControl.Config.Staff, p:GetUserGroup()) then return end
    if table.HasValue(StaffControl.Config.ChatMessages, string.lower(t)) then
        if file.Exists(path, 'DATA') then
            data = util.JSONToTable( file.Read(path, 'DATA') )
        else
            data = {}
        end
        local args = string.Explode(' ', t) 
        if p.isOnDuty then
                p:SetModel(p.offDutyMdl)
                p.offDutyMdl = nil
                StaffControl:Message(p, 'Succesfully Off Duty!')
            return ''
        end
        if data[p:SteamID64()] then
            if not args[1] then 
                StaffControl:Message(p, 'Missing Password!')
            end
            if not args[1] == data[p:SteamID64()] then
                StaffControl:Message(p, 'Bad Password.')
            else 
                p.offDutyMdl = p:GetModel()
                p:SetModel(StaffControl.Config.Model)
                p.isOnDuty = true
                StaffControl:Message(p, 'Your On Duty!')
            end
        else 
            if not args[1] then 
                StaffControl:Message(p, 'Missing New Password.!')
            end

            if args[1] then
                data[p:SteamID64()] = args[1]
                StaffControl:Message(p, 'Succesfully Set Password To ' .. args[1])
                p.offDutyMdl = p:GetModel()
                p:SetModel(StaffControl.Config.Model)
                p.isOnDuty = true
                StaffControl:Message(p, 'Your On Duty!')
                file.Write(path, util.TableToJSON(data, true))
            end
        end
        return ''
    end
end)

hook.Add('PlayerSay', 'StaffControl_Hook2', function(p,t)
    if not table.HasValue(StaffControl.Config.Management, p:GetUserGroup()) then return end
    if file.Exists(path, 'DATA') then
        data = util.JSONToTable( file.Read(path, 'DATA') )
    else
        data = {}
    end

    if string.lower(t) == '/staffreset' then
        local args = string.Explode(' ', t) 
        local staff = args[1]
        data[staff] = nil
        StaffControl:Message(p, 'Succesfully Resetted (' .. staff .. ') Password!' )
        file.Write(path, util.TableToJSON(data, true))
        return ''
    end
end)

function StaffControl:Message(p, msg)
    if StaffControl.Config.UseSCBChatbox then
        p:ChatPrint('{!' .. StaffControl.Config.ChatPrefix .. '} ' .. ' {*' .. msg .. '}')
    else
        p:ChatPrint('' .. StaffControl.Config.ChatPrefix .. ' ' .. msg)
    end
end

hook.Add('PlayerInitialSpawn', 'StaffControl_Hook3', function(p)
    StaffControl:Message(p, 'This Server Is Running Staff Control Version 1.0')
end)

print([[
    ===============================
    ===== Staff Control Loaded ====
    ====== Created By Lukas =======
    ===============================
]])