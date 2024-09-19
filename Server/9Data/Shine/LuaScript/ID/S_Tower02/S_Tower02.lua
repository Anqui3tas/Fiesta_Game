require("common")
require("ID/S_Tower02/Data")

function Main(Field)
    cExecCheck "S_Tower02 - Main"

    local Var = InstanceField[Field]
    if Var == nil then
        InstanceField[Field] = {}
        Var = InstanceField[Field]
        Var.MapIndex = Field
        Var.currentsummon = 0
        Var.wait = cCurrentSecond() + 5
        Var.StepFunc = Doors
    end
    return Var.StepFunc(Var)
end

function Start(Var)
    cExecCheck "S_Tower02 - Start"

    if Var.wait < cCurrentSecond() then
        Var.SummonInfo = MobInfo["Spawn0".. Var.currentsummon]
        if Var.SummonInfo == nil then
            Var.StepFunc = Success
        end
        for i=1, #Var.SummonInfo do
            cMobRegen_XY(Var.MapIndex, Var.SummonInfo[i].Inx, Var.SummonInfo[i].x, Var.SummonInfo[i].y)
        end
        Var.currentsummon = Var.currentsummon + 1
        Var.StepFunc = Wait
    end
end

function Wait(Var)
    cExecCheck "S_Tower02 - Wait"

    if cObjectCount(Var.MapIndex, ObjectType.Mob) <= 0 then
        Var.wait = cCurrentSecond() + 5
        Var.StepFunc = Doors
    end
end

function Doors(Var)
    cExecCheck "S_Tower02 - Doors"

    if not Var.started then
        Var.door01 = cDoorBuild(Var.MapIndex, Door[1].Inx, Door[1].x, Door[1].y, 0, 800)
        cDoorAction(Var.door01, "DOOR01", "close")
        Var.door02 = cDoorBuild(Var.MapIndex, Door[2].Inx, Door[2].x, Door[2].y, 0, 800)
        cDoorAction(Var.door02, "DOOR02", "close")
        Var.door03 = cDoorBuild(Var.MapIndex, Door[3].Inx, Door[3].x, Door[3].y, 0, 800)
        cDoorAction(Var.door03, "DOOR03", "close")
        Var.door04 = cDoorBuild(Var.MapIndex, Door[4].Inx, Door[4].x, Door[4].y, 0, 800)
        cDoorAction(Var.door04, "DOOR04", "close")
        Var.door05 = cDoorBuild(Var.MapIndex, Door[5].Inx, Door[5].x, Door[5].y, 0, 800)
        cDoorAction(Var.door05, "DOOR05", "close")
        Var.door06 = cDoorBuild(Var.MapIndex, Door[6].Inx, Door[6].x, Door[6].y, 0, 800)
        cDoorAction(Var.door06, "DOOR06", "close")
        Var.door07 = cDoorBuild(Var.MapIndex, Door[7].Inx, Door[7].x, Door[7].y, 0, 800)
        cDoorAction(Var.door07, "DOOR07", "close")
        Var.door08 = cDoorBuild(Var.MapIndex, Door[8].Inx, Door[8].x, Door[8].y, 0, 800)
        cDoorAction(Var.door08, "DOOR08", "close")
        Var.started = true
        Var.StepFunc = Start
    end

    if Var.currentsummon == 1 then
        cDoorAction(Var.door01, "DOOR01", "open")
    elseif Var.currentsummon == 2 then
        cDoorAction(Var.door02, "DOOR02", "open")
    elseif Var.currentsummon == 3 then
        cDoorAction(Var.door03, "DOOR03", "open")
    elseif Var.currentsummon == 4 then
        cDoorAction(Var.door04, "DOOR04", "open")
    elseif Var.currentsummon == 5 then
        cDoorAction(Var.door05, "DOOR05", "open")
    elseif Var.currentsummon == 6 then
        cDoorAction(Var.door06, "DOOR06", "open")
    elseif Var.currentsummon == 7 then
        cDoorAction(Var.door07, "DOOR07", "open")
    elseif Var.currentsummon == 8 then
        cDoorAction(Var.door08, "DOOR08", "open")
    end
    Var.StepFunc = Start
end


function Success(Var)
    cExecCheck "S_Tower02 - Success"

    if not Var.Contador then
        cTimer(Var.MapIndex, ReturnTime)
        cQuestResult(Var.MapIndex, "Success")
        cScriptMessage(Var.MapIndex, "ControlTexto", tostring(ReturnDialog))
        Var.ExitTime = cCurrentSecond() + ReturnTime
        Var.Contador = true
    end
    if Var.Contador == true and Var.ExitTime < cCurrentSecond() then
        cLinkToAll(Var.MapIndex, ReturnMap.Inx, ReturnMap.x, ReturnMap.y)
        Var.StepFunc = Dummy
    end
end

function Dummy(Field)
    cExecCheck "S_Tower02 - Dummy"

    InstanceField[Field] = nil
end