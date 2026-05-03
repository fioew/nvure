local Lib={};

function Lib.WowStScriptEditerFrame(parent)
	local frame= WowStFrame.CreateMain("WowStScriptEditerFrame", UIParent);
	frame:SetWidth(460);
	frame:SetHeight(500);
	if frame.SetResizeBounds then
		frame:SetResizeBounds(360, 200)
	else
		frame:SetMinResize(360, 200)
	end
	frame:SetClampedToScreen(1);
	
	-- CodeFrame
    frame.Code = WowStFrame.CreateEditer("$parent_CodeFrame", frame, parent);
	frame.Code:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -25);
	frame.Code:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 25);
	frame.Exit=frame.Close;
	frame.Edit=frame.Code.Edit;
	frame.Menu=frame.Code.Menu;
	frame.Menu:Show();
	return frame;
end

function Lib.WowStScriptBoxFrame()
	local frame= WowStFrame.CreateMain("WowBeeScriptBoxFrame",UIParent);
	frame:SetWidth(300);
	frame:SetHeight(300);
	if frame.SetResizeBounds then
		frame:SetResizeBounds(200, 200)
	else
		frame:SetMinResize(200, 200)
	end
	frame:SetClampedToScreen(1);
	
    frame.Code = WowStFrame.CreateEditer("$parent_CodeFrame", frame);
	frame.Code:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -30);
	frame.Code:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 5);
	frame.Edit=frame.Code.Edit;
	frame.Insert=function(self,text)
		self.Edit:ClearFocus(0);
		self.Edit:SetCursorPosition(0);
		self.Edit:Insert(text) end
	frame:SetScript("OnHide", function(self) self.Edit:SetText("")  end);
	return frame;
end

function Lib.Init()
	
	SuperTreatmentFrame.Editer=Lib.WowStScriptEditerFrame(main);
	Lib.WowStScriptBoxFrame();
	
end
Lib.Init();
	