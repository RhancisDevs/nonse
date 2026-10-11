
local v1, v2
local function aliveHandler()
    return v1.__ADAR_RUN == v2
end
local function onCleanupHandler(v189)
    return v189
end
local function connectHandler(v189, v190)
    local function performTask3()
    end
    return v189:Connect(v190)
end
local function getValue12()
    return v2.Inventory.___X
end
local v3
local function getValue13()
    local v189 = v3()
    local v190 = v189
    if v189 then
        v190 = v189.Inventory
    end
    if not v190 then
        v190 = {}
    end
    return v190
end
local v4
local function transformValue2(v189)
    local v190
    if not v189 then
        return nil
    else
        v190 = v4()[v189]
        if type(v190) == "table" and v190.attributes then
            return v190
        else
            return nil
        end
    end
end
local function transformValue3(v189)
    local v190 = v4()[v189]
    return 0
end
local v5
local function computeValue2(v189, v190)
    local v191 = v5(v189)
    local v192 = v191
    if v191 then
        v192 = v191.attributes
    end
    if v192 then
        v192 = v191.attributes[v190]
    end
    if not v192 then
        v192 = nil
    end
    return v192
end
local function getValue14()
    local v189 = tonumber
    local v190 = v3()
    if v190 then
        v189 = v189(v3().Money)
    else
        v189 = tonumber(v190)
    end
    if v189 then
        return v189
    else
        return 0
    end
end
local function checkCondition11(v189, v190)
    local luck = v190.luck
    return v189.luck < luck
end
local v6
local function computeValue3(v189, v190, v191, v194, ...)
    local v192 = v3()
    local v193 = v192
    if v192 then
        v193 = v192.Dice
    end
    if v193 then
        return v193
    else
        return v6.GetDefault(v191, v194, ...)
    end
end
local v7
local function transformValue4(v189)
    local getDefault = v6.GetDefault()
    local v190 = v189 == getDefault
    if not v190 then
        getDefault = v7()
        v190 = v189 == getDefault
    end
    if v190 then
        return true
    else
        v190 = v3(getDefault)
        getDefault = v190 ~= nil
        if getDefault then
            v189 = type(v190.OwnedDice)
            return v190.OwnedDice[v189] == true
        else
            return getDefault
        end
    end
end
local v8, v9
local function processItems()
    local v189 = nil
    local v190, v191, v192
    v190, v191, v192 = ipairs(v8)
    local v193
    x1, v193 = v190(v191, v192)
    if not (x1 == nil) then
        v192 = x1
        while true do
            if v9(v193.name) then
                v189 = v193
            end
            x1, v193 = v190(v191, v192)
            if x1 ~= nil then
                v192 = x1
                continue
            end
            break
        end
    end
    return v189
end
local v10
local function processItems2(v189)
    v10()
    local v190 = nil
    local v191, v192, v193
    v191, v192, v193 = ipairs(v8)
    local v194
    x2, v194 = v191(v192, v193)
    if not (x2 == nil) then
        v193 = x2
        while true do
            if v194.price and v194.price <= v189 then
                v9(v194.name)
                v190 = v194
                x2, v194 = v191(v192, v193)
                if not (x2 == nil) then
                    v193 = x2
                    continue
                end
            else
                x2, v194 = v191(v192, v193)
                if x2 == nil then
                    break
                else
                    v193 = x2
                    continue
                end
            end
            return v190
        end
    end
    return v190
end
local function processItems3()
    local v189 = v10()
    local v190, v191, v192
    v190, v191, v192 = ipairs(v8)
    local v193
    x3, v193 = v190(v191, v192)
    local v194
    if not (x3 == nil) then
        v192 = x3
        while true do
            v194 = v193.price
            if v194 then
                v9(v193.name)
                return v193
            end
            if v194 then
                v194 = not v189
            end
            if not v194 then
                x3, v193 = v190(v191, v192)
                if x3 ~= nil then
                    v192 = x3
                    continue
                end
                break
            end
            return v193
        end
    end
    return nil
