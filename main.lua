function _init()
	--mark color 12 as transparent
	--transparent color mask
	palt(0,false)
	palt(11,true)
	--entities
	player=make_player({},64,16)
	level = {tx=0,ty=0,sx=0,sy=0,tw=16,th=16,
}
end

function _update()
	update_player(player)
end

function _draw()
	cls(9)
	draw_map(level)
	draw_player(player)
end