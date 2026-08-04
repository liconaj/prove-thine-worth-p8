function make_sprite(self,x,y,n)
	self=self or {}
	self.x=x
	self.y=y
	self.w=1
	self.h=1
	self.n=n
	self.flip_x=false
	self.flip_y=false
	return self
end

function update_sprite(self)
	if self.animations!=nil then
		update_animation(self)
	end
end

function draw_sprite(self)
	spr(self.n,self.x,self.y,self.w,self.h,self.flip_x,self.flip_y)
end

--animation
-------------------------------
function add_animation(sprite,name,frames,speed)
	local animation={
		frames=frames,
		speed=speed or 0,
		current_frame=1,
		t=0
	}
	sprite.animations=sprite.animations or {}
	sprite.animations[name]=animation
	if sprite.current_animation==nil then
		set_animation(sprite,name)
	end
end

function set_animation(sprite,name)
	--reset current animation before change
	--to not save last state, but only if it
	--is a different animation
	if sprite.current_animation!=nil
	and sprite.current_animation!=name then
		reset_animation(sprite)
	end
	sprite.current_animation=name
end

function reset_animation(sprite)
	local a=sprite.animations[sprite.current_animation]
	a.current_frame=1
	a.t=0
end

function update_animation(sprite)
	local fps=30
	local a=sprite.animations[sprite.current_animation]
	if #a.frames>1 and a.speed>0 then
		local frame=flr((a.t*a.speed/fps)%#a.frames)+1
		if frame<a.current_frame then
			a.t=0
		else
			a.t+=1
		end
		a.current_frame=frame
	end
	sprite.n=a.frames[a.current_frame]
end