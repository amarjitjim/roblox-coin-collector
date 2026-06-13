# Roblox Coin Collector

A server-authoritative coin collecting game built in Roblox Studio.

## Live Game
[Play on Roblox](https://roblox.com/games/10317841907)

## Features
- 5 coins scattered across the map
- Player walks into coin → collects it → coin disappears
- +10 coins per collection, live leaderboard
- Coin respawns at random position after 10 seconds
- Full server authority — no client-side coin awarding
- Coins rotate, pulse, and fade on collection (TweenService + RunService)

- 
## Architecture
All game logic runs on the server (ServerScriptService).
No RemoteEvents needed — the server detects Touched events directly in Workspace.
Client never awards itself coins. Server is the only authority.

## Key Patterns Used
- Per-coin closure debounce (prevents double-collection on Touched spam)
- `GetPlayerFromCharacter` to identify which player touched a Part
- `task.delay` for non-blocking respawn timer
- `PlayerAdded` + `leaderstats` folder for live leaderboard

## Tech
- Lua 5.1 (Roblox)
- Roblox Studio

## File Structure
- `src/GameScript.lua` — all server logic (leaderstats, coin spawning, touch detection, respawn)

## How to Run
1. Open Roblox Studio → New Baseplate
2. In Workspace → Insert Folder → name it `CoinsFolder`
3. In ServerScriptService → Insert Script → paste contents of `GameScript.lua`
4. Hit Play
   
