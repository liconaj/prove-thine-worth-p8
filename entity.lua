function make_entity(self,x,y,n)
	make_sprite(self,x,y,n)
	self.vel_x=0
	self.vel_y=0
	self.weight=0
	return self
end

function update_entity(self)
	self.vel_y+=self.weight
	self.vel_y=min(5,self.vel_y)
	
	self.x+=self.vel_x
	self.y+=self.vel_y
	
	if self.vel_x!=0 then
		self.flip_x=self.vel_x<0
	end
	
	update_sprite(self)
end

function draw_entity(self)
	draw_sprite(self)
end