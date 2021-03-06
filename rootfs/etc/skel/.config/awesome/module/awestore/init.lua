--  _______                        __                    
-- |   _   |.--.--.--.-----.-----.|  |_.-----.----.-----.
-- |       ||  |  |  |  -__|__ --||   _|  _  |   _|  -__|
-- |___|___||________|_____|_____||____|_____|__| |_____|
-- ------------------------------------------------- --
-- easing function 
package.preload["awestore.easing"] = function()
    local a
    local b, c, d
    local e, f, g
    local h, i, j
    local k, l, m
    local n, o, p
    local q, r, s
    local t, u, v
    local w, x, y
    local z, A, B
    local C, D, E
    a = function(F)
        return F
    end
    b = function(F)
        local G = 1.70158 * 1.525
        F = F * 2
        if F < 1 then
            return 0.5 * F * F * ((G + 1) * F - G)
        end
        F = F - 2
        return 0.5 * (F * F * ((G + 1) * F + G) + 2)
    end
    c = function(F)
        local G = 1.70158
        return F * F * ((G + 1) * F - G)
    end
    d = function(F)
        local G = 1.70158
        F = F - 1
        return F * F * ((G + 1) * F + G) + 1
    end
    e = function(F)
        return F < 0.5 and 0.5 * (1.0 - g(1.0 - F * 2.0)) or 0.5 * g(F * 2.0 - 1.0) + 0.5
    end
    f = function(F)
        return 1.0 - g(1.0 - F)
    end
    g = function(F)
        local H = 4.0 / 11.0
        local I = 8.0 / 11.0
        local J = 9.0 / 10.0
        local K = 4356.0 / 361.0
        local L = 35442.0 / 1805.0
        local M = 16061.0 / 1805.0
        local N = F * F
        return F < H and 7.5625 * N or
            (F < I and 9.075 * N - 9.9 * F + 3.4 or (F < J and K * N - L * F + M or K * N - L * F + M))
    end
    h = function(F)
        F = F * 2
        if F < 1 then
            return -0.5 * (math.sqrt(1 - F * F) - 1)
        end
        F = F - 2
        return 0.5 * (math.sqrt(1 - F * F) + 1)
    end
    i = function(F)
        return 1.0 - math.sqrt(1.0 - F * F)
    end
    j = function(F)
        F = F - 1
        return math.sqrt(1 - F * F)
    end
    k = function(F)
        return F < 0.5 and 4.0 * F * F * F or 0.5 * (2.0 * F - 2.0) ^ 3.0 + 1.0
    end
    l = function(F)
        return F * F * F
    end
    m = function(F)
        local O = F - 1.0
        return O * O * O + 1.0
    end
    n = function(F)
        return F < 0.5 and 0.5 * math.sin(13.0 * math.pi / 2 * 2.0 * F) * 2.0 ^ (10.0 * (2.0 * F - 1.0)) or
            0.5 * math.sin(-13.0 * math.pi / 2 * (2.0 * F - 1.0 + 1.0)) * 2.0 ^ (-10.0 * (2.0 * F - 1.0)) + 1.0
    end
    o = function(F)
        return math.sin(13.0 * F * math.pi / 2) * 2.0 ^ (10.0 * (F - 1.0))
    end
    p = function(F)
        return math.sin(-13.0 * (F + 1.0) * math.pi / 2) * 2.0 ^ (-10.0 * F) + 1.0
    end
    q = function(F)
        return (F == 0.0 or F == 1.0) and F or
            (F < 0.5 and 0.5 * 2.0 ^ (20.0 * F - 10.0) or -0.5 * (2.0 ^ (10.0 - F * 20.0) + 1.0))
    end
    r = function(F)
        return F == 0 and F or 2.0 ^ (10.0 * (F - 1.0))
    end
    s = function(F)
        return F == 1 and F or 1.0 - 2.0 ^ (-10.0 * F)
    end
    t = function(F)
        F = F / 0.5
        if F < 1 then
            return 0.5 * F * F
        end
        F = F - 1
        return -0.5 * (F * (F - 2) - 1)
    end
    u = function(F)
        return F * F
    end
    v = function(F)
        return -F * (F - 2.0)
    end
    w = function(F)
        return F < 0.5 and 8.0 * F ^ 4.0 or -8.0 * (F - 1.0) ^ 4.0 + 1.0
    end
    x = function(F)
        return F ^ 4.0
    end
    y = function(F)
        return (F - 1.0) ^ 3.0 * (1.0 - F) + 1.0
    end
    z = function(F)
        F = F * 2
        if F < 1 then
            return 0.5 * F * F * F * F * F
        end
        F = F - 2
        return 0.5 * F * F * F * F * F + 2
    end
    A = function(F)
        return F * F * F * F * F
    end
    B = function(F)
        F = F - 1
        return F * F * F * F * F + 1
    end
    C = function(F)
        return -0.5 * (math.cos(math.pi * F) - 1)
    end
    D = function(F)
        local P = math.cos(F * math.pi * 0.5)
        if math.abs(P) < 1e-14 then
            return 1
        end
        return 1 - P
    end
    E = function(F)
        return math.sin(F * math.pi / 2)
    end
    return {
        linear = a,
        back_in_out = b,
        back_in = c,
        back_out = d,
        bounce_in_out = e,
        bounce_in = f,
        bounce_out = g,
        circ_in_out = h,
        circ_in = i,
        circ_out = j,
        cubic_in_out = k,
        cubic_in = l,
        cubic_out = m,
        elastic_in_out = n,
        elastic_in = o,
        elastic_out = p,
        expo_in_out = q,
        expo_in = r,
        expo_out = s,
        quad_in_out = t,
        quad_in = u,
        quad_out = v,
        quart_in_out = w,
        quart_in = x,
        quart_out = y,
        quint_in_out = z,
        quint_in = A,
        quint_out = B,
        sine_in_out = C,
        sine_in = D,
        sine_out = E
    }