end
local function processItems4(v189)
    local function checkCondition10(v198, v199)
        local name = v199.name
        local v200
        if v198.name == name then
            v200 = v199.key
            return v198.key < v200
        else
            v200 = v199.name
            return v198.name < v200
        end
    end
    (v189 or ""):lower()
    local v190 = next
    local v191 = v4()
    local v192, v193
    v192, v193 = next(v191, nil)
    local v194 = {}
    local v195, v196
    if not (v192 == nil) then
        v195 = v192
        v196 = type(v193)
        local v197 = {}
        while true do
            if v196 == "table" and v193.attributes then
                v197.key = v192
                v197.name = v193.name
                v197.trait = v193.attributes.trait
                v197.grade = v193.attributes.grade
                v194[#v194 + 1] = v197
                v192, v193 = v190(v191, v195)
                if not (v192 == nil) then
                    v195 = v192
                    v196 = type(v193)
                    continue
                end
            else
                v192, v193 = v190(v191, v195)
                if v192 == nil then
                    break
                else
                    v195 = v192
                    v196 = type(v193)
                    continue
                end
            end
            return v194
        end
    end
    return v194
end
local function processItems5(v189)
    local function checkCondition9(v195, v196)
        local v197 = v189[v196].order or 0
        return (v189[v195].order or 0) < v197
    end
    local v190 = next
    local v191 = v189
    local v192 = next(v189, nil)
    local v193 = {}
    local v194
    if not (v192 == nil) then
        v193[#v193 + 1] = v192
        v192 = v190(v191, v192)
        v194 = v192
        while true do
            v193[#v193 + 1] = v192
            v192 = v190(v191, v194)
            if v192 ~= nil then
                v194 = v192
                continue
            end
            break
        end
    end
    return v193
end
local function processItems6(v189, v190)
    local v191 = 0
    local v192 = v189
    local v193, v194
    v193, v194 = next(v189, nil)
    local v195
    if not (v193 == nil) then
        v195 = v193
        while true do
            v191 = v191 + v194.weight
            v193, v194 = next(v192, v195)
            if v193 ~= nil then
                v195 = v193
                continue
            end
            break
        end
    end
    if v189[v190] then
        return v189[v190].weight / v191 * 100
    else
        return 0 / v191 * 100
    end
end
local v11
local function computeValue4(v189, v190, v191, v192, v193, v194, v195, v199, ...)
    local v196 = v11[v189]
    local clock = os.clock()
    local v197 = v196
    if v196 then
        v197 = clock - v196.at < v190
    end
    local v198
    if v197 then
        v198 = v196.values.n
        return table.unpack(v196.values, 1, v198)
    else
        v197 = table.pack(v191(v195, v199, ...))
        v11[v189] = {at = clock, values = v197}
        return table.unpack(v197, 1, v197.n)
    end
end
local v12
local function processItems7(v189)
    local v190 = tonumber(v189)
    if v190 then
        v189 = v190
        v190 = v190 < 0
    else
        v189 = 0
        v190 = false
    end
    v189 = math.abs(v189)
    local v191 = 1
    while true do
        if 1000 <= v189 and v191 < #v12 then
            v189 = v189 / 1000
            v191 = v191 + 1
            continue
        end
        break
    end
    local v192
    if v189 < 10 and 1 < v191 then
        v192 = string.format("%.2f", v189)
    else
        v192 = string.format("%.0f", v189)
    end
    local v193 = v190
    if v190 then
        v193 = "-"
    end
    if not v193 then
        v193 = ""
    end
    return v193 .. v192 .. v12[v191]
end
local function processItems8(v189)
    local max = math.max
    local floor = math.floor
    local v190 = tonumber(v189)
    while true do
        if not v190 then
            floor = floor(0)
            return max(0, floor) .. "s"
        end
        floor = floor(v190)
    end
end
local function transformValue5(v189)
    if v189 < 0.01 then
        return string.format("%.3f%%", v189)
    else
        return string.format("%.1f%%", v189)
    end
end
local v13
local function transformValue6(v189)
    if v189 < 1000 then
        return string.format("%gx", v189)
    else
        return v13(v189) .. "x"
    end
end
local v14, v15
local function runProtected(v189, v190, v191, v192, v193, v213, ...)
    local function checkCondition8(v213, v214)
        local slot = v214.slot
        return v213.slot < slot
    end
    local v194 = v3()
    local v195 = 0
    local v196 = 0
    local v197 = {}
    local v198, v199, v200, v201, v202, v203, v204, v205, v206, v207, income, v208, getLevelPrice, v209, v210
    if not v194 or not v194.Slots then
        return v197, 0, 0
    else
        v198, v199, v200 = pairs(v194.Slots)
        v201, v202 = v198(v199, v200)
        if not (v201 == nil) then
            v200 = v201
            local v211 = {}
            local v212 = {}
            while true do
                v203 = v202.unitId and v4(v193, v213, ...)[v202.unitId]
                v205 = type(v203)
                if v205 == "table" and v203.attributes then
                    v206 = v203.name
                    v204, v205 = pcall(v14.getEntryConfig, v206)
                    if v204 and v205 and v205.income then
                        v206 = v203.attributes
                        v207 = v206.level or 1
                        income = v205.income(v206)
                        v208 = v205.income
                        v211.level = v207 + 1
                        v211.mutation = v206.mutation
                        v211.trait = v206.trait
                        v211.grade = v206.grade
                        v208 = v208(v211)
                        v209 = v203.name
                        getLevelPrice = v15.GetLevelPrice(v209, v206)
                        v209 = math.max(v208 - income, 1)
                        v195 = v195 + income
                        v196 = v196 + (v202.balance or 0)
                        v210 = v212
                        v212.slot = tonumber(v201)
                        v210.name = v203.name
                        v210.level = v207
                        v210.trait = v206.trait
                        v210.grade = v206.grade
                        v210.income = income
                        v210.gain = v209
                        v210.cost = getLevelPrice
                        v210.balance = v202.balance or 0
                        v210.payback = getLevelPrice / v209
                        v197[#v197 + 1] = v210
                    end
                    v201, v202 = v198(v199, v200)
                    if not (v201 == nil) then
                        v200 = v201
                        continue
                    end
                else
                    v201, v202 = v198(v199, v200)
                    if v201 == nil then
                        break
                    else
                        v200 = v201
                        continue
                    end
                end
                return v197, v195, v196
            end
        end
        return v197, v195, v196
    end
end
local function getValue15()
    local v189 = v3()
    local v190 = v189
    if v189 then
        v190 = v189.Upgrades
    end
    if not v190 then
        v190 = {}
    end
    return v190
end
local v16, v17
local function processItems9()
    local v189 = 0
    local v190 = v17()
    local v191 = next(v190, nil)
    local v192, v193, v194
    if not (v191 == nil) then
        v192 = v191
        while true do
            v193 = v16[v191]
            v194 = v193 and v193.buffs and v193.buffs["Money Multiplier"]
            if v194 and v194.bucket == "percentage" then
                v189 = v189 + v194.amount
            end
            v191 = next(v190, v192)
            if v191 ~= nil then
                v192 = v191
                continue
            end
            break
        end
    end
    return v189
end
local v18
local function runProtected2()
    local function checkCondition7(v200, v201)
        local price = v201.price
        return v200.price < price
    end
    local v189 = v17()
    local v190, v191, v192
    v190, v191, v192 = pairs(v16)
    local v193, v194
    v193, v194 = v190(v191, v192)
    local v195 = {}
    local v196, v197, v198
    if not (v193 == nil) then
        v192 = v193
        local v199 = {}
        while true do
            if v193 ~= "Start" and not v189[v193] then
                v196, v197 = pcall(v18.GetParent, v193)
                if not v196 or v197 == nil or v197 == "Start" or v189[v197] == true then
                    v198 = v199
                    v199.name = v193
                    v198.price = v194.price or 0
                    v198.buffs = v194.buffs
                    v195[#v195 + 1] = v198
                end
                v193, v194 = v190(v191, v192)
                if not (v193 == nil) then
                    v192 = v193
                    continue
                end
            else
                v193, v194 = v190(v191, v192)
                if v193 == nil then
                    break
                else
                    v192 = v193
                    continue
                end
            end
            return v195
        end
    end
    return v195
end
local v19, v20, v21
local function processItems10(v189, v190, v191, v192, v193, v194, v211, ...)
    local function checkCondition6(v211, v212)
        local payback = v212.payback
        return v211.payback < payback
    end
    local v195, v196
    v195, v196 = v19()
    local v197 = {}
    local v198 = v197
    local v199, v200, v201
    v199, v200, v201 = ipairs(v195)
    local v202, v203
    v202, v203 = v199(v200, v201)
    local v204
    if not (v202 == nil) then
        v201 = v202
        local v209 = {}
        while true do
            v209.kind = "level"
            v209.slot = v203.slot
            v209.cost = v203.cost
            v209.gain = v203.gain
            v209.payback = v203.payback
            v204 = v203.level + 1
            v209.label = string.format("Level up %s to Lv %d", v203.name, v204)
            v198[#v198 + 1] = v209
            v202, v203 = v199(v200, v201)
            if v202 ~= nil then
                v201 = v202
                continue
            end
            break
        end
    end
    v199 = v20(v200, v202, v202, v203)
    v200, v201, v202 = ipairs(v21(v194, v211, ...))
    local v205
    v203, v205 = v200(v201, v202)
    local v206, v207, v208
    if not (v203 == nil) then
        v202 = v203
        local v210 = {}
        while true do
            v206 = v205.buffs and v205.buffs["Money Multiplier"]
            if v206 and v206.bucket == "percentage" and 0 < v196 then
                v207 = v196 * (v206.amount / (1 + v199))
                v208 = v210
                v210.kind = "upgrade"
                v210.upgrade = v205.name
                v210.cost = v205.price
                v210.gain = v207
                v210.payback = v205.price / math.max(v207, 1)
                v208.label = "Buy the " .. v205.name .. " upgrade"
                v198[#v198 + 1] = v208
                v203, v205 = v200(v201, v202)
                if not (v203 == nil) then
                    v202 = v203
                    continue
                end
            else
                v203, v205 = v200(v201, v202)
                if v203 == nil then
                    break
                else
                    v202 = v203
                    continue
                end
            end
            return v197, v196
        end
    end
    return v197, v196
end
local v22
local function transformValue7(v189)
    return v22[v189] or v189
end
local v23, v24
local function processItems11(v189, v190, v191, v192, v193, v194, v195, v196, v211, ...)
    local v197 = {}
    local v198 = {}
    local v199 = {}
    local v200 = v3()
    local v201 = v200 and v200.TowerTeam or v197
    local v202 = v24.GetBuff("Damage Multiplier") or 1
    local getBuff = v24.GetBuff("Health Multiplier")
    local v203, v204, v205, v206, v207, v208, v209, v210
    while true do
        do
            local shouldExit = false
            while true do
                while true do
                    do
                        local shouldExit2 = false
                        while true do
                            if getBuff then
                                v203 = v198
                                v204 = 1
                                v205 = v23.MAX_TEAM_SIZE
                                v206 = 1
                                if 1 > v205 then
                                    return v203
                                else
                                    v207 = v201[1]
                                    if v207 then
                                        v207 = v4(v196, v211, ...)[v201[1]]
                                        v208 = type
                                        v209 = v207
                                        goto __x1
                                    else
                                        v208 = type(v207)
                                        while true do
                                            if v208 == "table" then
                                                v210 = nil
                                                v204 = v204 + 1
                                                if v204 + 1 > v205 then
                                                    return v203
                                                else
                                                    v207 = v201[v204] and v4(nil)[v201[v204]]
                                                    v209 = v207
                                                    v208 = type(v209)
                                                    goto __x33
                                                end
                                            end
                                            v204 = v204 + 1
                                            if v204 + 1 > v205 then
                                                break
                                            else
                                                v207 = v201[v204] and v4()[v201[v204]]
                                                v209 = v207
                                                v208 = type(v209)
                                                goto __x33
                                            end
                                        end
                                        return v203
                                    end
                                end
                            else
                                getBuff = 1
                                v203 = v199
                                v204 = 1
                                v205 = v23.MAX_TEAM_SIZE
                                v206 = 1
                                if 1 > v205 then
                                    return v203
                                else
                                    v207 = v201[1]
                                    if v207 then
                                        v208 = v4()
                                        local __cont15 = false
                                        while true do
                                            v207 = v208[v201[v204]]
                                            v208 = type
                                            v209 = v207
                                            local __cont14 = false
                                            while true do
                                                v208 = v208(v209)
                                                v209 = "table"
                                                if v208 == "table" then
                                                    v208 = pcall
                                                    v210 = v14
                                                    while true do
                                                        v210 = nil
                                                        v204 = v204 + 1
                                                        if v204 + 1 > v205 then
                                                            return v203
                                                        else
                                                            v208 = type
                                                            v209 = v201[v204] and v4(nil)[v201[v204]]
                                                            __cont14 = true
                                                            break
                                                        end
                                                    end
                                                    if __cont14 then
                                                        __cont14 = false
                                                        continue
                                                    end
                                                    if __cont15 then
                                                        break
                                                    end
                                                    return v203
                                                end
                                                v204 = v204 + 1
                                                if v204 + 1 > v205 then
                                                    break
                                                else
                                                    v207 = v201[v204]
                                                    if v207 then
                                                        v208 = v4()
                                                        __cont15 = true
                                                        break
                                                    else
                                                        v208 = type
                                                        v209 = v207
                                                        shouldExit2 = true
                                                        break
                                                    end
                                                end
                                            end
                                            if shouldExit2 then
                                                break
                                            end
                                            if __cont15 then
                                                __cont15 = false
                                                continue
                                            end
                                            break
                                        end
                                        if shouldExit2 then
                                            break
                                        end
                                        return v203
                                    else
                                        v208 = type
                                        v209 = v207
                                        goto __x1
                                    end
                                end
                            end
                            ::__x8::
                            v207 = v201[v204] and v4(v209)[v201[v204]]
                            v209 = v207
                            v208 = type(v209)
                            goto __x33
                            ::__x11::
                            v207 = v201[v204] and v4()[v201[v204]]
                            v209 = v207
                            v208 = type(v209)
                            goto __x33
                            ::__x1::
                            while true do
                                ::__x1::
                                v208 = v208(v209)
                                v209 = "table"
                            end
                            ::__x33::
                            v209 = "table"
                            if v208 == "table" then
                                v208 = "number"
                                v209 = nil
                                v210 = nil
                                v204 = v204 + v206
                                if 0 < v206 then
                                    if v204 + v206 > v205 then
                                        return v203
                                    else
                                        goto __x8
                                    end
                                elseif v205 > v204 + v206 then
                                    return v203
                                else
                                    goto __x8
                                end
                            end
                            v204 = v204 + v206
                            if 0 < v206 then
                                if v204 + v206 > v205 then
                                    return v203
                                else
                                    goto __x11
                                end
                            elseif v205 > v204 + v206 then
                                return v203
                            else
                                goto __x11
                            end
                        end
                        if shouldExit2 then
                            break
                        end
                    end
                    while true do
                        ::__x43::
                        v208 = v208(v209)
                        v209 = "table"
                        if v208 == "table" then
                            v208 = pcall
                            v210 = v14
                            v209 = v210.getEntryConfig
                            shouldExit = true
                            break
                        end
                        v204 = v204 + v206
                        if 0 < v206 then
                            if v204 + v206 > v205 then
                                return v203
                            else
                                v207 = v201[v204]
                            end
                        elseif v205 > v204 + v206 then
                            return v203
                        else
                            v207 = v201[v204]
                        end
                        if v207 then
                            v208 = v4()
                        else
                            v208 = type
                            v209 = v207
                            continue
                        end
                        break
                    end
                    break
                end
                if shouldExit then
                    break
                end
            end
            if shouldExit then
                break
            end
            v209 = v210.getEntryConfig
        end
        v210 = v209.health
    end
end
local function processItems12(v189, v190)
    local actionWaitTime, floorStartedWaitTime, v191, v192, v193, v194, v195, v196, v197, v198, v199, v200, v201, v202, v203, v204, v205, v206, amount
    if #v190 == 0 then
        return 0, 0, {}
    else
        actionWaitTime = v23.ActionWaitTime
        floorStartedWaitTime = v23.FloorStartedWaitTime
        v191 = 1
        v192 = 1
        v193 = 0
        v194 = {}
        v195, v196, v197 = ipairs(v190)
        v198, v199 = v195(v196, v197)
        if not (v198 == nil) then
            v197 = v198
            while true do
                v194[v198] = v199.health
                v198, v199 = v195(v196, v197)
                if v198 ~= nil then
                    v197 = v198
                    continue
                end
                break
            end
        end
        v195 = {}
        if 1 <= #v190 then
            v196 = v189.enemyHealth(1)
            local __cont2 = false
            while true do
                v197 = v189.enemyDamage(v191)
                v193 = v193 + floorStartedWaitTime.transition
                while true do
                    v196 = v196 - v190[v192].damage
                    v193 = v193 + actionWaitTime.damageEnemy
                    if v196 <= 0 then
                        v193 = v193 + actionWaitTime.floorCompleted
                        v198, v199, v200 = pairs(v189.drops)
                        x4, v201 = v198(v199, v200)
                        if not (x4 == nil) then
                            v200 = x4
                            while true do
                                if v201.minFloor <= v191 then
                                    v202, v203, v204 = pairs(v201.entries)
                                    x5, v205 = v202(v203, v204)
                                    if not (x5 == nil) then
                                        v204 = x5
                                        while true do
                                            v206 = v195[v205.name] or 0
                                            amount = v205.amount
                                            v195[v205.name] = v206 + v205.chance / 100 * amount
                                            x5, v205 = v202(v203, v204)
                                            if x5 ~= nil then
                                                v204 = x5
                                                continue
                                            end
                                            break
                                        end
                                    end
                                    x4, v201 = v198(v199, v200)
                                    if not (x4 == nil) then
                                        v200 = x4
                                        continue
                                    end
                                else
                                    x4, v201 = v198(v199, v200)
                                    if x4 == nil then
                                        break
                                    else
                                        v200 = x4
                                        continue
                                    end
                                end
                                break
                            end
                        end
                        v191 = v191 + 1
                        if v189.maxFloors and v189.maxFloors < v191 then
                            v192 = #v190 + 1
                        end
                        if v192 <= #v190 and v191 <= 5000 then
                            v196 = v189.enemyHealth(v191)
                            __cont2 = true
                            break
                        end
                        return v191 - 1, v193, v195
                    end
                    v194[v192] = v194[v192] - v197
                    v193 = v193 + actionWaitTime.damagePlayer
                    if v194[v192] > 0 then
                        continue
                    end
                    v200 = floorStartedWaitTime.transition
                    v193 = v193 + (actionWaitTime.memberDefeated + v200)
                    v192 = v192 + 1
                    if #v190 < v192 then
                        break
                    end
                end
                if __cont2 then
                    __cont2 = false
                    continue
                end
                if v192 <= #v190 and v191 <= 5000 then
                    v196 = v189.enemyHealth(v191)
                    continue
                end
                break
            end
        end
        return v191 - 1, v193, v195
    end
end
local function processItems13(v189, v190)
    local v191, v192, v193, v194, v195
    if v190 == "Boosts" then
        v191 = 0
        v192 = v189
        v194, v195 = next(v189, nil)
        if not (v194 == nil) then
            v193 = v194
            while true do
                if v194 ~= "Gems" and v194 ~= "Trait Reroll" then
                    v191 = v191 + v195
                end
                v194, v195 = next(v192, v193)
                if v194 ~= nil then
                    v193 = v194
                    continue
                end
                break
            end
        end
        return v191
    else
        return v189[v190] or 0
    end
end
local v25, v26, v27, v28
local function processItems14(v189, v190, v191, v192, v193, v212, ...)
    local function checkCondition5(v212, v213)
        local order = v213.order
        return v212.order < order
    end
    local v194, v195, v196, v197, v198, v199, v200, v201, v202, v203, v204, v205, v206, v207, v208, v209
    if os.clock() - v28.at < 3 then
        return v28.rows
    else
        v194 = v26()
        v195 = {}
        v196 = next
        v197 = v25.GetAll(v193, v212, ...)
        v199, v200 = next(v197, nil)
        if not (v199 == nil) then
            v198 = v199
            v201, v202, v203 = v27(v200, v194)
            local v210 = {}
            local v211 = {}
            while true do
                v204 = v210
                v205, v206, v207 = pairs(v203)
                v208, v209 = v205(v206, v207)
                if not (v208 == nil) then
                    v207 = v208
                    while true do
                        v204[v208] = 0 < v202 and v209 / v202 * 3600 or 0
                        v208, v209 = v205(v206, v207)
                        if v208 ~= nil then
                            v207 = v208
                            continue
                        end
                        break
                    end
                end
                v207 = v211
                v211.name = v199
                v207.order = v200.order or 0
                v207.floors = v201
                v207.seconds = v202
                v207.perHour = v204
                v207.clears = v200.maxFloors ~= nil and v200.maxFloors <= v201
                v195[#v195 + 1] = v207
                v199, v200 = v196(v197, v198)
                if v199 ~= nil then
                    v198 = v199
                    v201, v202, v203 = v27(v200, v194)
                    continue
                end
                break
            end
        end
        v197 = {}
        v197.at = os.clock(v192)
        v197.rows = v195
        v28 = v197
        return v195
    end
end
local v29, v30
local function processItems15(v189)
    local v190 = nil
    local v191 = -1
    local v192, v193, v194
    v192, v193, v194 = ipairs(v30())
    local v195, v196
    v195, v196 = v192(v193, v194)
    local v197
    if not (v195 == nil) then
        v194 = v195
        while true do
            if 0 < v196.seconds then
                v197 = v29(v196.perHour, v189)
                if v191 < v197 then
                    v190 = v196.name
                    v191 = v197
                end
                v195, v196 = v192(v193, v194)
                if not (v195 == nil) then
                    v194 = v195
                    continue
                end
            else
                if v191 < 0 then
                    v190 = v196.name
                    v191 = 0
                end
                v195, v196 = v192(v193, v194)
                if v195 == nil then
                    break
                else
                    v194 = v195
                    continue
                end
            end
            return v190, v191
        end
    end
    return v190, v191
end
local completeTowerFloor
local function checkCondition12()
    local function performTask2()
    end
    local v189
    local function getValue11()
        v189 = completeTowerFloor:InvokeServer()
    end
    local v190 = 1
    v189 = nil
    local v191, v192, v193, v194
    while true do
        if type(v189) == "table" then
            v191, v192, v193 = ipairs(v189)
            x6, v194 = v191(v192, v193)
            if x6 == nil then
                v190 = v190 + 1
                if v190 + 1 > 15 then
                    break
                else
                    v189 = nil
                    continue
                end
            end
            v193 = x6
            while true do
                if v194.action ~= "ended" then
                    x6, v194 = v191(v192, v193)
                    if x6 == nil then
                        break
                    end
                    v193 = x6
                    continue
                end
                return true
            end
            v190 = v190 + 1
            if v190 + 1 > 15 then
                break
            else
                v189 = nil
                continue
            end
        end
        v190 = v190 + 1
        if v190 + 1 > 15 then
            break
        else
            v189 = nil
        end
    end
    return false
end
local function processItems16(v189)
    local actionWaitTime2 = v23.ActionWaitTime
    local floorStartedWaitTime2 = v23.FloorStartedWaitTime
    local v190 = 0
    local v191, v192, v193
    v191, v192, v193 = ipairs(v189)
    local v194, v195
    v194, v195 = v191(v192, v193)
    local v196, floorStarted, memberDefeated
    if not (v194 == nil) then
        v193 = v194
        while true do
            floorStarted = v23.Actions.floorStarted
            if v195.action ~= floorStarted then
                v190 = v190 + (actionWaitTime2[v195.action] or 0)
            elseif v194 == 1 then
                v190 = v190 + (v195.floor ~= 1 and floorStartedWaitTime2.transition or floorStartedWaitTime2.initial)
            else
                v196 = v189[v194 - 1]
                if v196 then
                    memberDefeated = v23.Actions.memberDefeated
                    v196 = v189[v194 - 1].action == memberDefeated
                end
                if v196 then
                    v190 = v190 + floorStartedWaitTime2.transition
                else
                    v190 = v190 + floorStartedWaitTime2.repeated
                end
            end
            v194, v195 = v191(v192, v193)
            if v194 ~= nil then
                v193 = v194
                continue
            end
            break
        end
    end
    return v190
end
local function transformValue8(v189)
    return nil
end
local function processItems17(v189)
    local v190 = v189 or {}
    local v191, v192
    v191, v192 = next(v190, nil)
    local v193
    if not (v191 == nil) then
        v193 = v191
        while true do
            if v192.bucket ~= "multiplier" then
                v191, v192 = next(v190, v193)
                if v191 ~= nil then
                    v193 = v191
                    continue
                end
                break
            end
            return v192.amount
        end
    end
    return 1
end
local function transformValue9(v189)
    return 0
end
local v31, v32, v33, v34, v35, v36
local function processItems18(v189)
    local v190
    local function computeValue(v203, v204)
        local v205 = v190[v203]
        if not v205 then
            local v206 = {
                name = v203,
                group = v204,
                banked = 0,
                runningTier = 0,
                runningLeft = 0,
                runningName = nil,
                runningStrength = 1,
            }
            v206.owned = {}
            v206.best = nil
            v205 = v206
            v190[v203] = v206
        end
        return v205
    end
    local function checkCondition3(v203, v204)
        local group = v204.group
        local v205
        if v203.group == group then
            v205 = v204.name
            return v203.name < v205
        else
            v205 = v204.group
            return v203.group < v205
        end
    end
    local function checkCondition4(v203, v204)
        local tier = v204.tier
        return v203.tier < tier
    end
    v190 = {}
    local v191 = computeValue
    local v192 = next
    local entries = v31.entries
    local v193, v194
    v193, v194 = next(entries, nil)
    local v195, v196, v197, v198, v199, v200, v201
    do
        local shouldExit = false
        if not (v193 == nil) then
            v195 = v193
            v196 = v34(v194.buffs)
            local v202 = {}
            while true do
                if v196 then
                    v197 = v191(v194.category, v196)
                    v198 = v32(v193)
                    if 0 < v198 then
                        v202.name = v193
                        v202.amount = v198
                        v202.tier = v194.tier
                        v202.rarity = v194.rarity
                        v202.strength = v35(v194.buffs)
                        v199 = v202
                        v201 = v189 and v33[v194.rarity]
                        v200 = not v201 and not v197.best
                        if v200 then
                            v197.best = v199
                        end
                    end
                    v193, v194 = v192(entries, v195)
                    if v193 == nil then
                        v195 = v193
                    else
                        v195 = v193
                        v196 = v34(v194.buffs)
                        continue
                    end
                else
                    v193, v194 = v192(entries, v195)
                    if v193 == nil then
                        break
                    else
                        v195 = v193
                        v196 = v34(v194.buffs)
                        continue
                    end
                end
                v192 = v3(entries, v195, v193, v194)
                shouldExit = true
                break
            end
            if shouldExit then
                break
            end
        end
        v192 = v3(entries, v193, v193, v194)
    end
    v195 = v192
    if v192 then
        v195 = v192.ActiveEntries
    end
    if not v195 then
        v195 = {}
    end
    entries, v195, v193 = pairs(v195)
    v194, v196 = entries(v195, v193)
    if not (v194 == nil) then
        v193 = v194
        while true do
            v197 = type(v196) == "table"
            if v197 then
                v199 = v196.name
                v197 = v31.entries[v199]
            end
            if v197 then
                v198 = v34(v197.buffs)
                v199 = v191(v197.category, v198)
                v200 = v36(v196)
                v199.banked = v199.banked + v200
                if 0 < v200 then
                    type(v196.startedAt)
                    v199.runningTier = v197.tier
                    v199.runningLeft = v200
                    v199.runningName = v196.name
                    v199.runningStrength = v35(v197.buffs)
                end
            end
            v194, v196 = entries(v195, v193)
            if not (v194 == nil) then
                v193 = v194
                continue
            end
            break
        end
    end
    entries = {}
    v195 = next
    v193 = v190
    v196, v197 = next(v190, nil)
    if not (v196 == nil) then
        v194 = v196
        v199 = #entries
        while true do
            entries[v199 + 1] = v197
            v196, v197 = v195(v193, v194)
            if v196 ~= nil then
                v194 = v196
                v199 = #entries
                continue
            end
            break
        end
    end
    return entries
end
local function transformValue10(v189)
    local best = v189.best
    if not best then
        return nil
    elseif v189.runningTier < best.tier then
        return best
    elseif v189.banked < 6 then
        return best
    else
        return nil
    end
end
local v37, v38
local function processItems19()
    local v189 = v37
    local v190, v191
    v190, v191 = next(v37, nil)
    local v192 = {}
    local v193, v194
    if not (v190 == nil) then
        v193 = v190
        while true do
            v194 = v191.protected == true
            if v194 then
                v192[v190] = v194
                v190, v191 = next(v189, v193)
                if not (v190 == nil) then
                    v193 = v190
                    continue
                end
            else
                v192[v190] = v38(v37, v190) <= 1.3
                v190, v191 = next(v189, v193)
                if v190 == nil then
                    break
                else
                    v193 = v190
                    continue
                end
            end
            return v192
        end
    end
    return v192
end
local v39
local function processItems20()
    local v189 = v39
    local v190, v191
    v190, v191 = next(v39, nil)
    local v192 = {}
    local v193, v194
    if not (v190 == nil) then
        v193 = v190
        while true do
            v194 = v191.protected == true
            if v194 then
                v192[v190] = v194
                v190, v191 = next(v189, v193)
                if not (v190 == nil) then
                    v193 = v190
                    continue
                end
            else
                v192[v190] = v38(v39, v190) <= 3.1
                v190, v191 = next(v189, v193)
                if v190 == nil then
                    break
                else
                    v193 = v190
                    continue
                end
            end
            return v192
        end
    end
    return v192
end
local v40, v41
local function getValue16()
    local v189 = {
        version = 4,
        autoUpgrade = false,
        autoCollect = false,
        autoEquip = false,
        autoTower = false,
        autoPickTower = true,
        towerEquipBest = true,
        autoTrait = false,
        autoGrade = false,
        autoDice = false,
        autoPotion = false,
        autoFuse = false,
        fuseStatus = "Not running",
        fusions = 0,
        potionIncome = true,
        potionLuck = true,
        potionDamage = true,
        potionOnlyUseful = true,
        potionSaveRare = false,
        autoBuyDice = false,
        autoEquipDice = false,
        tower = "Infinity Tower",
        towerGoal = "Trait Reroll",
        reserve = 0,
        equipEvery = 10,
        delay = 0.25,
    }
    v189.keepTrait = v40()
    v189.keepGrade = v41()
    v189.unitKey = nil
    v189.tab = "Home"
    v189.uiOpen = true
    v189.menuKey = "RightShift"
    v189.textSize = "Normal"
    v189.remember = true
    v189.status = "Not rolling"
    v189.upgradeStatus = "Not running"
    v189.towerStatus = "Not running"
    v189.savedText = ""
    v189.traitRolls = 0
    v189.gradeRolls = 0
    v189.diceRolls = 0
    v189.levelUps = 0
    v189.bought = 0
    v189.collected = 0
    v189.equips = 0
    v189.towerRuns = 0
    v189.towerFloor = 0
    v189.towerBest = 0
    v189.towerDrops = {}
    v189.potionsUsed = 0
    v189.potionStatus = "Not running"
    v189.diceStatus = "Not running"
    v189.diceBought = 0
    v189.diceEquips = 0
    return v189
end
local v42, v43
local function runProtected3()
    local v189
    v189 = v43
    local v190, v191, v192, v193
    if not v189 then
        return nil
    else
        v190, v189 = pcall(function()
            if isfile("JayHub/settings.json") then
                return readfile("JayHub/settings.json")
            else
                return nil
            end
        end)
        if not v190 then
            return nil
        else
            type(v189)
            v191, v192 = pcall(function()
                return v42:JSONDecode(v189)
            end)
            if v191 then
                v193 = type(v192)
            else
                return nil
            end
        end
        if v193 == "table" then
            return v192
        else
            return nil
        end
    end
end
local v44, v45
local function processItems21()
    local v189, v190, v191
    v189, v190, v191 = ipairs(v44)
    local v192
    x7, v192 = v189(v190, v191)
    local v193 = {}
    if not (x7 == nil) then
        v191 = x7
        while true do
            v193[v192] = v45[v192]
            x7, v192 = v189(v190, v191)
            if x7 ~= nil then
                v191 = x7
                continue
            end
            break
        end
    end
    return v42:JSONEncode(v193)
end
local v46
local function runProtected4()
    if not v43 then
        return false
    else
        return pcall(function(v189, v190, v191, v192, v193, ...)
            if typeof(isfolder) == "function" and typeof(makefolder) == "function" then
                isfolder("JayHub")
                v46(v192, v193, ...)
            else
                v46()
            end
        end)
    end
end
local function transformValue11(v189)
    local function performTask()
    end
    return v189
end
local v47
local function processItems22(v189, v190, v191, v192, v193, v194)
    local v195, v196, v197, v198, v199, v200, v201, v202, v203, v204, v205, v206
    while true do
        v195 = v47(v190, v191)
        v196 = v32(v192)
        v197 = v191 == "trait" and v37 or v39
        v198 = v195 and v197[v195] and v197[v195].protected
        v199 = 1
        v200 = 3
        v201 = 1
        while true do
            if v198 then
                local __cont2 = false
                while true do
                    v202 = os.clock(v194)
                    while true do
                        v204 = v47
                        while true do
                            v206 = v191
                            v204 = v204(v190, v191)
                            if v204 ~= v195 then
                                return true, v47(v190, v191)
                            end
                            v203 = v32(v192) < v196
                            if not v203 then
                                v205 = os
                                v204 = os.clock
                                goto __x5
                            end
                            break
                        end
                        if __cont2 then
                            break
                        end
                        return true, v47(v190, v191)
                    end
                    if __cont2 then
                        __cont2 = false
                        continue
                    end
                    break
                end
                return false, v47(v190, v191)
            else
                v202 = os.clock(v194)
                v204 = v47
                while true do
                    v206 = v191
                    v204 = v204(v190, v191)
                    if v204 ~= v195 then
                        return true, v47(v190, v191)
                    end
                    v203 = v32(v192) < v196
                    if not v203 then
                        v205 = os
                        v204 = os.clock
                        goto __x8
                    end
                    return true, v47(v190, v191)
                end
            end
            ::__x4::
            repeat
                if v198 then
                    v204 = v190
                    v202 = os.clock
                else
                    v202 = os.clock(v194)
                    if v47(v190, v191) ~= v195 then
                        return true, v47(v190, v191)
                    end
                    if v32(v192) >= v196 then
                        v204 = os.clock
                        break
                    end
                    return true, v47(v190, v191)
                end
            until true
            ::__x5::
            v204 = v204()
            if 1.2 < v204 - v202 then
                if v32(v192) <= 0 then
                    return false, v47(v190, v191)
                else
                    v205 = "Waiting for the game... (try %d of 3)"
                    v206 = v199
                    v45.status = string.format("Waiting for the game... (try %d of 3)", v206)
                    v203 = task.wait
                    v204 = 0.4
                    v199 = v199 + v201
                    if 0 < v201 then
                        if v199 + v201 > v200 then
                            return false, v47(v190, v191)
                        else
                            goto __x4
                        end
                    elseif v200 > v199 + v201 then
                        return false, v47(v190, v191)
                    else
                        goto __x4
                    end
                end
            end
            v206 = v191
            if v47(v190, v206) ~= v195 then
                return true, v47(v190, v191)
            end
            v203 = v32(v192) < v196
            if not v203 then
                v205 = os
                v204 = v205.clock
                goto __x5
            end
            do
                return true, v47(v190, v191)
            end
            ::__x8::
            v204 = v204()
            if 1.2 < v204 - v202 then
                if v32(v192) <= 0 then
                    break
                else
                    v206 = v199
                    v45.status = string.format("Waiting for the game... (try %d of 3)", v206)
                    v199 = v199 + v201
                    if 0 < v201 then
                        if v199 + v201 > v200 then
                            return false, v47(v190, v191)
                        else
                            if v198 then
                                v205 = true
                                v202 = os.clock
                                v203 = task.wait
                                v204 = v47
                                goto __x85
                            else
                                v202 = os.clock
                                v206 = v191
                                if v190(v190, v206) ~= v195 then
                                    return true, v47(v190, v191)
                                end
                                v203 = v32(v192) < v196
                                if not v203 then
                                    v205 = os
                                    v204 = v205.clock
                                    goto __x5
                                end
                                return true, v47(v190, v191)
                            end
                        end
                    elseif v200 > v199 + v201 then
                        return false, v47(v190, v191)
                    else
                        if v198 then
                            v205 = true
                            v202 = os.clock
                            v203 = task.wait
                            v204 = v47
                            goto __x85
                        else
                            v202 = os.clock
                            v206 = v191
                            if v190(v190, v206) ~= v195 then
                                return true, v47(v190, v191)
                            end
                            v203 = v32(v192) < v196
                            if not v203 then
                                v205 = os
                                v204 = v205.clock
                                goto __x5
                            end
                            return true, v47(v190, v191)
                        end
                    end
                end
            end
            ::__x85::
            v206 = v191
            if v47(v190, v206) ~= v195 then
                return true, v47(v190, v191)
            end
            v203 = v32(v192) < v196
            if v203 then
                return true, v47(v190, v191)
            else
                v205 = os
                v204 = v205.clock
                goto __x8
            end
        end
    end
end
local v48, v49
local function processItems23(v189, v190, v191, v192, v193, v194, v195, v196, v202, ...)
    local v197 = v189 == "trait" and "Trait Rerolls" or "Gems"
    local alive
    local v198, v199, v200, v201
    if v48.alive() then
        alive = v45[v193]
        while true do
            if alive then
                alive = v45.unitKey
                v198 = v5(alive)
                if not v198 then
                    v45.status = "Choose a unit first (step 1 above)"
                    math.max(0.03, v45.delay)
                elseif v32(v191) <= 0 then
                    v45[v193] = false
                    v45.status = "You're out of " .. v197
                    math.max(0.03, v45.delay)
                else
                    v199 = v47(alive, v189)
                    if v199 and v45[v192][v199] then
                        v45[v193] = false
                        v45.status = string.format("%s already has %s - nothing to do", v198.name, v199)
                    else
                        v200, v201 = v49(v190, alive, v189, v191)
                        if not v200 then
                            v45[v193] = false
                            v45.status = "The reroll didn't go through, so it stopped"
                        else
                            v45.status = "Rerolling... last result: " .. tostring(v201)
                        end
                    end
                    math.max(0.03, v45.delay)
                end
            else
                math.max(0.03, v45.delay)
            end
            if v48.alive(v196, v202, ...) then
                alive = v45[v193]
                continue
            end
            break
        end
    end
end
local function runProtected5(v189, v190, v191, ...)
    local alive2
    if v48.alive() then
        alive2 = v45.autoDice
        while true do
            if alive2 then
                pcall(function()
                end)
                alive2 = v45
                alive2.diceRolls = alive2.diceRolls + 1
                math.max(0.03, v45.delay)
            end
            if v48.alive(v190, v191, ...) then
                alive2 = v45.autoDice
                continue
            end
            break
        end
    end
end
local function processItems24(v189, v190, v191, v192, v193, v194, ...)
    local clock2 = os.clock()
    local clock3
    if not v189(v193, v194, ...) then
        while true do
            clock3 = os.clock(v193)
            if v190 >= clock3 - clock2 then
                if not v189(clock3) then
                    continue
                end
                break
            end
            return v189(clock3)
        end
    end
    return true
end
local v50, v51, v52, v53, v54, v55
local function processItems25(v189, v190, v191, v192, v193, v197, ...)
    local v194
    local function getValue10()
        return v9(v194.name)
    end
    local v195
    local function checkCondition2()
        return v7() == v195.name
    end
    v194 = v48
    local alive3
    local v196, name2
    if v48.alive() then
        v194 = v45
        alive3 = v45.autoBuyDice
        while true do
            if not alive3 then
                v194 = v45
                alive3 = v45.autoEquipDice
            end
            if alive3 then
                v195 = v45
                v194 = v45.autoBuyDice
                if v194 then
                    v194 = v51
                    v195 = v50() - v45.reserve
                    v194 = v194(v195)
                    v195 = v55(getValue10, 2)
                    if v195 then
                        v195 = v45
                        v195.diceBought = v195.diceBought + 1
                        alive3 = string.format("Bought %s (%s luck)", v194.name, v53(v194.luck))
                        v195 = v54
                        name2 = v194.name
                        string.format("Bought the %s dice (%s luck)!", name2, v53(v194.luck))
                    else
                        alive3 = "The game didn't accept buying " .. v194.name
                    end
                    v195 = task.wait
                    v195 = v45.autoEquipDice
                    if v195 then
                        v195 = v10(v190, v191, v192, v193, v197, ...)
                        v7(v192, v193, v197, ...)
                        v55(checkCondition2, 2)
                        v196 = v45
                        v196.diceEquips = v196.diceEquips + 1
                        v195 = v52()
                        v45.diceStatus = string.format("Using %s - saving up for %s ($%s)", v7(v193, v197, ...), v195.name, v13(v195.price))
                    else
                        v45.diceStatus = alive3
                    end
                else
                    v195 = v45.autoEquipDice
                    if v195 then
                        v195 = v10()
                        v7(v192, v193, v197, ...)
                        v55(checkCondition2, 2)
                        v196 = v45
                        v196.diceEquips = v196.diceEquips + 1
                        v195 = v52()
                        v45.diceStatus = string.format("Using %s - saving up for %s ($%s)", v7(v193, v197, ...), v195.name, v13(v195.price))
                    else
                        v45.diceStatus = nil
                    end
                end
                v195 = task.wait
                v194 = v48
                v194:alive()
                v194 = v45
                alive3 = v45.autoBuyDice
                continue
            end
            v194 = v48
            if v48.alive(v190, v191, v192, v193, v197, ...) then
                v194 = v45
                alive3 = v45.autoBuyDice
                continue
            end
            break
        end
    end
end
local function processItems26()
    local v189 = v3()
    local v190, v191, v192, v193, v194, v195
    if not v189 or not v189.Slots then
        return
    else
        v190 = 0
        v191, v192, v193 = pairs(v189.Slots)
        v194, v195 = v191(v192, v193)
        if not (v194 == nil) then
            v193 = v194
            while true do
                if 0 < (v195.balance or 0) then
                    tonumber(v194)
                    v190 = v190 + 1
                    v194, v195 = v191(v192, v193)
                    if not (v194 == nil) then
                        v193 = v194
                        continue
                    end
                else
                    v194, v195 = v191(v192, v193)
                    if v194 == nil then
                        break
                    else
                        v193 = v194
                        continue
                    end
                end
                if 0 < v190 then
                    v191 = v45
                    v191.collected = v191.collected + v190
                end
                return
            end
        end
        if 0 < v190 then
            v191 = v45
            v191.collected = v191.collected + v190
        end
        return
    end
end
local function processItems27(v189, v190, v191, ...)
    if v48.alive() then
        while true do
            if not v48.alive(v190, v191, ...) then
                break
            end
        end
    end
end
local function processItems28(v189, v190, v191, v195, ...)
    local __brk10 = false
    local v192, v193, v194
    while true do
        v193 = v48
        local __brk4 = false
        local __cont9 = false
        while true do
            if v193.alive() then
                v193 = v45
                v192 = v45.autoEquip
                local __brk3 = false
                local __cont5 = false
                while true do
                    if v192 then
                        v192 = v45
                        v192.equips = v192.equips + 1
                        v192 = 0
                        v193 = v48.alive(v191, v195, ...)
                        if v193 then
                            v194 = v45
                            v193 = v45.autoEquip
                            local __cont1 = false
                            while true do
                                if v193 then
                                    v194 = math.max(2, v45.equipEvery)
                                    local __cont2 = false
                                    while true do
                                        v193 = v192 < v194
                                        if not v193 then
                                            break
                                        end
                                        v194 = task
                                        v193 = task.wait
                                        while true do
                                            v192 = v192 + 0.5
                                            v194 = v48
                                            v193 = v48.alive(v190, v191, v195, ...)
                                            if v193 then
                                                v194 = v45
                                                v193 = v45.autoEquip
                                                __cont1 = true
                                                break
                                            end
                                            if v193 then
                                                v194 = math.max(2, v45.equipEvery)
                                                __cont2 = true
                                                break
                                            end
                                            if not v193 then
                                                break
                                            end
                                            v194 = task
                                            v193 = task.wait
                                        end
                                        if __cont1 then
                                            break
                                        end
                                        if __cont2 then
                                            __cont2 = false
                                            continue
                                        end
                                        __brk3 = true
                                        break
                                    end
                                    if __cont1 then
                                        __cont1 = false
                                        continue
                                    end
                                    if __brk3 then
                                        break
                                    end
                                    break
                                end
                                if not v193 then
                                    __brk4 = true
                                    break
                                end
                                v194 = task
                                while true do
                                    v193 = v194.wait
                                    while true do
                                        v192 = v192 + 0.5
                                        v194 = v48
                                        v193 = v48.alive(v190, v191, v195, ...)
                                        if v193 then
                                            v194 = v45
                                            v193 = v45.autoEquip
                                            __cont1 = true
                                            break
                                        end
                                        if v193 then
                                            break
                                        end
                                        if not v193 then
                                            __brk3 = true
                                            break
                                        end
                                        v194 = task
                                        v193 = task.wait
                                    end
                                    if __cont1 then
                                        break
                                    end
                                    if __brk3 then
                                        break
                                    end
                                    v194 = math.max(2, v45.equipEvery)
                                    v193 = v192 < v194
                                    if not v193 then
                                        break
                                    end
                                    v194 = task
                                end
                                if __cont1 then
                                    __cont1 = false
                                    continue
                                end
                                if __brk3 then
                                    break
                                end
                                break
                            end
                            if __brk3 then
                                break
                            end
                            if __brk4 then
                                break
                            end
                            v48:alive(v194)
                            v193 = v45
                            v192 = v45.autoEquip
                            continue
                        end
                        if v193 then
                            v194 = math.max(2, v45.equipEvery)
                            local __cont6 = false
                            while true do
                                if v192 >= v194 then
                                    if v48:alive(v194) then
                                        v193 = v45
                                        v192 = v45.autoEquip
                                        __cont5 = true
                                        break
                                    end
                                    return
                                end
                                v193 = task.wait
                                while true do
                                    v192 = v192 + 0.5
                                    v193 = v48.alive(v190, v191, v195, ...)
                                    if v193 then
                                        v193 = v45.autoEquip
                                        math.max(2, v45.equipEvery)
                                        __cont6 = true
                                        break
                                    end
                                    if v193 then
                                        break
                                    end
                                    if not v193 then
                                        __brk3 = true
                                        break
                                    end
                                    v193 = task.wait
                                end
                                if __cont6 then
                                    break
                                end
                                if __brk3 then
                                    break
                                end
                                v194 = math.max(2, v45.equipEvery)
                                __cont6 = false
                                continue
                            end
                            if __cont5 then
                                __cont5 = false
                                continue
                            end
                            if __brk3 then
                                break
                            end
                            __brk4 = true
                            break
                        end
                        if v193 then
                            v193 = task.wait
                            while true do
                                v192 = v192 + 0.5
                                v193 = v48.alive(v190, v191, v195, ...)
                                if v193 then
                                    math.max(2, v45.equipEvery)
                                    v193 = task.wait
                                    continue
                                end
                                if v193 then
                                    math.max(2, v45.equipEvery)
                                    v193 = task.wait
                                    continue
                                end
                                if not v193 then
                                    __brk3 = true
                                    break
                                end
                                v193 = task.wait
                            end
                            if __cont5 then
                                __cont5 = false
                                continue
                            end
                            if __brk3 then
                                break
                            end
                            __brk4 = true
                            break
                        end
                        v193 = v48
                        __cont9 = true
                        break
                    end
                    if v48.alive(v190, v191, v195, ...) then
                        v193 = v45
                        v192 = v45.autoEquip
                        continue
                    end
                    return
                end
                if __brk4 then
                    break
                end
                if __cont9 then
                    __cont9 = false
                    continue
                end
                v193 = v48
                continue
            end
            __brk10 = true
            break
        end
        if __brk10 then
            break
        end
    end
end
local v56
local function processItems29(v189, v190, v191, v192, v193, v198, ...)
    local alive5
    local v194, v195, clock4, v196, v197
    if v48.alive() then
        alive5 = v45.autoUpgrade
        while true do
            if alive5 then
                v194 = v56()[1]
                if not v194 then
                    v45.upgradeStatus = "Nothing left to buy right now"
                    v48:alive()
                    alive5 = v45.autoUpgrade
                    continue
                end
                if v50(v193, v198, ...) - v45.reserve < v194.cost then
                    v197 = v194.label
                    v45.upgradeStatus = string.format("Saving up for: %s ($%s)", v197, v13(v194.cost))
                    v48:alive()
                    alive5 = v45.autoUpgrade
                    continue
                end
                v195 = v50()
                clock4 = os.clock(v190)
                v196 = false
                v197 = v50
                while true do
                    v197 = v197(v190, v191, v192, v193, v198, ...)
                    if v197 < v195 then
                        v196 = true
                    end
                    if not (v196 or 1.5 < os.clock() - clock4) then
                        v197 = v50
                        continue
                    end
                    break
                end
                if v196 then
                    if v194.kind == "level" then
                        v197 = v45
                        v197.levelUps = v197.levelUps + 1
                    else
                        v197 = v45
                        v197.bought = v197.bought + 1
                    end
                    v45.upgradeStatus = "Bought: " .. v194.label
                else
                    v45.upgradeStatus = "The game didn't accept: " .. v194.label
                end
                v48:alive(v195, clock4, v196)
                alive5 = v45.autoUpgrade
                continue
            end
            if v48.alive(v190, v191, v192, v193, v198, ...) then
                alive5 = v45.autoUpgrade
                continue
            end
            break
        end
    end
end
local playTower, v57
local function processItems30(...)
    local v189
    local function getValue8()
        v189 = playTower:InvokeServer(v45.tower) == true
    end
    local v190
    local function getValue9()
        v190 = completeTowerFloor:InvokeServer()
    end
    v189 = v48.alive()
    local __cont1 = false
    while v189 do
        v189 = not v45.autoTower
        while true do
            if v189 then
                v189 = not v45.autoTower
                continue
            end
            v189 = v45.autoPickTower
            if v189 then
                v45.tower = v57(v45.towerGoal)
            end
            v189 = v45.towerEquipBest
            v189 = false
            v190 = "Starting "
            v45.towerStatus = "Starting " .. tostring(v45.tower) .. "..."
            v45.towerStatus = "Clearing a stuck tower run..."
            v189 = v48.alive()
            __cont1 = true
            break
        end
        if __cont1 then
            __cont1 = false
            continue
        end
        return
    end
end
local function transformValue12(v189)
    if v189 == "Income" then
        return v45.potionIncome
    else
        return false
    end
end
local function transformValue13(v189)
    if not v45.potionOnlyUseful then
        return true
    elseif v189 == "Luck" then
        return v45.autoDice
    else
        return true
    end
end
local v58, v59, v60, v61
local function processItems31(v189, v190, v191, v202, ...)
    local alive6
    local v192, v193, v194, v195, v196, v197, v198, v199, clock5, v200, v201
    if v48.alive() then
        alive6 = v45.autoPotion
        while true do
            if alive6 then
                alive6 = nil
                v192 = 0
                v193, v194, v195 = ipairs(v58(v45.potionSaveRare))
                v196, v197 = v193(v194, v195)
                do
                    local shouldExit = false
                    if not (v196 == nil) then
                        v195 = v196
                        local __cont1 = false
                        while true do
                            if v197.runningName then
                                v192 = v192 + 1
                            end
                            if v60(v197.group) and v61(v197.group) then
                                v198 = v59(v197)
                                v199 = v32(v198.name)
                                clock5 = os.clock(v190)
                                while true do
                                    if v32(v198.name) < v199 then
                                        v200 = v32
                                        v201 = v198.name
                                    else
                                        v201 = os.clock(v191) - clock5
                                        continue
                                    end
                                    v200 = v200(v201)
                                    if v200 < v199 then
                                        v200 = v45
                                        v200.potionsUsed = v200.potionsUsed + 1
                                        alive6 = v198.name
                                    end
                                    v196, v197 = v193(v194, v195)
                                    if v196 == nil then
                                        v195 = v196
                                    else
                                        v195 = v196
                                        __cont1 = true
                                        break
                                    end
                                    shouldExit = true
                                    break
                                end
                                if shouldExit then
                                    break
                                end
                                if __cont1 then
                                    __cont1 = false
                                    continue
                                end
                                if v32(v198.name) < v199 then
                                    v200 = v45
                                    v200.potionsUsed = v200.potionsUsed + 1
                                    alive6 = v198.name
                                end
                                v196, v197 = v193(v194, v195)
                                if not (v196 == nil) then
                                    v195 = v196
                                    continue
                                end
                            else
                                v196, v197 = v193(v194, v195)
                                if v196 == nil then
                                    break
                                else
                                    v195 = v196
                                    continue
                                end
                            end
                            break
                        end
                        if shouldExit then
                            break
                        end
                    end
                end
                v45.potionStatus = "Drank " .. alive6
                v48:alive(v192)
                alive6 = v45.autoPotion
                continue
            end
            if v48.alive(v190, v191, v202, ...) then
                alive6 = v45.autoPotion
                continue
            end
            break
        end
    end
end
local v62
local function processItems32()
    local function checkCondition(v205, v206)
        local chance = v206.chance
        local chance2
        if v205.chance == chance then
            return tostring(v205.key) < tostring(v206.key)
        else
            chance2 = v206.chance
            return v205.chance < chance2
        end
    end
    local v189 = v3()
    local v190 = {}
    local v191 = {}
    local v192 = v191
    local v193 = v189
    if v189 then
        v193 = v189.Slots
    end
    if not v193 then
        v193 = {}
    end
    local v194, v195
    v194, v193, v195 = pairs(v193)
    local v196, v197
    v196, v197 = v194(v193, v195)
    local v198 = {}
    do
        local shouldExit = false
        if v196 == nil then
            v194 = pairs
            v193 = v189 and v189.TowerTeam
            if v193 then
                v196, v197 = next(v193, nil)
            else
                v194, v193, v195 = v194(v198)
                v196, v197 = v194(v193, v195)
            end
        else
            local v203 = {}
            while true do
                if v197.unitId then
                    v190[v197.unitId] = true
                end
                v197 = v193
                v195 = next
                if v195 == nil then
                    v194 = pairs
                    v193 = v189 and v189.TowerTeam
                    if v193 then
                        v194, v193, v195 = v194(v193)
                    else
                        v194, v193, v195 = v194(v203)
                    end
                    v196, v197 = v194(v193, v195)
                    if not (v196 == nil) then
                        v195 = v196
                        while true do
                            v190[v197] = true
                            v196, v197 = v194(v193, v195)
                            if v196 ~= nil then
                                v195 = v196
                                continue
                            end
                            break
                        end
                    end
                else
                    if v197.unitId then
                        v190[v197.unitId] = true
                    end
                    v196, v197 = v194(v193, v195)
                    if v196 == nil then
                        break
                    else
                        continue
                    end
                end
                shouldExit = true
                break
            end
            if shouldExit then
                break
            end
            v194 = pairs
            v193 = v189 and v189.TowerTeam
            if v193 then
                v194 = next
                v196, v197 = next(v193, nil)
            else
                v194, v193, v195 = v194(v198)
                v196, v197 = v194(v193, v195)
            end
            v195 = v196
            while true do
                v190[v197] = true
                v196, v197 = v194(v193, v195)
                if v196 ~= nil then
                    v195 = v196
                    continue
                end
                break
            end
        end
    end
    if v45.unitKey then
        v190[v45.unitKey] = true
    end
    v194, v193, v195 = pairs(v4())
    v196, v197 = v194(v193, v195)
    local attributes, v199, v200, v201, v202
    if not (v196 == nil) then
        v195 = v196
        local v204 = {}
        while true do
            if type(v197) == "table" and v197.attributes then
                attributes = v197.attributes
                v199 = v37[attributes.trait]
                v200 = v39[attributes.grade]
                v202 = tonumber(attributes.level)
                if v202 then
                    if v202 <= 1 then
                        v201 = v62.GetChance(v197)
                        type(v201)
                        v204.key = v196
                        v204.chance = v201
                        v192[#v192 + 1] = v204
                    end
                    v196, v197 = v194(v193, v195)
                    if not (v196 == nil) then
                        v195 = v196
                        continue
                    end
                elseif not attributes.locked and not v199 and not v200 then
                    v202 = type(v62.GetChance(v197)) == "number"
                    v196, v197 = v194(v193, v195)
                    if not (v196 == nil) then
                        v195 = v196
                        continue
                    end
                else
                    v196, v197 = v194(v193, v195)
                    if not (v196 == nil) then
                        v195 = v196
                        continue
                    end
                end
            else
                v196, v197 = v194(v193, v195)
                if v196 == nil then
                    break
                else
                    v195 = v196
                    continue
                end
            end
            return v192
        end
    end
    return v191
end
local v63, v64
local function runProtected6(v189, v190, v192, ...)
    local alive7
    local v191
    if v48.alive() then
        alive7 = v45.autoFuse
        while true do
            if alive7 then
                alive7, v191 = pcall(function(v192, v193, v194, v195, v205, ...)
                    local v196 = v64()
                    local v197, v198, v199, getCost, v200, v201, v202, v203, v204
                    if #v196 < 3 then
                        v45.fuseStatus = "Waiting for 3 spare eligible units"
                        return v196
                    else
                        v197 = v196[1]
                        v198 = v196[2]
                        v199 = v196[3]
                        v202 = v198.chance
                        v201 = v199.chance
                        v200 = v197.chance + v202 + v201
                        getCost = v63.GetCost(v200)
                        if v50(v195, v205, ...) - v45.reserve < getCost then
                            v200 = v45
                            v204 = v13(getCost)
                            v203 = v204 .. " (cash reserve kept)"
                            v201 = "Need $" .. v203
                            v200.fuseStatus = v201
                            return v196, v197, v198, v199, getCost, v200, v201, "Need $", v203, v204
                        else
                            v201 = v48.alive()
                            v200 = not v201
                            if v200 then
                                return v196, v197, v198, v199, getCost, v200, v201
                            else
                                v200 = v45
                                v201 = "Fusing 3 weakest spare units..."
                            end
                            v200.fuseStatus = v201
                            v200 = os.clock(v193)
                            while true do
                                if not v48.alive(v194, v195, v205, ...) then
                                    v202 = v48.alive
                                else
                                    v5(v197.key)
                                    v202 = os.clock(v194) - v200
                                    continue
                                end
                                v202 = v202()
                                v201 = not v202
                                if v201 then
                                    return v196, v197, v198, v199, getCost, v200, v201, v202
                                end
                                v5(v197.key)
                            end
                        end
                    end
                end)
            end
            math.max(1, v63.RequestDebounce + 0.1)
            if v48.alive(v190, v192, ...) then
                alive7 = v45.autoFuse
                continue
            end
            break
        end
    end
end
local v65
local function runProtected7(v189, v190, v191, v192, v199, ...)
    local v193 = nil
    local v194
    local remember = v45.remember
    local __cont1 = false
    local v195, v196, v197, v198
    while true do
        if v48.alive() then
            while true do
                if not v43 then
                    v48.alive(v190, v191, v192, v199, ...)
                    break
                end
                if v45.remember or remember then
                    v194, v195 = pcall(v46)
                    v196 = v194 and v195 ~= v193
                    if v196 then
                        v65(v192, v199, ...)
                        v193 = v195
                        v196 = v45
                        v198 = os.date("%H:%M:%S")
                        v197 = "Saved at " .. v198
                        v196.savedText = v197
                        remember = v45.remember
                        v48:alive(v196, v197, "Saved at ", v198)
                        continue
                    end
                    if v196 then
                        v193 = v195
                        v196 = v45
                        v198 = os.date("%H:%M:%S")
                        v197 = "Saved at " .. v198
                        v196.savedText = v197
                        remember = v45.remember
                        v48:alive(v196, v197, "Saved at ", v198)
                        continue
                    end
                    remember = v45.remember
                    __cont1 = true
                    break
                end
                remember = v45.remember
                if not v48.alive(v190, v191, v192, v199, ...) then
                    break
                end
            end
            if __cont1 then
                __cont1 = false
                continue
            end
            return
        end
        break
    end
end
local function performTask4()
end
local function performTask5()
end
local function performTask6()
end
local v66, v67
local function computeValue5(v189, v190, v191)
    local function transformValue(v193)
        if not v67 then
            return
        end
    end
    local function getValue7()
        return v190()
    end
    local v192 = v66
    v192[#v192 + 1] = getValue7
    return v189
end
local v68
local function computeValue6(v189, v190, v191, v192, v193)
    local function getValue6()
        return v45[v192]
    end
    local function updateState4(v194)
        v45[v192] = v194
    end
    return v68(v189:AddToggle(v190, {Text = v191, Default = v45[v192], Tooltip = v193}), getValue6, updateState4)
end
local function computeValue7(v189, v190, v191)
    return v189:AddButton({Text = v190, Func = v191})
end
local v69
local function updateState5(v189, v190)
    local v191
    local function getValue5()
        local v193 = v190()
        if v193 ~= v191 then
            v191 = v193
        end
        return v193
    end
    v189:AddLabel("Loading...", true)
    v191 = nil
    local v192 = v69
    v192[#v192 + 1] = getValue5
end
local function computeValue8(v189, v190, v191, v192)
    local function getValue4()
        return v45[v190]
    end
    local function updateState3(v193)
        if v193 then
            v45[v190] = v193
        end
    end
    return v68(v189:AddDropdown(v190, {Text = v191, Values = v192, Default = v45[v190]}), getValue4, updateState3)
end
local function computeValue9(v189, v190, v191, v192, v193, v194)
    local function getValue3()
        return v45[v190]
    end
    local function updateState2(v195)
        v45[v190] = v195
    end
    return v68(v189:AddSlider(v190, {Text = v191, Default = v45[v190], Min = v192, Max = v193, Rounding = v194}), getValue3, updateState2)
end
local function computeValue10(v189, v190, v191, v192)
    local v193, v194
    local function getValue()
        local v196, v197
        v196, v197 = v192()
        v193 = v197
        local concat = table.concat(v196, "\n")
        if concat ~= v194 then
            v194 = concat
        end
        return v196, v197, concat
    end
    local addDropdown
    local function getValue2()
        return v193[addDropdown.Value]
    end
    v194 = v190
    v193 = v189
    addDropdown = v189:AddDropdown(v190, {Text = v191, Values = {}, AllowNull = true, Searchable = true})
    v193 = {}
    v194 = nil
    local v195 = v69
    v195[#v195 + 1] = getValue
    return getValue2, addDropdown
end
local function computeValue11(v189, v190, v191, v192, v193, v194, v195, v196, v200, ...)
    local v197, v198, v199
    v197, v198, v199 = v19()
    return string.format("Cash  $%s     Income  $%s/s\nUncollected  $%s     Gems  %d\nTrait Rerolls  %d", v13(v50(v196, v200, ...)), v13(v198), v13(v199), v32("Gems"), v32("Trait Reroll"))
end
local function getValue17()
    local v189 = {}
    if v45.autoUpgrade or v45.autoCollect or v45.autoEquip then
        v189[#v189 + 1] = "Money"
    end
    if v45.autoTower then
        v189[#v189 + 1] = "Towers"
    end
    if v45.autoDice then
        v189[#v189 + 1] = "Dice"
    end
    if v45.autoPotion then
        v189[#v189 + 1] = "Potions"
    end
    if v45.autoFuse then
        v189[#v189 + 1] = "Fuse"
    end
    if 0 < #v189 then
        return table.concat(v189, "  •  ")
    else
        return "Nothing running"
    end
end
local function FuncHandler()
end
local function getValue18()
    return tostring(v45.reserve)
end
local function transformValue14(v189)
    local v190 = tonumber(v189)
    local v191 = v190
    if v190 then
        v191 = true
    end
    if v191 then
        v191 = v190 < math.huge
    end
    if v191 then
        v45.reserve = math.max(0, v190)
    end
end
local function performTask7()
end
local function performTask8()
end
local function getValue19()
    local v190 = v56()[1]
end
local v70
local function processItems33()
    local v189, v190, v191
    v189, v190, v191 = ipairs(v56())
    local v192, v193
    v192, v193 = v189(v190, v191)
    local v194 = {}
    local label
    if not (v192 == nil) then
        v191 = v192
        while true do
            if 8 >= v192 then
                label = v193.label
                v194[#v194 + 1] = string.format("%d. %s\n$%s | +%s/s | payback %s", v192, label, v13(v193.cost), v13(v193.gain), v70(v193.payback))
                v192, v193 = v189(v190, v191)
                if v192 == nil then
                    break
                else
                    v191 = v192
                    continue
                end
            end
            break
        end
    end
    if 0 < #v194 then
        return table.concat(v194, "\n\n")
    else
        return "Nothing to buy."
    end
end
local function processItems34()
    local v189, v190, v191
    v189, v190, v191 = ipairs(v19())
    local v192
    x8, v192 = v189(v190, v191)
    local v193 = {}
    local v194 = {}
    local format, slot2, name3
    if not (x8 == nil) then
        v191 = x8
        while true do
            name3 = v192.name
            format = string.format("Slot %d: %s", v192.slot, name3)
            slot2 = v192.slot
            v193[#v193 + 1] = format
            v194[format] = slot2
            x8, v192 = v189(v190, v191)
            if x8 ~= nil then
                v191 = x8
                continue
            end
            break
        end
    end
    return v193, v194
end
local v71
local function processItems35(v189, v190, v191, v192, v193, v198, ...)
    local v194, v195, v196
    v194, v195, v196 = ipairs(v19())
    local v197
    x9, v197 = v194(v195, v196)
    local level
    if not (x9 == nil) then
        v196 = x9
        while true do
            if v197.slot ~= v71(v193, v198, ...) then
                x9, v197 = v194(v195, v196)
                if x9 ~= nil then
                    v196 = x9
                    continue
                end
                break
            end
            level = v197.level
            return string.format("Level %d | +%s/s\nNext level: $%s | Banked: $%s", level, v13(v197.income), v13(v197.cost), v13(v197.balance))
        end
    end
    return "Choose a slot to view income and level."
end
local function getValue20()
    return v71()
end
local function getValue21()
    return v71()
end
local function processItems36()
    local v189, v190, v191
    v189, v190, v191 = ipairs(v21())
    local v192, v193
    v192, v193 = v189(v190, v191)
    local v194 = {}
    local v195 = {}
    local v196, name4
    if not (v192 == nil) then
        v191 = v192
        while true do
            v196 = v193.name .. " ($" .. v13(v193.price) .. ")"
            name4 = v193.name
            v194[#v194 + 1] = v196
            v195[v196] = name4
            v192, v193 = v189(v190, v191)
            if v192 ~= nil then
                v191 = v192
                continue
            end
            break
        end
    end
    return v194, v195
end
local v72
local function getValue22()
    return v72()
end
local function updateState6()
    local function updateState()
        v45.towerStatus = "Stopped"
    end
    v45.autoTower = false
    v45.towerStatus = "Stopping..."
end
local function getValue23()
    local towerRuns = v45.towerRuns
    local towerBest = v45.towerBest
    return string.format("%s\n%d runs | Highest floor %d", v45.towerStatus, towerRuns, towerBest)
end
local v73
local function processItems37(v189, v190, v191, v192, v193, v194, v203, ...)
    local v195 = {}
    v195[1] = "Expected " .. v73(v45.towerGoal) .. " per hour:"
    local v196 = v195
    v195 = v57(v45.towerGoal)
    local v197, v198, v199
    v197, v198, v199 = ipairs(v30(v194, v203, ...))
    local v200, v201
    v200, v201 = v197(v198, v199)
    local name5, v202, floors, towerGoal
    if not (v200 == nil) then
        v199 = v200
        while true do
            name5 = v201.name
            v202 = v201.name == v195 and " (best)" or ""
            floors = v201.floors
            towerGoal = v45.towerGoal
            v196[#v196 + 1] = string.format("%s%s\nFloor %d | %.1f/hr", name5, v202, floors, v29(v201.perHour, towerGoal))
            v200, v201 = v197(v198, v199)
            if v200 ~= nil then
                v199 = v200
                continue
            end
            break
        end
    end
    return table.concat(v196, "\n\n")
end
local function processItems38()
    local v189, v190, v191
    v189, v190, v191 = ipairs(v26())
    local v192, v193
    v192, v193 = v189(v190, v191)
    local v194 = {}
    local name6
    if not (v192 == nil) then
        v191 = v192
        while true do
            name6 = v193.name
            v194[#v194 + 1] = string.format("%d. %s\n%s damage | %s health", v192, name6, v13(v193.damage), v13(v193.health))
            v192, v193 = v189(v190, v191)
            if v192 ~= nil then
                v191 = v192
                continue
            end
            break
        end
    end
    if 0 < #v194 then
        return table.concat(v194, "\n")
    else
        return "No tower team equipped."
    end
end
local function processItems39()
    local v189 = next
    local towerDrops = v45.towerDrops
    local v190, v191
    v190, v191 = next(towerDrops, nil)
    local v192 = {}
    local v193
    if not (v190 == nil) then
        v192[#v192 + 1] = v190 .. " x" .. v191
        v190, v191 = v189(towerDrops, v190)
        v193 = v190
        while true do
            v192[#v192 + 1] = v190 .. " x" .. v191
            v190, v191 = v189(towerDrops, v193)
            if v190 ~= nil then
                v193 = v190
                continue
            end
            break
        end
    end
    if 0 < #v192 then
        return table.concat(v192, "\n")
    else
        return "Nothing yet."
    end
end
local v74
local function updateState7(v189)
    if not v67 and v74[v189] then
        v45.unitKey = v74[v189]
    end
end
local v75, v76, v77
local function processItems40()
    local v189 = nil
    v74 = {}
    local concat2, v190, v191
    concat2, v190, v191 = ipairs(v75())
    local v192, v193
    v192, v193 = concat2(v190, v191)
    local v194 = {}
    local v195, unitKey, key
    if not (v192 == nil) then
        v191 = v192
        while true do
            v195 = v193.name .. " [" .. tostring(v193.key) .. "]"
            key = v193.key
            v194[#v194 + 1] = v195
            v74[v195] = key
            unitKey = v45.unitKey
            if v193.key == unitKey then
                v189 = v195
            end
            v192, v193 = concat2(v190, v191)
            if v192 ~= nil then
                v191 = v192
                continue
            end
            break
        end
    end
    concat2 = table.concat(v194, "\n")
    if concat2 ~= v76 then
        v76 = concat2
        if v189 ~= v77.Value then
            return v194, v189, concat2
        end
        return v194, v189, concat2
    elseif v189 ~= v77.Value then
        return v194, v189, concat2
    else
        return v194, v189, concat2
    end
end
local function getValue24()
    local v189 = v5(v45.unitKey)
    local v190
    if v189 then
        v190 = v189.name .. "\nTrait: " .. tostring(v47(v45.unitKey, "trait")) .. " | Grade: " .. tostring(v47(v45.unitKey, "grade"))
    else
        v190 = "No unit chosen."
    end
    return v190 .. string.format("\n%d Trait Rerolls | %d Gems\n%s", v32("Trait Reroll"), v32("Gems"), v45.status)
end
local function computeValue12(v189, v190, v191, v194, ...)
    local v192 = v40()
    local v193 = v41(v191, v194, ...)
    v45.keepTrait = v192
    v45.keepGrade = v193
end
local function updateState8()
    v45.keepTrait = {}
    v45.keepGrade = {}
end
local function getValue25()
    local v189 = v7()
    local get = v6.Get(v189)
    local v190 = get
    if get then
        v190 = get.luck
    end
    if not v190 then
        v190 = 1
    end
    return "Using: " .. v189 .. " | " .. v53(v190) .. " luck\n" .. v45.diceStatus
end
local v78, v79
local function checkCondition13()
    return v45[v78[4]][v79] == true
end
local v80
local function getValue26()
    local value = v80.Value
    local v189 = value
    local v190
    if value then
        v189 = v6.Get(value)
        if v189 then
            v190 = v53(v189.luck or 1)
        else
            return "Choose a dice."
        end
    elseif v189 then
        v190 = v53(v189.luck or 1)
    else
        return "Choose a dice."
    end
    if v9(value) then
        return v190 .. " luck | Owned" or "Choose a dice."
    else
        return v190 .. " luck | " .. "$" .. v13(v189.price) or "Choose a dice."
    end
end
local function updateState9(v189)
    v45[v78[4]][v79] = v189
end
local function performTask9()
end
local function performTask10()
end
local function getValue27()
    return (v45.autoFuse and "" or "Off | ") .. v45.fuseStatus
end
local function getValue28()
    return v45.potionStatus
end
local function processItems41()
    local v189, v190, v191
    v189, v190, v191 = ipairs(v58(v45.potionSaveRare))
    local v192, v193
    v192, v193 = v189(v190, v191)
    local v194 = {}
    local runningName, runningStrength
    if not (v192 == nil) then
        v191 = v192
        while true do
            if v193.runningName then
                runningName = v193.runningName
                runningStrength = v193.runningStrength
                v194[#v194 + 1] = string.format("%s | x%g | %s", runningName, runningStrength, v70(v193.banked))
                v192, v193 = v189(v190, v191)
                if not (v192 == nil) then
                    v191 = v192
                    continue
                end
            else
                v192, v193 = v189(v190, v191)
                if v192 == nil then
                    break
                else
                    v191 = v192
                    continue
                end
            end
            break
        end
    end
    v190 = string.format
    v192 = v24.GetBuff("Money Multiplier") or 1
    v193 = v24.GetBuff("Luck") or 1
    local getBuff2 = v24.GetBuff("Damage Multiplier")
    if getBuff2 then
        v190 = v190("\nTotal: money x%.2f | luck x%.2f | damage x%.2f", v192, v193, getBuff2)
    else
        v190 = v190("\nTotal: money x%.2f | luck x%.2f | damage x%.2f", v192, v193, 1)
    end
    v194[#v194 + 1] = v190
    return table.concat(v194, "\n")
end
local function processItems42()
    local v189, v190, v191
    v189, v190, v191 = ipairs(v58(false))
    local v192, v193
    v192, v193 = v189(v190, v191)
    local v194 = {}
    local v195 = {}
    local v196, v197, v198, v199, name7, name8
    if not (v192 == nil) then
        v191 = v192
        while true do
            v196, v197, v198 = ipairs(v193.owned)
            x10, v199 = v196(v197, v198)
            if not (x10 == nil) then
                v198 = x10
                while true do
                    name7 = v199.name
                    name8 = v199.name
                    v194[#v194 + 1] = v199.name
                    v195[name7] = name8
                    x10, v199 = v196(v197, v198)
                    if x10 ~= nil then
                        v198 = x10
                        continue
                    end
                    break
                end
            end
            v192, v193 = v189(v190, v191)
            if v192 ~= nil then
                v191 = v192
                continue
            end
            break
        end
    end
    return v194, v195
end
local v81
local function getValue29()
    local v189 = v81()
    if v189 then
        return v189 .. " x" .. v32(v189)
    else
        return "Choose a potion to drink."
    end
end
local function getValue30()
    local v189 = v81()
    if v189 then
        v45.potionStatus = "Drank " .. v189
    end
end
local function getValue31()
end
local v82
local function processItems43()
    local v189 = v82()
    local v190, v191, v192
    v190, v191, v192 = pairs(v45)
    local v193 = v190(v191, v192)
    if not (v193 == nil) then
        v192 = v193
        while true do
            v45[v193] = nil
            v193 = v190(v191, v192)
            if v193 ~= nil then
                v192 = v193
                continue
            end
            break
        end
    end
    v190 = next
    v191 = v189
    local v194
    v193, v194 = next(v189, nil)
    if not (v193 == nil) then
        v45[v193] = v194
        v193, v194 = v190(v191, v193)
        v192 = v193
        while true do
            v45[v193] = v194
            v193, v194 = v190(v191, v192)
            if v193 ~= nil then
                v192 = v193
                continue
            end
            break
        end
    end
    v45.tab = "Settings"
end
local function getValue32()
    local bought = v45.bought
    local collected = v45.collected
    local towerRuns2 = v45.towerRuns
    local traitRolls = v45.traitRolls
    local gradeRolls = v45.gradeRolls
    local diceRolls = v45.diceRolls
    local diceBought = v45.diceBought
    local potionsUsed = v45.potionsUsed
    return string.format("Level-ups: %d\nUpgrades: %d\nCollections: %d\nTower runs: %d\nTrait rerolls: %d\nGrade rerolls: %d\nDice rolled: %d\nDice bought: %d\nPotions drunk: %d", v45.levelUps, bought, collected, towerRuns2, traitRolls, gradeRolls, diceRolls, diceBought, potionsUsed)
end
local v83, v84, v85
local function processItems44()
    local v189, v190, v191
    v189, v190, v191 = ipairs(v66)
    local v192, v193
    v192, v193 = v189(v190, v191)
    if not (v192 == nil) then
        v191 = v192
        while true do
            v192, v193 = v189(v190, v191)
            if v192 ~= nil then
                v191 = v192
                continue
            end
            break
        end
    end
    v189, v190, v191 = ipairs(v69)
    v192, v193 = v189(v190, v191)
    if not (v192 == nil) then
        v191 = v192
        while true do
            v192, v193 = v189(v190, v191)
            if v192 ~= nil then
                v191 = v192
                continue
            end
            break
        end
    end
    v67 = false
    v192 = v45.menuKey
    v83.ToggleKeybind = Enum.KeyCode[v192]
    v189 = ({Small = 90, Normal = 100, Large = 115})[v45.textSize]
    if v189 ~= v85 then
        v85 = v189
    end
    v190, v191, v192 = pairs(v84)
    local v194
    v193, v194 = v190(v191, v192)
    if not (v193 == nil) then
        v192 = v193
        while true do
            if v83.ActiveTab == v194 then
                v45.tab = v193
            else
                v193, v194 = v190(v191, v192)
                if v193 == nil then
                    break
                else
                    v192 = v193
                    continue
                end
            end
            return v189, v190, v191, v192, v193, v194
        end
    end
    return v189, v190, v191, v193, v193, v194
end
local v86
local function runProtected8(v189, v190, v191, v195, ...)
    local v192 = v48
    local __cont1 = false
    local v193, v194
    while true do
        v193 = v192.alive()
        if v193 then
            v192 = v83.Unloaded
            v193 = not v192
            local __cont2 = false
            while true do
                if v193 then
                    v192 = task
                    v193 = task.wait
                    while true do
                        v192 = v48.alive(v191, v195, ...)
                        v193 = not v192
                        if v193 then
                            return v193, v192
                        end
                        v192 = v83
                        v193 = v83.Unloaded
                        if v193 then
                            break
                        else
                            v193, v192 = pcall(v86)
                            v67 = false
                            v1.__ADAR_UI_ERROR = tostring(v192)
                            v194 = "Jay Hub" .. " UI refresh: " .. tostring(v192)
                            return v48:alive()
                        end
                    end
                    if __cont1 then
                        break
                    end
                    if __cont2 then
                        __cont2 = false
                        continue
                    end
                end
                break
            end
            if __cont1 then
                __cont1 = false
                continue
            end
            break
        end
        if v193 then
            v192 = task
            while true do
                v192 = v48.alive(v191, v195, ...)
                v193 = not v192
                if v193 then
                    return v193, v192
                end
                v192 = v83
                if v192.Unloaded then
                    break
                else
                    v193, v192 = pcall(v86)
                    v67 = false
                    if v193 then
                        v192 = v48
                        __cont1 = true
                        break
                    end
                    v1.__ADAR_UI_ERROR = tostring(v192)
                    v194 = "Jay Hub" .. " UI refresh: " .. tostring(v192)
                    return v48:alive()
                end
            end
            if __cont1 then
                __cont1 = false
                continue
            end
            break
        end
        return v193
    end
end
local function updateState10()
    v1.__ADAR_UI_READY = false
end
local Players, ReplicatedStorage, CoreGui, UserInputService, StarterGui, fuse, roll, roll2, rollDice, levelUpSlot, collectBalance, equipBest, buyUpgrade, cancelTower, equipBestTowerTeam, use, buyDice, equipDice, v87, v88, v89, v90, v91, v92, v93, v94, v95, v96, v97, v98, v99, v100, v101, v102, v103, v104, v105, v106, v107, v108, v109, v110, player, addLeftGroupbox, v111, v112, v113, v114, v115, addRightGroupbox, v116, v117, v118, v119, v120, v121, v122, v123
local v124, v125, v126, v127, v128, v129, v130, v131, v132, v133, v134, v135, v136, v137, v138, v139, v140, v141, v142, v143, v144, v145, v146, v147, v148, v149 = ...
do
    local v150 = {}
    local v151 = {}
    local v152 = {}
    local v153 = {}
    local v154 = {}
    local v155 = {}
    local v156 = {}
    local v157 = {}
    local v158 = {}
    local v159 = {}
    local v160 = {}
    local v161 = {}
    local v162 = {}
    local v163 = {}
    local v164 = {}
    local v165 = {}
    local v166 = {}
    local v167 = {}
    local v168 = {}
    local v169 = {}
    local v170 = {}
    local v171 = {}
    local v172 = {}
    local v173 = {}
    local v174 = {}
    local v175 = {}
    local v176 = {}
    local v177 = {}
    local v178 = {}
    local v179 = {}
    local v180 = {}
    local v181 = {}
    local v182 = {}
    local v183 = {}
    local v184 = {}
    local v185 = {}
    local v186 = {}
    local v187 = {}
    local v188 = {}
    while true do
        while true do
            Players = game:GetService("Players")
            v42 = "ReplicatedStorage"
            ReplicatedStorage = game:GetService("ReplicatedStorage")
            v42 = game
            CoreGui = game:GetService("CoreGui")
            v42 = game:GetService("HttpService")
            v1 = "UserInputService"
            UserInputService = game:GetService("UserInputService")
            v48 = "StarterGui"
            v1 = game
            StarterGui = game:GetService("StarterGui")
            v2 = getgenv
            v48 = typeof(getgenv)
            v2 = "function"
            v1 = v48 == "function"
            if v1 then
                v1 = getgenv(v48)
                v48 = nil
                v37 = STATE
                v2 = typeof(STATE)
                v37 = "table"
                if v2 == "table" then
                    v48 = STATE
                    v2 = require
                    v14 = ReplicatedStorage.Framework
                else
                    v37 = v1.__ADAR_CLEANUP
                    v2 = require(v37)
                    v1.__ADAR_CLEANUP = v150
                    v37 = v1.__ADAR_RUN or 0
                    v1.__ADAR_RUN = v37 + 1
                    v2 = v1.__ADAR_RUN
                    v48 = v151
                    v151.alive = aliveHandler
                    v151.onCleanup = onCleanupHandler
                    v151.connect = connectHandler
                    v2 = require
                    v14 = ReplicatedStorage.Framework
                    v39 = v14.Features
                    v37 = v39.Data
                    v103 = game
                    v84 = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"
                    v104 = v103
                    v54 = next
                    v49 = v49
                    v100 = nil
                    goto __x45
                end
            else
                v1 = _G
                v48 = nil
                v37 = STATE
                v2 = typeof(v37)
                v37 = "table"
                v54 = pairs
                v55 = v82
            end
            v39 = v14.Features
            v37 = v39.Data.DataController
            v2 = v2(v37)
            v15 = ReplicatedStorage.Framework
            v14 = v15.Features
            v39 = v14.Traits.Traits
            v37 = require(v39)
            v16 = ReplicatedStorage.Framework
            v15 = v16.Features
            v14 = v15.Grades.Grades
            v39 = require(v14)
            v18 = ReplicatedStorage.Framework
            v16 = v18.Features
            v15 = v16.Inventory.EntryRegistry
            v14 = require(v15)
            v24 = ReplicatedStorage.Framework
            v23 = v24.Features
            v25 = v23.Inventory
            v18 = v25.Kinds
            v16 = v18.Unit.UnitUtil
            v15 = require(v16)
            v23 = ReplicatedStorage.Framework
            v25 = v23.Features
            v18 = v25.Upgrades.Upgrades
            v16 = require(v18)
            v24 = ReplicatedStorage.Framework
            v23 = v24.Features
            v25 = v23.Upgrades.TreeStructure
            v18 = require(v25)
            v31 = ReplicatedStorage.Framework
            v24 = v31.Features
            v23 = v24.Towers.Towers
            v25 = require(v23)
            v6 = ReplicatedStorage.Framework
            v31 = v6.Features
            v24 = v31.Towers.TowerRefs
            v23 = require(v24)
            v62 = ReplicatedStorage.Framework
            v6 = v62.Features
            v31 = v6.Buffs.BuffController
            v24 = require(v31)
            v63 = ReplicatedStorage.Framework.Features.Inventory
            v62 = v63.Kinds
            v6 = v62.Boost.BoostConfig
            v31 = require(v6)
            v63 = ReplicatedStorage.Framework.Features
            v62 = v63.Rolling.Dice
            v6 = require(v62)
            v63 = ReplicatedStorage.Framework.Features.Fusing.FusingUtil
            v62 = require(v63)
            v63 = require(ReplicatedStorage.Framework.Features.Fusing.FusingConfig)
            fuse = ReplicatedStorage.Network.FusingService.RE.Fuse
            roll = ReplicatedStorage.Network.TraitService.RE.Roll
            roll2 = ReplicatedStorage.Network.GradeService.RE.Roll
            rollDice = ReplicatedStorage.Network.RollService.RF.RollDice
            levelUpSlot = ReplicatedStorage.Network.PlotService.RE.LevelUpSlot
            collectBalance = ReplicatedStorage.Network.PlotService.RE.CollectBalance
            equipBest = ReplicatedStorage.Network.PlotService.RE.EquipBest
            buyUpgrade = ReplicatedStorage.Network.RE.BuyUpgrade
            playTower = ReplicatedStorage.Network.Towers.RF.PlayTower
            completeTowerFloor = ReplicatedStorage.Network.Towers.RF.CompleteTowerFloor
            cancelTower = ReplicatedStorage.Network.Towers.RF.CancelTower
            equipBestTowerTeam = ReplicatedStorage.Network.Towers.RE.EquipBestTowerTeam
            use = ReplicatedStorage.Network.BoostService.RE.Use
            buyDice = ReplicatedStorage.Network.DiceShopService.RE.BuyDice
            equipDice = ReplicatedStorage.Network.DiceShopService.RE.EquipDice
            v3 = getValue12
            v4 = getValue13
            v5 = transformValue2
            v32 = transformValue3
            v47 = computeValue2
            v50 = getValue14
            v8 = v152
            v7 = next
            v7 = v7
            v9 = v6.GetAll(v149)
            v10 = nil
            v51, v52 = next(v9, nil)
            if not (v51 == nil) then
                v10 = v51
                v75 = #v8 + 1
                v38 = v153
                v153.name = v51
                v38.luck = v52.luck or 0
                v38.price = v52.price
                v8[v75] = v38
                v51, v52 = v7(v9, v10)
                v10 = v51
                while true do
                    v75 = #v8 + 1
                    v38 = v154
                    v154.name = v51
                    v38.luck = v52.luck or 0
                    v38.price = v52.price
                    v8[v75] = v38
                    v51, v52 = v7(v9, v10)
                    if v51 ~= nil then
                        v10 = v51
                        continue
                    end
                    break
                end
            end
            v7 = table.sort
            v7 = computeValue3
            v9 = transformValue4
            v10 = processItems
            v51 = processItems2
            v52 = processItems3
            v75 = processItems4
            v87 = processItems5
            v38 = processItems6
            v88 = processItems5(v37)
            v11 = v39
            v89 = v87(v39)
            v11 = v155
            v90 = computeValue4
            v156[1] = ""
            v156[2] = "K"
            v156[3] = "M"
            v156[4] = "B"
            v156[5] = "T"
            v156[6] = "Qa"
            v156[7] = "Qi"
            v156[8] = "Sx"
            v156[9] = "Sp"
            v156[10] = "Oc"
            v156[11] = "No"
            v156[12] = "Dc"
            v12 = v156
            v13 = processItems7
            v70 = processItems8
            v91 = transformValue5
            v53 = transformValue6
            v19 = runProtected
            v17 = getValue15
            v20 = processItems9
            v21 = runProtected2
            v56 = processItems10
            v157[1] = "Trait Reroll"
            v157[2] = "Gems"
            v157[3] = "Boosts"
            v92 = v157
            v158["Trait Reroll"] = "Trait Rerolls"
            v158.Gems = "Gems"
            v158.Boosts = "Boost items"
            v22 = v158
            v159["Trait Reroll"] = "Trait Rerolls let you reroll a unit's trait in the Rolling tab."
            v159.Gems = "Gems let you reroll a unit's grade in the Rolling tab."
            v159.Boosts = "Boost items are the Luck, Damage and Income potions."
            v93 = v159
            v73 = transformValue7
            v26 = processItems11
            v27 = processItems12
            v29 = processItems13
            v160.at = 0
            v160.rows = v161
            v28 = v160
            v30 = processItems14
            v57 = processItems15
            v94 = checkCondition12
            v95 = processItems16
            v162.Mythical = true
            v162.Divine = true
            v162.Exotic = true
            v162.Celestial = true
            v162.Secret = true
            v33 = v162
            v34 = transformValue8
            v35 = processItems17
            v36 = transformValue9
            v58 = processItems18
            v59 = transformValue10
            v163.Small = 13
            v163.Normal = 14
            v163.Large = 16
            v96 = v163
            v164[1] = "RightShift"
            v164[2] = "RightControl"
            v164[3] = "Insert"
            v164[4] = "F4"
            v97 = v164
            v165[1] = "Home"
            v165[2] = "Money"
            v165[3] = "Towers"
            v165[4] = "Rolling"
            v165[5] = "Potions"
            v165[6] = "Settings"
            v98 = v165
            v40 = processItems19
            v41 = processItems20
            v82 = getValue16
            v43 = v166
            v83 = "keepTrait"
            v102 = "keepGrade"
            v103 = "unitKey"
            v166[1] = "autoUpgrade"
            v166[2] = "autoCollect"
            v166[3] = "autoEquip"
            v166[4] = "autoTower"
            v166[5] = "autoPickTower"
            v166[6] = "towerEquipBest"
            v166[7] = "autoDice"
            v166[8] = "tower"
            v166[9] = "towerGoal"
            v166[10] = "reserve"
            v166[11] = "equipEvery"
            v166[12] = "delay"
            v166[13] = "keepTrait"
            v166[14] = "keepGrade"
            v166[15] = "unitKey"
            v166[16] = "tab"
            v46 = "remember"
            v65 = "autoPotion"
            v54 = "potionIncome"
            v49 = "potionLuck"
            v55 = "potionOnlyUseful"
            v60 = "autoBuyDice"
            v61 = "autoEquipDice"
            v64 = "autoFuse"
            v43[17] = "menuKey"
            v43[18] = "textSize"
            v43[19] = "remember"
            v43[20] = "autoPotion"
            v43[21] = "potionIncome"
            v43[22] = "potionLuck"
            v43[23] = "potionDamage"
            v43[24] = "potionOnlyUseful"
            v43[25] = "potionSaveRare"
            v43[26] = "autoBuyDice"
            v43[27] = "autoEquipDice"
            v43[28] = "autoFuse"
            v44 = v43
            v45 = typeof(writefile)
            v43 = v45 == "function"
            if v43 then
                v43 = typeof(readfile) == "function"
                v43 = typeof(isfile) == "function"
            end
            v99 = runProtected3
            v46 = processItems21
            v65 = runProtected4
            v45 = v1.__ADAR_CFG
            v49 = "number"
            v100 = "table"
            v45 = v82("number")
            v54 = v99()
            if v54 then
                v49 = v54.remember
                if v49 == false then
                    v49 = false
                    v45.remember = false
                    v1.__ADAR_CFG = v45
                    v54 = pairs
                    v55 = v82()
                else
                    v49, v100, v55 = ipairs(v44)
                    v49 = v49
                    v55 = v55
                    v101, v60 = v49(v100, v55)
                    if v101 == nil then
                        v55 = v101
                    else
                        v55 = v101
                        while true do
                            v61 = v54[v60]
                            v83 = nil
                            v64 = v61 ~= nil
                            if v64 then
                                v83 = v45[v60]
                                v102 = nil
                                v64 = v83 == nil
                                v45[v60] = v61
                                v101, v60 = v49(v100, v55)
                                if v101 == nil then
                                    v55 = v101
                                else
                                    v55 = v101
                                    continue
                                end
                            else
                                v54 = not v49
                                if v54 then
                                    v54 = "Normal"
                                    v45.textSize = "Normal"
                                end
                                goto __x45
                            end
                            break
                        end
                    end
                    v1.__ADAR_CFG = v45
                    v54 = pairs
                    v55 = v82(v101, v60)
                end
                v54 = next
                v49 = v55
                v100 = nil
            end
            v54 = v54
            v49 = v49
            v55, v101 = next(v49, v100)
            do
                local shouldExit = false
                if v55 == nil then
                    v49 = v96[v45.textSize]
                    v54 = "Normal"
                    v45.textSize = "Normal"
                    v49 = table.find
                    v100 = v98
                    v55 = v45.tab
                else
                    v60 = v45[v55]
                    v61 = nil
                    if v60 == nil then
                        v45[v55] = v101
                    end
                    v55, v101 = v54(v49, v55)
                    while true do
                        v60 = v45[v55]
                        v61 = nil
                        if v60 == nil then
                            v45[v55] = v101
                        end
                        v55 = next
                        v101 = v49
                        v100 = next
                        if v100 == nil then
                            v49 = v96[v45.textSize]
                            v54 = not v49
                            if v54 then
                                v54 = "Normal"
                                v45.textSize = "Normal"
                            end
                            v49 = table.find
                            v55 = v45.tab
                        else
                            v60 = v45[v55]
                            v61 = nil
                            if v60 == nil then
                                v45[v55] = v101
                            end
                            v55, v101 = v54(v49, v100)
                            if v55 == nil then
                                break
                            else
                                continue
                            end
                        end
                        shouldExit = true
                        break
                    end
                    if shouldExit then
                        break
                    end
                    v100 = v45.textSize
                end
            end
            v49 = v49(v100, v55)
            v54 = not v49
            if v54 then
                v54 = "Home"
                v45.tab = "Home"
            end
            v55 = v45.menuKey
            v49 = table.find(v97, v55)
            v54 = not v49
            if v54 then
                v54 = "RightShift"
                v45.menuKey = "RightShift"
            end
            v49 = v22[v45.towerGoal]
            v54 = not v49
            if v54 then
                v54 = "Trait Reroll"
                v45.towerGoal = "Trait Reroll"
            end
            v45.uiOpen = true
            v54 = transformValue11
            v49 = processItems22
            v60 = transformValue12
            v61 = transformValue13
            v64 = processItems32
            v83 = task.spawn
            v1.__ADAR_DRAW = nil
            v83 = v1.__ADAR_IRIS
            if v83 then
                v1.__ADAR_IRIS = nil
                v83 = nil
                v1.__ADAR_CONNECTED = nil
            end
            v83 = ipairs
            v104 = v167
            v84 = CoreGui
            v69 = Players.LocalPlayer
            v67 = "PlayerGui"
            v66 = v69
            v69 = v69.WaitForChild(v66, "PlayerGui")
            v104[1] = v84
            v104[2] = v69
            v83, v102, v103 = v83(v104)
            v83 = v83
            v104, v84 = v83(v102, v103)
            if v104 == nil then
                v83 = loadstring
                v102 = game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua")
            else
                v103 = v104
                local __cont15 = false
                while true do
                    v67 = "JayHubToggle"
                    v66 = v84
                    v69 = v84:FindFirstChild("JayHubToggle")
                    while true do
                        if v69 then
                            v67 = v69
                            v66 = v69.Destroy
                            v104, v84 = v83(v102, v103)
                            if v104 == nil then
                                v103 = v104
                                v83 = v1.__ADAR_OBSIDIAN
                            else
                                v103 = v104
                                __cont15 = true
                                break
                            end
                        else
                            v104, v84 = loadstring(v102, v103)
                            if v104 == nil then
                                break
                            else
                                v103 = v104
                                v67 = "JayHubToggle"
                                v66 = v84
                                v69 = v84:FindFirstChild("JayHubToggle")
                            end
                        end
                    end
                    if __cont15 then
                        __cont15 = false
                        continue
                    end
                    break
                end
                v83 = v1.__ADAR_OBSIDIAN
                v83 = loadstring
                v102 = game
                v104 = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"
                v103 = v102
                v102 = v102.HttpGet
                v102 = v102(v103, "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua")
                v83 = loadstring(v102)
                v83 = v83()
                v46 = processItems21
                v65 = runProtected4
                v45 = v1.__ADAR_CFG
                v49 = "number"
                v54 = v82("number")
                v45 = v54
                v54 = v99
                v54 = v54()
                v49 = v54.remember
                v54 = "Normal"
                v45.textSize = "Normal"
                break
            end
            v83 = loadstring(v102)()
            v84 = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"
            v102 = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
            v69 = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"
            v84 = game
            loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()
            v84 = v102
            v69 = v168
            v69.FontColor = Color3.fromRGB(238, 240, 244)
            v69.MainColor = Color3.fromRGB(25, 27, 32)
            v69.AccentColor = Color3.fromRGB(226, 170, 82)
            v69.BackgroundColor = Color3.fromRGB(14, 15, 18)
            v68 = 65
            v69.OutlineColor = Color3.fromRGB(52, 56, 65)
            v67 = Enum.Font.GothamMedium
            v66 = Font.fromEnum(v67)
            v69.FontFace = v66
            v1.__ADAR_OBSIDIAN = v83
            v69 = v169
            v169.Title = "Jay Hub"
            v169.Footer = "v1.3  •  Anime Dice"
            v169.Center = true
            v169.AutoShow = true
            v169.Resizable = true
            v66 = UDim2.fromOffset(760, 590)
            v69.Size = v66
            v67 = Enum.KeyCode
            v66 = v67[v45.menuKey]
            v69.ToggleKeybind = v66
            v69.ShowCustomCursor = false
            v69.NotifySide = "Right"
            v69.CornerRadius = 7
            v69.EnableSidebarResize = false
            v69.EnableCompacting = false
            v170.ToggleWindow = true
            v170.TabSwitch = true
            v170.Groupbox = true
            v170.Dropdown = true
            v170.KeyPicker = true
            v69.Animations = v170
            v69.TabTransitionTime = 0.18
            v69.TabSwipeOffset = 20
            v69.TabSwipeFrom = "left"
            v67 = v171
            v171.Gap = 3
            v171.Padding = 7
            v171.CornerRadius = 4
            v171.Indicator = true
            v171.IndicatorWidth = 2
            v171.IndicatorHeight = 18
            v66 = v171
            v69.TabButtonsStyle = v171
            v84 = v83
            v104 = v83:CreateWindow(v69)
            v84 = v172
            v69 = v173
            v66 = v174
            v67 = false
            v175.Home = "house"
            v175.Money = "coins"
            v175.Towers = "castle"
            v175.Rolling = "dices"
            v175.Potions = "flask-conical"
            v175.Settings = "settings"
            v105 = v175
            v68, v106, v107 = ipairs(v98)
            v68 = v68
            v108, v109 = v68(v106, v107)
            if not (v108 == nil) then
                v107 = v108
                while true do
                    v84[v109] = v104:AddTab(v109, v105[v109])
                    v108, v109 = v68(v106, v107)
                    if v108 ~= nil then
                        v107 = v108
                        continue
                    end
                    break
                end
            end
            v68 = computeValue5
            v110 = computeValue10
            player = Players.LocalPlayer
            v84.Home:AddLeftGroupbox("Overview", "house")
            v71 = player.DisplayName
            string.format("%s  (@%s)", v71, player.Name)
            v84.Home:AddRightGroupbox("Jay Hub", "sparkles")
            v176.Text = "Copy Discord"
            v176.Func = FuncHandler
            v71 = "coins"
            addLeftGroupbox = v84.Money:AddLeftGroupbox("Automatic", "coins")
            v71 = "autoEquip"
            v72 = v177
            v177.Text = "Always keep this much"
            v177.Default = tostring(v45.reserve)
            v72.Numeric = true
            v72.Finished = true
            v71 = addLeftGroupbox
            addLeftGroupbox:AddInput("reserve", v72)
            v72 = 2
            v71 = "Details"
            v84.Money:AddRightGroupbox("Details", "list-ordered")
            v72 = "plotSlot"
            v71 = v110(addLeftGroupbox, "plotSlot", "Choose a slot", processItems34)
            v72 = v110(addLeftGroupbox, "shopUpgrade", "Available upgrades", processItems36)
            v84.Towers:AddLeftGroupbox("Auto farm", "swords")
            v111 = v178
            v112, v113, v114 = ipairs(v30(select(6, ...)))
            v115, v74 = v112(v113, v114)
            if not (v115 == nil) then
                v114 = v115
                while true do
                    v76 = #v111 + 1
                    v77 = v74.name
                    v111[v76] = v77
                    v115, v74 = v112(v113, v114)
                    if v115 ~= nil then
                        v114 = v115
                        continue
                    end
                    break
                end
            end
            v74 = "towerEquipBest"
            v84.Towers:AddRightGroupbox("Tower info", "map")
            v115 = v84.Rolling
            v76 = "Choose a unit and reroll"
            v77 = "user"
            v74 = v115
            v115 = v115.AddLeftGroupbox(v74, "Choose a unit and reroll", "user")
            v74 = v179
            v76 = nil
            v180.Text = "Unit (search by name)"
            v180.Values = v181
            v80 = true
            v180.AllowNull = true
            v180.Searchable = true
            v77 = v115:AddDropdown("unit", v180)
            v69[#v69 + 1] = processItems40
            v78 = "Stops when a selected grade is rolled."
            v80 = "shield-check"
            addRightGroupbox = v84.Rolling:AddRightGroupbox("Stop when I get", "shield-check")
            v183[1] = "Traits"
            v183[2] = v88
            v183[3] = v37
            v183[4] = "keepTrait"
            v78 = v183
            v81 = "Grades"
            v79 = v39
            v184[1] = "Grades"
            v184[2] = v89
            v184[3] = v39
            v184[4] = "keepGrade"
            v182[1] = v183
            v182[2] = v184
            v116, v117, v80 = ipairs(v182)
            v80 = v80
            v118, v78 = v116(v117, v80)
            if not (v118 == nil) then
                v80 = v118
                while true do
                    v119, v120, v81 = ipairs(v78[2])
                    v81 = v81
                    v121, v79 = v119(v120, v81)
                    if not (v121 == nil) then
                        v81 = v121
                        while true do
                            v122 = v78[4] .. v79
                            v123 = v185
                            v185.Text = v79 .. " (" .. v91(v38(v78[3], v79)) .. ")"
                            v123.Default = v45[v78[4]][v79] == true
                            v86 = addRightGroupbox
                            v85 = addRightGroupbox:AddToggle(v122, v123)
                            v86 = checkCondition13
                            v121, v79 = v119(v120, v81)
                            if v121 ~= nil then
                                v81 = v121
                                continue
                            end
                            break
                        end
                    end
                    v81 = v121
                    v118, v78 = v116(v117, v80)
                    if v118 ~= nil then
                        v80 = v118
                        continue
                    end
                    break
                end
            end
            v80 = v118
            v117 = v186
            v80, v118, v78 = ipairs(v8)
            v80 = v80
            v78 = v78
            v119, v120 = v80(v118, v78)
            if not (v119 == nil) then
                v78 = v119
                while true do
                    v79 = 1
                    v81 = #v117 + 1
                    v117[v81] = v120.name
                    v119, v120 = v80(v118, v78)
                    if v119 ~= nil then
                        v78 = v119
                        continue
                    end
                    break
                end
            end
            v78 = "diceShop"
            v119 = v187
            v187.Text = "Dice shop"
            v187.Values = v117
            v187.Default = v7()
            v119.Searchable = true
            v80 = v115:AddDropdown("diceShop", v119)
            v79 = "Consumes the 3 weakest eligible spare units. Results can be weaker."
            v78 = v84.Potions
            v81 = "flask-conical"
            v78 = v78:AddLeftGroupbox("Auto potions", "flask-conical")
            v79 = "potionSaveRare"
            v81 = "Running now"
            v84.Potions:AddRightGroupbox("Running now", "timer")
            v79 = "potion"
            v81 = v110(v78, "potion", "Choose a potion", processItems42)
            v121 = v84.Settings
            v85 = "settings"
            v79 = v121
            v121 = v121.AddLeftGroupbox(v79, "Menu and saving", "settings")
            v188[1] = "Small"
            v188[2] = "Normal"
            v188[3] = "Large"
            v79 = v84.Settings
            v85 = "This session"
            v86 = "chart-column"
            v79 = v79:AddRightGroupbox("This session", "chart-column")
            v85 = nil
            v86 = processItems44
            v1.__ADAR_UI_ERROR = nil
            v1.__ADAR_UI_READY = true
            do
                return
            end
            ::__x45::
            v54 = v54
            v49 = v49
            v55, v101 = next(v49, nil)
        end
    end
end
