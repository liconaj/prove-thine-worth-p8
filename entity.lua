function make_entity(self,x,y,n)
	make_sprite(self,x,y,n)
	self.last_x=0
	self.last_y=0
	self.vel_x=0
	self.vel_y=0
	self.weight=0
	self.grounded=nil
	return self
end

function update_entity(self)
	if self.grounded==false then
		self.vel_y+=self.weight
		self.vel_y=min(5,self.vel_y)
	end
	
	self.x+=self.vel_x
	self.y+=self.vel_y
	
	if self.vel_x!=0 then
		self.flip_x=self.vel_x<0
	end
	
	collide_with_map(self)
	update_sprite(self)

	self.last_x=self.x
	self.last_y=self.y
end

function draw_entity(self)
	draw_sprite(self)
end


function collide_with_map(entity)
	entity.grounded=false
	--todo: reset vel_y
	--bottom collition
	if entity.y-entity.last_y>0 then
		local bottom=entity.y+entity.h*8-1
		if is_solid(entity.x-1,bottom)
		or is_solid(entity.x+entity.w*8-1,bottom) then
			entity.y=flr(entity.y/8)*8
			entity.grounded=true
		end
	end
end


function is_solid(x,y)
	return fget(mget(x\8, y\8),0)
end