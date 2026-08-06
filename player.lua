function make_player(self,x,y)
	make_entity(self,x,y)
	
	self.speed=1
	self.weight=0.2
	
	self.idle_timer=0
	
	add_animation(self,"idle",{1})
	add_animation(self,"jump",{2})
	add_animation(self,"walk",{2,3,1},12)
	
	return self
end

function update_player(self)
	self.vel_x=0
	if (btn(⬅️)) self.vel_x-=self.speed
	if (btn(➡️)) self.vel_x+=self.speed
	
	update_player_animation(self)
	update_entity(self)
end

function draw_player(self)
	draw_entity(self)
end

function update_player_animation(self)
	if self.grounded==true then
		set_animation(self,self.vel_x!=0 and "walk" or "idle")
	else
		set_animation(self,"jump")
	end
	
	local max_static_idle_time=25
	if self.current_animation=="idle" then
		if self.idle_timer<max_static_idle_time then
			self.idle_timer+=1
			if self.idle_timer==max_static_idle_time then
				if rnd()<0.5 then
					add_animation(self,"idle",{4,5,6,7,8,8,7,6,5,4},12)
				else
					add_animation(self,"idle",{17,18,19,20,21,21,20,19,18,17},12)
				end
			end
		end
	else
		if self.idle_timer==max_static_idle_time then
			add_animation(self,"idle",{1})
		end
		self.idle_timer=0
	end
end