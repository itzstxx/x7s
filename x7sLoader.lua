

local RAW_URL = "https://raw.githubusercontent.com/itzstxx/x7s/main/NexusV1.lua"

local source do
    local ok, result = pcall(function()
        return game:HttpGet(RAW_URL, true)
    end)
    if not ok or type(result) ~= "string" or #result < 10 then
        error("[x7s Loader] No se pudo descargar NexusV1.\n"..
              "  → URL: "..RAW_URL.."\n"..
              "  → Error: "..tostring(result), 2)
        return
    end
    source = result
end

local fn, compileErr = loadstring(source, "x7s")
if not fn then
    error("[x7s Loader] Error al compilar:\n  "..tostring(compileErr), 2)
    return
end

local ok2, runtimeErr = pcall(fn)
if not ok2 then
    error("[x7s Loader] Error al ejecutar:\n  "..tostring(runtimeErr), 2)
    return
end

print("[x7s Loader] Cargado — "..game.Players.LocalPlayer.Name)