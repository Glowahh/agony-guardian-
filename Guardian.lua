if not game:IsLoaded() then game.Loaded:Wait() end
if getgenv().Guardian then return end
getgenv().options={
    MaliciousNamecalls={
        Enabled=true,
        ShowNamecall=true
    },
    ChatBan=false,
    PetSim={
        Enabled=true,
        ShowUser=true,
        Bank=true,
        Mail=true
    },
    MiningSim=true,
    AntiLog={
        Enabled=true,
        ShowInfo=true,
        ShowDestination=true,
        Payback=true
    },
    AutoJoin={
        Enabled=true,
        ShowServer=true
    },
    BeeSwarm=true,
    Require=true,
    AntiKick=true,
    BasicAntiCheatBypass=true,
    MemoryDetections=true,
    GUIDetection=true,
    GroupBypass=true,
    AntiReport=true,
    ClearTrace=true,
    Output=warn --Change to your prefered output option (print,warn,printconsole,rconsoleprint,rconsolewarn,etc)
}
getgenv().Guardian={
    SetAll=function(a)
        for i, v in next,options do
            if typeof(v)=="table" then
                for i2 in next,v do
                    options[i][i2]=a
                end
            else
                options[i]=a
            end
        end
    end
})
if not hookmetamethod or not hookfunction then
    task.spawn(function()error("Your executor does not support a core function needed for this script. Expect detections and poor security")end)
end
if not getproperties then
    task.spawn(function()error("Your executor does not support getproperties, so the basic anti cheat bypass sadly won't work for you. However, everything else should.")end)
end
if is_sirhurt_closure then
    task.spawn(function()error("Thanks to your lovely executor's developers, malicious namecall functions protection will not work because they were that great at coding it.")end)
end
local hrequest,execlosure=
{
    (typeof(syn)=='table'and syn.request),
    (typeof(http)=='table'and http.request),
    (typeof(fluxus)=='table'and fluxus.request),
    request,
    http_request~=request and http_request, 
    HttpPost
},is_synapse_function or isexecutorclosure or iskrnlclosure or issentinelclosure or is_protosmasher_closure or is_sirhurt_closure or iselectronfunction or checkclosure
getgenv().savedProps={}
local Players=game:GetService("Players")
local LocalPlayer=Players.LocalPlayer
local Char=(LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())
local rd=math.random
local StarterGui,Stats,Content=game:GetService("StarterGui"),game:GetService("Stats"),game:GetService("ContentProvider")
local tr,hiv,bank=game.PlaceId==9551640993 and game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ConfirmTrade"),game.PlaceId==1537690962 and game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ConstructHiveCellFromEgg")--[[game.PlaceId==6284583030 and workspace:WaitForChild("__THINGS"):WaitForChild("__REMOTES"):WaitForChild("invite to bank")]]
local ChatBar,ChatScript,SayMessageRequest=LocalPlayer.PlayerGui:WaitForChild("Chat"):WaitForChild("Frame").ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar,LocalPlayer.PlayerScripts:WaitForChild("ChatScript"),game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
local ChatMain=ChatScript:WaitForChild("ChatMain")
local MessagePostedEvent
for _, Event in next, debug.getupvalues(require(ChatMain).MessagePosted.fire) do
    if typeof(Event) == "Instance" then
        MessagePostedEvent = Event
    end
end
local namecall={
    ["BrowserService"]={
        ["OpenBrowserWindow"]=1,
        ["ExecuteJavaScript"]=2
    },
    ["MarketplaceService"]={
        ["PerformPurchase"]=1,
        ["GetRobuxBalance"]=2
    },
    ["MessageBusService"]={
        ["Publish"]=1,
        ["GetMessageId"]=2
    },
    ["HttpService"]={
        ["RequestInternal"]=1
    },
    ["GuiService"]={
        ["OpenBrowserWindow"]=1
    },
    ["DataModel"]={
        ["OpenVideosFolder"]=1,
        ["OpenScreenshotsFolder"]=2
    },
    ["RbxAnalyticsService"]={
        ["GetClientId"]=1
    }
}
if cloneref(game):GetService("VideoCaptureService") then
    namecall["VideoCaptureService"]={
        ["GetCameraDevices"]=1
    }
