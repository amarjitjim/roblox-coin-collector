local Players=game:GetService("Players")
local coinsFolder=game.Workspace:WaitForChild("CoinsFolder")
local RunService=game:GetService("RunService")

Players.PlayerAdded:Connect(function(player)
	local leaderstats=Instance.new("Folder")
	leaderstats.Name="leaderstats"
	leaderstats.Parent=player
	
	local coins=Instance.new("IntValue")
	coins.Name="Coins"
	coins.Value=0
	coins.Parent=leaderstats
end)

local function spawnCoin(position)
	local coin=Instance.new("Part")
	coin.Name="Coin"
	coin.Shape=Enum.PartType.Ball
	coin.Size=Vector3.new(3,3,3)
	coin.BrickColor=BrickColor.new("Bright yellow")
	coin.Material=Enum.Material.Neon
	coin.Anchored=true
	coin.CanCollide=false
	coin.CFrame=CFrame.new(position)
	coin.Parent=coinsFolder
	
	local TweenService =game:GetService("TweenService")
	--local spinTween=TweenService:Create(
	--	coin,
	--	TweenInfo.new(
	--		2,
	--		Enum.EasingStyle.Linear,
	--		Enum.EasingDirection.Out,
	--		-1,
	--		false
	--	),
	--	{
	--		CFrame=coin.CFrame*CFrame.Angles(0,math.rad(90),0)
	--	}
	--)
	
	local spinConnection=RunService.Heartbeat:Connect(
		function(deltaTime)
			coin.CFrame=coin.CFrame*CFrame.Angles(0,math.rad(90)*deltaTime,0)
		end
	)
	local pulseTween=TweenService:Create(
		coin,
		TweenInfo.new(
			0.8,
			Enum.EasingStyle.Sine,
			Enum.EasingDirection.InOut,
			-1,
			true
		),
		{
			Size=Vector3.new(3.6,3.6,3.6)
		}
	)
	
	--spinTween:Play()
	spinConnection:Disconnect()
	pulseTween:Play()
	
	local collected=false
	
	coin.Touched:Connect(function(hit)
		if collected then return end
		
		local character=hit.Parent
		local player=Players:GetPlayerFromCharacter(character)
		if not player then return end
		
		local leaderstats=player:FindFirstChild("leaderstats")
		if not leaderstats then return end
		local playerCoins=leaderstats:FindFirstChild("Coins")
		if not playerCoins then return end
		collected=true
		
		playerCoins.Value+=10
		print(player.Name .. " collect a coin! Total: " .. playerCoins.Value)
		
		
		--spinTween:Cancel()
		spinConnection:Disconnect()
		pulseTween:Cancel()
		
		local collectTween=TweenService:Create(
			coin,
			TweenInfo.new(
				0.3,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			),
			{
				Size=Vector3.new(0,0,0),
				Transparency=1
			}
		)
		collectTween:Play()
		collectTween.Completed:Connect(function()
			coin:Destroy()
		end)
		--coin:Destroy()
		
		task.delay(10,function()
			local x=math.random(-20,20)
			local z=math.random(-10,10)
			spawnCoin(Vector3.new(x,2,z))
		end)
		
	end)
end

local coinPositions = {
	Vector3.new(10, 2, 10),
	Vector3.new(-10, 2, 10),
	Vector3.new(10, 2, -10),
	Vector3.new(-10, 2, -10),
	Vector3.new(0, 2, 0),    -- center
}


for _,position in ipairs(coinPositions) do
	spawnCoin(position)
end
