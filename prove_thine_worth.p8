pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
--prove thine worth (port)
--unofficial pico-8 port
--
--original game by sheepolution:
--https://sheepolution.itch.io/prove-thine-worth
--source code: https://github.com/sheepolution/prove-thine-worth 
--original project released under the MIT license
--
--by liconaj

function _init()
	--mark color 12 as transparent
	--transparent color mask
	palt(0,false)
	palt(11,true)
	--entities
	player=make_player(64,64)
end

function _update()
	update_player(player)
end

function _draw()
	cls(9)
	draw_player(player)
end

-->8
--player
function make_player(x,y)
	local player={
		x=x,y=y,
		w=8,h=8,
		dx=0,dy=0,
		speed=1,
		sprite=1,
		flipx=false,
	}
	add_animation(player,"idle",{1})
	add_animation(player,"walk",{3,1,2},12)
	set_animation(player,"idle")
	return player
end

function update_player(p)
	p.dx=0
	if (btn(⬅️)) p.dx-=p.speed
	if (btn(➡️)) p.dx+=p.speed
	p.x+=p.dx
	animate_player(p)
end

function draw_player(p)
	spr(p.sprite,p.x,p.y,1,1,p.flipx)
end


function animate_player(p)
	if p.dx<0 then
		p.flipx=true
	elseif p.dx>0 then
		p.flipx=false
	end
	
	local anim="idle"
	if p.dx!=0 then
		anim="walk"
	end
	set_animation(p,anim)
	update_animation(p)
end

function add_animation(obj,name,frames,speed)
		local anim={
			name=name,
			frames=frames,
			speed=speed or 0,
			currf=1,
			t=0
		}
		obj.anims=obj.anims or {}
		obj.anims[name]=anim
		set_animation(obj,name)
end

function set_animation(obj,name)
	--reset current animation before change
	--to not save last state, but only if it
	--is a different animation
	if obj.curranim!=nil and obj.curranim.name!=name then
		reset_animation(obj)
	end
	obj.curranim=obj.anims[name]
end

function reset_animation(obj)
	obj.curranim.currf=1
	obj.curranim.t=0
end

function update_animation(obj)
	local fps=30
	local a=obj.curranim
	if #a.frames>1 and a.speed>0 then
		local frame=flr((a.t*a.speed/fps)%#a.frames)+1
		if frame<a.currf then
			a.t=0
		else
			a.t+=1
		end
		a.currf=frame
	end
	obj.sprite=a.frames[a.currf]
end

__gfx__
00000000bbbbbbbbb0bb0b0bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000
0000000000bb0b0bb0bb000000bb0b0bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000000000000000000000000000000000000000
00700700b0bb0000b0000a0ab0bb00000bbbbbbbbbbbbbbbb0bbbbbbb00bbbbbbb0bbbbb00000000000000000000000000000000000000000000000000000000
00077000b0000a0ab0000000b0000a0a0bbb0b0b00bb0b0bb0bb0b0bb0bb0b0bbb0b0b0b00000000000000000000000000000000000000000000000000000000
00077000b0000000b000000bb0000000b0bb0000b0bb0000b0bb0000b0bb0000b0bb000000000000000000000000000000000000000000000000000000000000
00700700b000000b000bbb00b000000bb0000a0ab0000a0ab0000a0ab0000a0ab0000a0a00000000000000000000000000000000000000000000000000000000
00000000b0bbbb0b0bbbbbb0bb0bb0bbb0000000b0000000b0000000b0000000b000000000000000000000000000000000000000000000000000000000000000
00000000b0bbbb0bbbbbbbbbbbb00bbbb000000bb000000bb000000bb000000bb000000b00000000000000000000000000000000000000000000000000000000
00000000bbbb0b0bbbbb0b0bbbbb0b0bbbbb0b0bbbbb0b0bbbbb0b0bb00a00b0bbbb0bbb00000000000000000000000000000000000000000000000000000000
00000000bbbb0000bbbb0000bbbb0000bbbb0000bbbb00000000000000bbb000b0bbbbbb00000000000000000000000000000000000000000000000000000000
000000000bbb0a0abbbb0a0ab0bb0a0ab00b0a0abb0b0a0ab0000000ab90b90bbbbbbbb000000000000000000000000000000000000000000000000000000000
000000000bbb000000bb0000b0bb0000b0bb0000bb0b000000090a000bbb0b0bbbbbbbbb00000000000000000000000000000000000000000000000000000000
00000000b0b0000bb0b0000bb0b0000bb0b0000bb0b0000b000a49000bbbbbab0bbb0bbb00000000000000000000000000000000000000000000000000000000
00000000b00000bbb00000bbb00000bbb00000bbb00000bbb009a400b09bbb0bbbbbbbb000000000000000000000000000000000000000000000000000000000
00000000b00000bbb00000bbb00000bbb00000bbb00000bbb000000bb00b90bbbbbbbbbb00000000000000000000000000000000000000000000000000000000
00000000b00000bbb00000bbb00000bbb00000bbb00000bbbb0000bbbb000bbbbb0bbb0b00000000000000000000000000000000000000000000000000000000
