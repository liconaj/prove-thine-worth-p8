function _init()
	--mark color 12 as transparent
	--transparent color mask
	palt(0,false)
	palt(11,true)
	--entities
	player=make_player({},64,72)
end

function _update()
	update_player(player)
end

function _draw()
	cls(9)
	map(0,0,0,0,16,16)
	draw_player(player)
end