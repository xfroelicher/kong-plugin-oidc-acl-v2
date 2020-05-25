local ACL = require("kong.plugins.base_plugin"):extend()
local cjson = require("cjson")

function ACL:new()
    ACL.super.new(self, "acl-keycloak")
end


function ACL:access(plugin_conf)
    ACL.super.access(self)

    local whitelist = plugin_conf.whitelist
    local userroles = get_user_roles()

    if has_value(whitelist, userroles) then
        return
    else
        ngx.status = 401
        ngx.say("You cannot consume this service")
        ngx.exit(ngx.HTTP_UNAUTHORIZED)
    end

end


function has_value (tab, val)
    for _, value in ipairs(tab) do
        for _, val_value in ipairs(val) do
            if value == val_value then
                return true
            end
        end
    end

    return false
end


function mysplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ;
    local i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end


function get_user_roles()
    local h = ngx.req.get_headers()
    for k, v in pairs(h) do
        if k == 'x-userinfo' then
            local user = cjson.decode(ngx.decode_base64(v))
            local roles = table.concat(user["realm_access"]["roles"],",")
            return mysplit(roles, ",")
        end
    end

    return {}
end


ACL.PRIORITY = 950


return ACL