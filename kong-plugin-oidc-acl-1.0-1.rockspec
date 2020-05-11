package = "kong-plugin-oidc-acl-fix"
version = "1.0-1"
local pluginName = "oidc-acl"
source = {
  url = "git://github.com/pravin-raha/kong-plugin-oidc-acl",
}
description = {
  summary = "A Kong ACL plugin for oidc plugin from pravin-raha/kong-plugin-oidc-acl and fixed",
  license = "Apache 2.0"
}
dependencies = {
  "lua ~> 5.1",
  "lua-resty-cookie ~> 0.1.0"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.oidc-acl.handler"] = "handler.lua",
    ["kong.plugins.oidc-acl.schema"]  = "schema.lua"
  }
}