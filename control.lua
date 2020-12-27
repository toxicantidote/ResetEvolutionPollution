local mod_gui = require("mod-gui")

function doit(player)
	for _, surface in pairs (game.surfaces) do surface.clear_pollution() end
	game.forces["enemy"].reset_evolution()
	game.forces["enemy"].kill_all_units()
	log({'ResetEvolutionPollution_text', player.name})
	game.print({'ResetEvolutionPollution_text', player.name})
end

function show_gui(player)
	local gui = mod_gui.get_button_flow(player)
	if not gui.ResetEvolutionPollution then
		gui.add{
			type = "sprite-button",
			name = "ResetEvolutionPollution",
			sprite = "ResetEvolutionPollution_button",
			style = mod_gui.button_style,
			tooltip = {'ResetEvolutionPollution_buttontext'}
		}
	end
end

do---- Init ----
script.on_init(function()
	for _, player in pairs(game.players) do
		if player and player.valid then show_gui(player) end
	end
end)

script.on_configuration_changed(function(data)
	for _, player in pairs(game.players) do
		if player and player.valid then
			if player.gui.left.ResetEvolutionPollution_button then	player.gui.left.ResetEvolutionPollution_button.destroy()	end
			show_gui(player)
		end
	end
end)

script.on_event({defines.events.on_player_created, defines.events.on_player_joined_game, defines.events.on_player_respawned}, function(event)
  local player = game.players[event.player_index]
  if player and player.valid then show_gui(player) end
end)

script.on_event(defines.events.on_gui_click, function(event)
  local gui = event.element
  local player = game.players[event.player_index]
  if not (player and player.valid and gui and gui.valid) then return end
	if gui.name == "ResetEvolutionPollution" then doit(player) end
end)
end
