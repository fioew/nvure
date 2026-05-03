local version, build, dates, tocversion = GetBuildInfo()
local buildx = string.upper(string.format("%x",build))
StaticPopupDialogs["AM_VERSION_EXPIRED"] = {
	text = "发现 WOW 客户端已更新!\n最新版本:"..version..":"..build.."\n请更新GC助手使用编号:"..buildx.."\n获取支持: www.luacn.net ",
	button1 = "我明白",
	OnAccept = function(self, data) end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = nil
}
if tonumber(build) > 0XE91F then 
	StaticPopup_Show("AM_VERSION_EXPIRED", "GC")
	SuperTreatmentFrame:Hide()
end