end
local old1,old2,old3,old4,old5,old8,old9,old10,old11,old12,old13,old14,old15
if hookfunction then
	old5=hookfunction(getrenv().gcinfo,function(...)
		return options.MemoryDetections and rd(1500,2500) or old5(...)
	end)
	old11=hookfunction(Players.ReportAbuse,function(...)
		if options.AntiReport then
			options.Output("Player report was attempted. Attempt denied")
			return error("Ha ha")
		end
		return old11(...)
	end)
	if not is_sirhurt_closure then
		for i,v in next,namecall do
			for i2,v2 in next,v do
				local old7
				old7=hookfunction(i=="DataModel" and game[i2] or game[i][i2],function(...) return not options.MaliciousNamecalls and old7(...) or options.Output(("Malicious function%s attempted execution. Attempt denied."):format(options.MaliciousNamecalls.ShowNamecall and "game"..i2 or "")) end)
			end
		end
	end
	old13=hookfunction(Instance.new("BindableEvent").Fire,function(...)
		return not options.ChatBan and old13(...) or self==MessagePostedEvent and options.Output("MessagePosted usage was attempted. Attempt denied.") or old13(...)
	end)
	old12=hookfunction(ChatBar.CaptureFocus,function(...)
		if options.ChatBan then
			options.Output("Chat focus capture as local player was attempted. Attempt denied.")
			if getcallingscript()~=ChatScript then
				if not rawget(getgenv(),"c") then
					StarterGui:SetCore("SendNotification",{
						Title="WARNING!",
						Text="There is an attempt to force you to chat in game."..getcallingscript():GetFullName(),
						Button1="Okay!",
						Duration=15
					})
					StarterGui:SetCore("SendNotification",{
						Title="What to do",
						Text="If it is due to a script, rejoin and do not execute it again. Otherwise, go there (through dex) and disable/delete it.",
						Button1="Okay!",
						Duration=15
					})
					if getcallingscript() then
					setclipboard(getcallingscript():GetFullName())
						StarterGui:SetCore("SendNotification",{
							Title="Copied to clipboard",
							Text="The path has also been copied to clipboard so you won't lose it in case this warning is gone too fast.",
							Button1="Okay!",
							Duration=15
						})
					end
					rawset(getgenv(),"c","e")
				end
			end
			return
		end
		return old12(...)
	end)
	old8=hookfunction(Content.PreloadAsync,function(...)
		local args={...}
		return options.GUIDetection and (args[1]==Content and typeof(args[2])=="table" and options.Output("GUI detection attempted. Attempt denied.")) or old8(...) 
	end)
	old9=hookfunction(Stats.GetTotalMemoryUsageMb,function(...)
		local args={...}
		return options.MemoryDetections and (args[1]==Stats and rd(400,550)) or old9(...)
	end)
	old10=hookfunction(game.Players.LocalPlayer.Kick,function(...)
		local args={...}
		return options.AntiKick and (args[1]==LocalPlayer and options.Output("Attempt to kick player denied.")) or old10(...) 
	end)
	local oldd,oldd2
	oldd=hookfunction(Instance.new("RemoteEvent").FireServer,newcclosure(function(self,...)
		if options.ChatBan and self==SayMessageRequest and getcallingscript()~=ChatMain then
			return options.Output("SayMessageRequest remote event attempted to fire. Attempt denied.")
		end
		if checkcaller() then
			if game.PlaceId==9551640993 and options.MiningSim and self==tr then
				return options.Output("Script attempted to confirm a potentially rigged/scam trade. Attempt denied.")
			end
		end
		return oldd(self,...)
	end))
	if game.GameId==2316994223 then
    	local oldPet
    	oldPet=hookfunction(require(game:GetService("ReplicatedStorage").Library.Client.Network).Invoke,function(self,...)
    	    if options.PetSim.Enabled and checkcaller() then
    	        local args={...}
                if self=="Invite To Bank" and options.PetSim.Bank then
        			task.spawn(function()
        				options.Output(("Script attempted to give user%saccess to your bank. Attempt denied."):format(options.PetSim.ShowUser and " named ".. Players:GetNameFromUserIdAsync(args[2]).." (ID: "..args[2]..") " or " "))
        			end)
        			return
                end
                if self=="Send Mail" and options.PetSim.Mail then
                    task.spawn(function()
                        options.Output(("Script attempted to send mail to a user%s. Attempt denied."):format(options.PetSim.ShowUser and " named ".. args[1]["Recipient"].." (ID: "..Players:GetUserIdFromNameAsync(args[1]["Recipient"])..") " or ""))
                    end)
                    return
                end
    	    end
            return oldPet(self,...)
        end)
    	    end
	oldd2=hookfunction(Instance.new("RemoteFunction").InvokeServer,newcclosure(function(self,...)
		if game.PlaceId==1537690962 and options.BeeSwarm and self==hiv then
			return options.Output("Script attempted to place a basic bee egg, potentially for a fake dupe. Attempt denied.")
		end
		return oldd2(self,...)
	end))
	function ToString(tbl,level)
		local tabString = "\t"
		local tblString = "{\n"..tabString:rep(level)
		local newLineString = ",\n"..tabString:rep(level)
		for key,value in pairs(tbl) do 
			if type(value) == "table" then 
				tblString = tblString  .. key .. "=" .. ToString(value,level+1)
			else
				tblString = tblString  .. key .. "= " .. tostring(value):gsub("\n","") .. newLineString
			end
		end
		return tblString..("\n%s}"):format(tabString:rep(level))
	end
	for i,v in next,hrequest do
		if v then
			local old6
			old6=hookfunction(v,function(...)
				local args={...}
				if (args[1].Url:find("webhook") or args[1].Url:find("websec")) and options.AntiLog.Enabled then
					options.Output(("Script attempted to log info%s. Attempt denied. %s\n%s"):format(options.AntiLog.ShowDestination and " at "..args[1].Url or "",options.AntiLog.ShowInfo and "\nLogged info:\n"     ..(args[1].Body and ToString(game:GetService("HttpService"):JSONDecode(args[1].Body),1)or "None")or "",options.AntiLog.Payback and not is_sirhurt_closure and "Webhook was deleted." or ""))
					if options.AntiLog.Payback and not is_sirhurt_closure then
						args[1].Method="DELETE"
					else
						args[1].Url="https://google.com"
					end
					return old6(unpack(args))
				end
				if args[1].Url:find("rpc") and options.AutoJoin.Enabled then
					options.Output(("Script attempted to auto join %s. Attempt denied."):format(options.AutoJoin.ShowServer and (args[1].Body and "https://discord.gg/"..game:GetService("HttpService"):JSONDecode(args[1].Body).args.code or "nil") or "a server")) 
					return 
				end 
				return old6(...)
			end)
		end
	end
	old3=hookfunction(getrenv().debug.info,function(...)
		local args={...}
		return options.Require and (args[1]==2 and args[2]=="s" and getcallingscript()) or old3(...)
	end)
	--old4=hookmetamethod(Vector3.new(),"__index",newcclosure(function(self,b,...)
	--    return options.BasicAntiCheatBypass and not table.find({LocalPlayer.PlayerScripts.PlayerModule.ControlModule,LocalPlayer.PlayerScripts.RbxCharacterSounds},getcallingscript()) and b:lower()=="magnitude" and (old4(self,b,...)<=savedProps.WalkSpeed and old4(self,b,...) or rd(0,savedProps.WalkSpeed)) or old4(self,b,...)
	--end),false)
	old14=hookfunction(LocalPlayer.IsInGroup,function(...)
		local args={...}
		return options.GroupBypass and (args[1]==LocalPlayer and typeof(args[2])=="number" and args[2]>0 and true) or old14(...)
	end)
	--[[old15=hookfunction(LocalPlayer.DistanceFromCharacter,function(...)
		local args={...}
		return not checkcaller() and (options.BasicAntiCheatBypass and (args[1]==LocalPlayer and typeof(args[2])=="Vector3" and (old15(...)<savedProps.WalkSpeed and old15(...) or rd(0,savedProps.WalkSpeed)))) or old15(...)
	end)]]
