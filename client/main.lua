local config = require 'config.client'
local sharedConfig = require 'config.shared'
local vehicleToTow

local function isTowVehicle(entity)
    for i = 1, #config.towVehicleModels do
        if GetEntityModel(entity) == config.towVehicleModels[i] then
            return true
        end
    end
    return false
end

local function attachVehicle(towerVehicle, towedVehicle)
    if not towerVehicle or not towedVehicle then return end

    print(#(GetEntityCoords(towerVehicle) - GetEntityCoords(towedVehicle)))
    if #(GetEntityCoords(towerVehicle) - GetEntityCoords(towedVehicle)) > 15 then
        exports.qbx_core:Notify("Vehicle is too far away", "error")
        return
    end

    local towerModel = GetEntityModel(towerVehicle)
    local offsetCoords = config.offsets.tow.coords[towerModel] or vec3(0.0, 0.0, 0.0)
    local offsetRot = config.offsets.tow.rot[towerModel] or vec3(0.0, 0.0, 0.0)
    if not offsetCoords or not offsetRot or not towerModel then return end

    AttachEntityToEntity(towedVehicle, towerVehicle, GetEntityBoneIndexByName(towerVehicle, config.offsets.bone[towerModel]),
    offsetCoords.x, offsetCoords.y, offsetCoords.z,
    offsetRot.x, offsetRot.y, offsetRot.z,
    true, true, false, false, 0, true)
    FreezeEntityPosition(towedVehicle, true)
end

local function detachVehicle(towerVehicle, towedVehicle)
    if not towerVehicle then return end

    local towerModel = GetEntityModel(towerVehicle)
    local offsetCoords = config.offsets.drop.coords[towerModel] or vec3(0.0, 0.0, 0.0)
    local offsetRot = config.offsets.drop.rot[towerModel] or vec3(0.0, 0.0, 0.0)

    if not offsetCoords or not offsetRot or not towerModel then return end
    if not IsEntityAttachedToEntity(towedVehicle, towerVehicle) then return end

    FreezeEntityPosition(towedVehicle, false)
    Wait(250)
    AttachEntityToEntity(towedVehicle, towerVehicle, config.offsets.bone[towerModel],
    offsetCoords.x, offsetCoords.y, offsetCoords.z,
    offsetRot.x, offsetRot.y, offsetRot.z,
    false, false, false, false, 20, true)
    DetachEntity(towedVehicle, true, true)
end

local function towVehicle(data)
    local towerVehicle = data.entity
    local towedVehicle = vehicleToTow
    vehicleToTow = nil

    local vehicleState = Entity(towerVehicle).state
    if vehicleState?.towedVehicle then
        if not DoesEntityExist(vehicleState.towedVehicle) then
            vehicleState:set('towedVehicle', nil, true)
            return
        else
            towedVehicle = vehicleState.towedVehicle
        end

        if lib.progressBar({
            duration = 10,
            label = locale("progress.untowing_vehicle"),
            canCancel = true,
            allowRagdoll = false,
            allowSwimming = false,
            allowCuffed = false,
            allowFalling = false,
            disable = {
                move = true,
                car = true,
                combat = true,
                sprint = true
            },
            anim = {
                dict = 'mini@repair',
                clip = 'fixing_a_ped'
            },
        }) then
            detachVehicle(towerVehicle, towedVehicle)
            vehicleState:set('towedVehicle', nil, true)
        else
            exports.qbx_core:Notify(locale("error.canceled"), "error")
        end
        return
    end

    if #(GetEntityCoords(towerVehicle) - GetEntityCoords(towedVehicle)) > 15 then
        exports.qbx_core:Notify("Vehicle is too far away", "error")
        return
    end

    if lib.progressBar({
        duration = 10,
        label = locale("progress.towing_vehicle"),
        allowRagdoll = false,
        allowSwimming = false,
        allowCuffed = false,
        allowFalling = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            sprint = true
        },
        anim = {
            dict = 'mini@repair',
            clip = 'fixing_a_ped'
        },
    }) then
        attachVehicle(towerVehicle, towedVehicle)
        vehicleState:set('towedVehicle', towedVehicle, true)
    else
        exports.qbx_core:Notify(locale("error.canceled"), "error")
    end
end

local function setupTarget()
    exports.ox_target:addModel(config.towVehicleModels, {
        {
            name = "towVehicle",
            icon = "fas fa-truck-pickup",
            label = "Attach vehicle",
            distance = 7.5,
            groups = sharedConfig.restrictToGroups and sharedConfig.towGroups,
            canInteract = function(entity)
                local vehicleState = Entity(entity).state
                return not vehicleState.towedVehicle
            end,
            onSelect = function(data)
                if not vehicleToTow then
                    exports.qbx_core:Notify("No vehicle set to tow", "error")
                    return
                end
                towVehicle(data)
            end
        },
        {
            name = "untowVehicle",
            icon = "fas fa-truck-pickup",
            label = "Detach vehicle",
            distance = 7.5,
            groups = sharedConfig.restrictToGroups and sharedConfig.towGroups,
            canInteract = function(entity)
                local vehicleState = Entity(entity).state
                return not not vehicleState.towedVehicle
            end,
            onSelect = towVehicle
        }
    })

    exports.ox_target:addGlobalVehicle({
        {
            name = "setTowedVehicle",
            icon = "fas fa-truck-pickup",
            label = "Set vehicle as tow target",
            distance = 7.5,
            groups = sharedConfig.restrictToGroups and sharedConfig.towGroups,
            canInteract = function (entity)
                return not isTowVehicle(entity)
            end,
            onSelect = function(data)
                vehicleToTow = data.entity
                exports.qbx_core:Notify("Vehicle set to tow", "inform")
            end
        }
    })
end

local function clearTarget()
end

AddEventHandler('onResourceStart', function(resource)
   if resource == GetCurrentResourceName() then
        setupTarget()
   end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        clearTarget()
    end
end)