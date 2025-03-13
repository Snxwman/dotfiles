local log = {}

function log.debug()
    return require("plenary.log").new({
        level = "debug"
    })
end

return log
