local uci = require("luci.model.uci").cursor()

zax = Map(
    "zaxConnect",
    "zaxConnect",
    [[
        <a href="https://github.com/UzLung1435/zax_autologin" target="_blank">Version: 0.1.0</a>
        <br>
        <del>您有被检测共享上网，请不要共享上网......</del>
    ]]
)

enableStatus = zax:section(NamedSection, "enabled", "zax", "Status")
main = zax:section(NamedSection, "main", "zax", "Settings")

enableStatus:option(Flag, "enabled", "Enabled")

main:tab("general", "General Settings")

loginaddr = main:taboption("general", Value, "loginaddr", "loginaddr")
loginaddr.placeholder = "http://192.16.99.5"

zaxbras = main:taboption("general", Value, "zaxbras", "zaxbras")
zaxbras:value("zkbras")
zaxbras:value("zkbras1")
zaxbras:value("zkbras2")
zaxbras:value("zk_byoff")

username = main:taboption("general", Value, "username", "username")
username.placeholder = "Your username or userId"

username = main:taboption("general", Value, "password", "password")
username.placeholder = "Your password"

local apply = luci.http.formvalue("cbi.apply")
if apply then
    io.popen("/etc/init.d/net.service restart")
end

return zax