end
-- ------------------------------------------------- --
-- core
package.preload["awestore.core"] = function()
    local Q = require "awestore.utils"
    local R, S, T, U, V, W, X
    W =
        setmetatable(
        {},
        {__name = "store", __tostring = function(self)
                return "store"
            end, __newindex = function(self, Y, Z)
            end}
    )
    function X(Z, _)
        local self = {[W] = true, [U] = true, [X] = true}
        local Z = Z
        local a0 = {}
        local _, a1 = _ or Q.noop, nil
        function self:set(a2)
            if Z ~= a2 then
                Z = a2
                if a1 ~= nil then
                    for a3, a4 in ipairs(a0) do
                        a4(Z)
                    end
                end
            end
        end
        function self:subscribe(a5)
            a0[#a0 + 1] = a5
            if #a0 == 1 then
                a1 =
                    _(
                    function(Z)
                        self:set(Z)
                    end
                ) or Q.noop
            end
            a5(Z)
            return function()
                for a6, a7 in ipairs(a0) do
                    if a7 == a5 then
                        table.remove(a0, a6)
                        break
                    end
                end
                if #a0 == 0 then
                    a1()
                    a1 = nil
                end
            end
        end
        function self:subscribe_next(a5)
            a0[#a0 + 1] = a5
            if #a0 == 1 then
                a1 =
                    _(
                    function(Z)
                        self:set(Z)
                    end
                ) or Q.noop
            end
            return function()
                for a6, a7 in ipairs(a0) do
                    if a7 == a5 then
                        table.remove(a0, a6)
                        break
                    end
                end
                if #a0 == 0 then
                    a1()
                    a1 = nil
                end
            end
        end
        function self:subscribe_once(a5)
            local a8
            local a8 =
                self:subscribe_next(
                function(Z)
                    a8()
                    a5(Z)
                end
            )
            return a8
        end
        function self:update(a5)
            self:set(a5(Z))
        end
        function self:derive(a5)
            return R(self, a5)
        end
        function self:get()
            local H
            self:subscribe(
                function(I)
                    H = I
                end
            )()
            return H
        end
        function self:monitor()
            return T(self)
        end
        function self:filter(a5)
            return S(self, a5)
        end
        return self
    end
    function V()
        local self = {[W] = true, [U] = true, [V] = true}
        local a0 = {}
        function self:fire()
            for a3, a4 in ipairs(a0) do
                a4()
            end
        end
        function self:subscribe(a5)
            a0[#a0 + 1] = a5
            return function()
                for a6, a7 in ipairs(a0) do
                    if a7 == a5 then
                        table.remove(a0, a6)
                        break
                    end
                end
            end
        end
        function self:subscribe_once(a5)
            local a8
            a8 =
                self:subscribe(
                function(Z)
                    a8()
                    a5(Z)
                end
            )
            return a8
        end
        function self:monitor()
            return T(self)
        end
        return self
    end
    function U(Z, _)
        local self = {[W] = true, [U] = true}
        local a9 = X(Z, _)
        function self:subscribe(a5)
            return a9:subscribe(a5)
        end
        function self:subscribe_next(a5)
            return a9:subscribe_next(a5)
        end
        function self:subscribe_once(a5)
            return a9:subscribe_once(a5)
        end
        function self:derive(a5)
            return R(self, a5)
        end
        function self:get()
            local H
            self:subscribe(
                function(I)
                    H = I
                end
            )()
            return H
        end
        function self:monitor()
            return T(self)
        end
        function self:filter(a5)
            return S(self, a5)
        end
        return self
    end
    function T(aa)
        local self = {[W] = true, [U] = true, [T] = true}
        if aa[V] == true then
            self[V] = true
        end
        function self:subscribe(a5)
            return aa:subscribe(a5)
        end
        function self:subscribe_next(a5)
            return aa:subscribe_next(a5)
        end
        function self:subscribe_once(a5)
            return aa:subscribe_once(a5)
        end
        function self:derive(a5)
            return R(self, a5)
        end
        function self:get()
            return aa:get()
        end
        function self:monitor()
            return T(self)
        end
        function self:filter(a5)
            return S(self, a5)
        end
        return self
    end
    function R(aa, a5)
        local self =
            U(
            nil,
            function(ab)
                return aa:subscribe(
                    function(Z)
                        ab(a5(Z))
                    end
                )
            end
        )
        self[R] = true
        return self
    end
    function S(aa, a5)
        local self =
            U(
            nil,
            function(ab)
                return aa:subscribe(
                    function(Z)
                        if a5(Z) then
                            ab(Z)
                        end
                    end
                )
            end
        )
        self[S] = true
        return self
    end
    return {derived = R, filtered = S, monitored = T, readable = U, signal = V, store = W, writable = X}
end
-- ------------------------------------------------- --
 
-- utils
package.preload["awestore.utils"] = function()
    local ac, ad
    ac = function(Z)
        if type(Z) ~= "table" then
            return false
        end
        local a6 = 1
        for a3, a3 in pairs(Z) do
            if Z[a6] == nil then
                return false
            end
            a6 = a6 + 1
        end
        return true
    end
    ad = function()
    end
    return {is_sequence = ac, noop = ad}
end
-- ------------------------------------------------- --
-- tweened (whatever that means)
package.preload["awestore.tweened"] = function()
    local ae = require("gears")
    local af = require("posix")
    local ag = require("awestore.core")
    local ah = require("awestore.easing")
    local Q = require("awestore.utils")
    local ai, aj, ak
    function ai()
        local al, am = af.clock_gettime(0)
        return al * 1000 + am * 1e-6
    end
    function aj(H, I)
        if H == I or H ~= H then
            return function(a3)
                return H
            end
        end
        if type(H) ~= type(I) or Q.is_sequence(H) ~= Q.is_sequence(I) then
            error("Cannot interpolate values of different types.")
        end
        if Q.is_sequence(H) then
            local an = {}
            for a6, I in ipairs(I) do
                an[#an + 1] = aj(H[a6], I)
            end
            return function(F)
                local ao = {}
                for a3, ap in ipairs(an) do
                    ao[#ao + 1] = ap(F)
                end
                return ao
            end
        end
        if type(H) == "table" then
            local an = {}
            for Y, a3 in pairs(I) do
                an[Y] = aj(H[Y], I[Y])
            end
            return function(F)
                local ao = {}
                for Y, a3 in pairs(I) do
                    ao[Y] = an[Y](F)
                end
                return ao
            end
        end
        if type(H) == "number" then
            local aq = I - H
            return function(F)
                return H + F * aq
            end
        end
        error("Cannot interpolate values of type " .. type(H) .. ".")
    end
    function ak(Z, ar)
        local self = {[ag.store] = true, [ag.readable] = true, [ag.writable] = true}
        local Z, ar = Z, ar or {}
        local as, at = Z, Z
        local W, au, av, aw, ax
        ar.delay = ar.delay or 0
        ar.duration = ar.duration or 400
        ar.step = ar.step or 32
        ar.easing = ar.easing or ah.linear
        ar.interpolate = ar.interpolate or aj
        W = ag.writable(Z)
        au = ag.signal()
        av = ag.signal()
        self.started = au:monitor()
        self.ended = av:monitor()
        function self:set(a2, ay)
            for Y, Z in pairs(ay or {}) do
                ar[Y] = Z
            end
            local az = false
            local a5
            at = aw
            aw = a2
            if ax ~= nil then
                ax:stop()
            end
            local aA = ai()
            local aB = ar.step
            local _ = aA + ar.delay
            local a1 = aA + ar.delay + ar.duration
            ax = ae.timer {timeout = aB / 1000, autostart = true, callback = function()
                    local aA = ai()
                    if aA < _ then
                        return
                    end
                    if not az then
                        a5 = ar.interpolate(Z, a2)
                        au:fire()
                        az = true
                    end
                    local aC = aA - _
                    if aC > ar.duration then
                        Z = a2
                        W:set(a2)
                        av:fire()
                        ax:stop()
                        ax = nil
                        return
                    end
                    Z = a5(ar.easing(aC / ar.duration))
                    W:set(Z)
                end}
        end
        function self:subscribe(a5)
            return W:subscribe(a5)
        end
        function self:subscribe_next(a5)
            return W:subscribe_next(a5)
        end
        function self:subscribe_once(a5)
            return W:subscribe_once(a5)
        end
        function self:get()
            return W:get()
        end
        function self:initial()
            return as
        end
        function self:last()
            return at
        end
        function self:monitor(a5)
            return ag.monitor(self, a5)
        end
        function self:derive(a5)
            return ag.derived(self, a5)
        end
        function self:filter(a5)
            return ag.filtered(self, a5)
        end
        return self
    end
    return ak
end
local ag = require("awestore.core")
local ah = require("awestore.easing")
local ak = require("awestore.tweened")
return {
    derived = ag.derived,
    easing = ah,
    filtered = ag.filtered,
    monitored = ag.monitored,
    readable = ag.readable,
    signal = ag.signal,
    store = ag.store,
    subscribe = ag.subscribe,
    tweened = ak,
    writable = ag.writable
}