end
if hookmetamethod then
	old1=hookmetamethod(game,"__namecall",newcclosure(function(self,...)
		local args={...}
		local method=string.upper(string.sub(getnamecallmethod(),1,1))..string.sub(getnamecallmethod(),2,#getnamecallmethod())
		if options.ChatBan then
			if method=="FireServer" and self==SayMessageRequest and getcallingscript()~=ChatMain then
				options.Output("SayMessageRequest remote event attempted to fire. Attempt denied.")
				return
			elseif method=="CaptureFocus" and self==ChatBar then
				options.Output("Chat focus capture as local player was attempted. Attempt denied.")
				if getcallingscript()~=ChatScript then
					if not getgenv().a then
						StarterGui.SetCore(StarterGui,"SendNotification",{
							Title="WARNING!",
							Text="There is an attempt to force you to chat in game."..getcallingscript().GetFullName(getcallingscript()),
							Button1="Okay!",
							Duration=15
						})
						StarterGui.SetCore(StarterGui,"SendNotification",{
							Title="What to do",
							Text="If it is due to a script, rejoin and do not execute it again. Otherwise, go there (through dex) and disable/delete it.",
							Button1="Okay!",
							Duration=15
						})
						if getcallingscript() then
							setclipboard(getcallingscript().GetFullName(getcallingscript()))
							StarterGui.SetCore(StarterGui,"SendNotification",{
								Title="Copied to clipboard",
								Text="The path has also been copied to clipboard so you won't lose it in case this warning is gone too fast.",
								Button1="Okay!",
								Duration=15
							})
						end
						getgenv().a="e"
					end
				end
				return
			elseif method=="Fire" and self==MessagePostedEvent then
				options.Output("MessagePosted usage was attempted. Attempt denied.")
				return
			end
		end
		if options.AntiReport and method=="ReportAbuse" and self==Players then
			options.Output("Player report was attempted. Attempt denied.")
			return error("Ha ha")
		end
		if namecall[self.ClassName] and 
		namecall[self.ClassName][method] and options.MaliciousNamecalls.Enabled
		then
			options.Output(("Malicious namecall%s attempted execution. Attempt denied."):format(options.MaliciousNamecalls.ShowNamecall and " "..self.GetFullName(self)..":"..method or ""))
			return error("Get owned")
		end
		--[[if not checkcaller() and method=="DistanceFromCharacter" and self==LocalPlayer and typeof(args[1])=="Vector3" and options.BasicAntiCheatBypass then
			return old1(self,...)<savedProps.WalkSpeed and old1(self,...) or rd(0,savedProps.WalkSpeed)
		end]]
		if options.AntiKick and self==LocalPlayer and method=="Kick" then
			options.Output("Attempt to kick player denied.")
			return
		end
		if options.MemoryDetections and self==Stats and method=="GetTotalMemoryUsageMb" then
			return rd(400,550)
		end
		if options.GUIDetection and self==Content and method=="PreloadAsync" and typeof(args[1])=="table" then
			return
		end
		if options.GroupBypass and self==LocalPlayer and method=="IsInGroup" and typeof(args[1])=="number" and args[1]>0 then
			return true
		end
		if checkcaller() then
			if game.PlaceId==9551640993 and options.MiningSim and self==tr and method=="FireServer" then
				options.Output("Script attempted to confirm a potentially rigged/scam trade. Attempt denied.")
				return
			--[[elseif game.PlaceId==6284583030 and options.PetSim and self==bank and method=="InvokeServer" then
				local args={...}
				task.spawn(function()
					options.Output(("Script attempted to give user named %s (ID: %s) access to your bank. Attempt denied."):format(Players:GetNameFromUserIdAsync(args[1][2]),args[1][2]))
				end)
				return ]]
			elseif game.PlaceId==1537690962 and options.BeeSwarm and self==hiv and method=="InvokeServer" then
				options.Output("Script attempted to place a basic bee egg, potentially a fake dupe. Attempt denied.")
				return
			end
		end
		return old1(self,...)
	end))
	if getproperties then
		repeat task.wait()until #Char:GetChildren()>0
		for i,v in next,Char:GetChildren() do
			savedProps[v]={}
			for i2,v2 in next,getproperties(v) do
				if typeof(v2)~="Vector3" and typeof(v2)~="CFrame" then
					savedProps[v][i2]=v2
				end
			end
		end
		old2=hookmetamethod(game,"__index",newcclosure(function(self,b,...)
			if not checkcaller() and rawget(savedProps,self) and rawget(rawget(savedProps,self),b) and rawget(options,"BasicAntiCheatBypass") then
				return rawget(rawget(savedProps,self),b)
			end
			return old2(self,b,...)
		end))
	end
end

task.spawn(function()
    while task.wait() do
        ChatBar.Text=options.ChatBan 
        and (not ChatBar:IsFocused() 
        and ChatBar.Text~="" and "") or ChatBar.Text
    end
end)
if options.ClearTrace then
    for i,v in next,getgc()do
        if typeof(v)=="function" and execlosure(v) then
            v=nil
        end
    end
end
