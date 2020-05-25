package = "kong-plugin-acl-keycloak"
version = "1.0-1"
local pluginName = "acl-keycloak"
source = {
  url = "git://github.com/xfroelicher/kong-plugin-oidc-acl-v2",
}
description = {
  summary = "A Kong ACL plugin for keycloak from pravin-raha/kong-plugin-oidc-acl and fixed",
  license = "Apache 2.0"
}
dependencies = {
  "lua ~> 5.1",
  "lua-resty-cookie ~> 0.1.0"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.acl-keycloak.handler"] = "handler.lua",
    ["kong.plugins.acl-keycloak.schema"]  = "schema.lua"
  }
}