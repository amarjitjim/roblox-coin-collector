local Players=game:GetService("Players")
local coinsFolder=game.Workspace:WaitForChild("CoinsFolder")

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
		
		coin:Destroy()
		
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