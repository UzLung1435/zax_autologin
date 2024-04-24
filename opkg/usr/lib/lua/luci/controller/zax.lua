module("luci.controller.zax", package.seeall)

function index()
	entry({ "admin", "services", "zax" }, cbi("zax"), "zax", 1)
end
