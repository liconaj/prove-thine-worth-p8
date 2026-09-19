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
	self.last_x=self.x
	self.last_y=self.y

	--apply gravity
	self.vel_y+=self.weight
	self.vel_y=min(5,self.vel_y)
	
	--move
	self.x+=self.vel_x
	self.y+=self.vel_y
	
	--flip sprite
	if self.vel_x!=0 then
		self.flip_x=self.vel_x<0
	end
	
	collide_with_map(self)
	update_sprite(self)
end

function draw_entity(self)
	draw_sprite(self)
end

function collide_with_map(entity)
	local tx1,ty1,tx2,ty2

	--check collision in axis yy
	top=entity.y
	left=entity.last_x
	right=entity.last_x+entity.tile_w*8-1
	bottom=entity.y+entity.tile_h*8-1
	local dir_y=sgn(entity.vel_y)
	local pos_yy=dir_y>0 and ceil(bottom) or flr(top)
	tx1,ty1=get_map_position(level,left,pos_yy)
	tx2,ty2=get_map_position(level,right,pos_yy)
	local collided_yy=false
	if is_solid(tx1,ty1) then
		resolve_map_collision(entity,tx1,ty1,nil,dir_y)
		collided_yy=true
	elseif is_solid(tx2,ty2) then
		resolve_map_collision(entity,tx2,ty2,nil,dir_y)
		collided_yy=true
	end
	if collided_yy then
		entity.vel_y=0
	end

	--check collision in axis xx
	top=entity.last_y
	left=entity.x
	right=entity.x+entity.tile_w*8-1
	bottom=entity.last_y+entity.tile_h*8-1
	local dir_x=sgn(entity.vel_x)
	local pos_xx=dir_x>0 and ceil(right) or flr(left)
	tx1,ty1=get_map_position(level,pos_xx,top)
	tx2,ty2=get_map_position(level,pos_xx,bottom)
	local collided_xx=false
	if is_solid(tx1,ty1) then
		resolve_map_collision(entity,tx1,ty1,dir_x,nil)
		collided_xx=true
	elseif is_solid(tx2,ty2) then
		resolve_map_collision(entity,tx2,ty2,dir_x,nil)
		collided_xx=true
	end
	if collided_xx then
		entity.vel_x=0
	end
end

function resolve_map_collision(entity,tx,ty,dir_x,dir_y)
	dir_x=dir_x or 0
	dir_y=dir_y or 0
	local coll_map_x=tx*8+level.sx
	local coll_map_y=ty*8+level.sy
	local w=entity.tile_w*8
	local h=entity.tile_h*8
	if dir_x>0 then
		entity.x=coll_map_x-w
	elseif dir_x<0 then
		entity.x=coll_map_x+w
	elseif dir_y>0 then
		entity.y=coll_map_y-h
	elseif dir_y<0 then
		entity.y=coll_map_y+h
	end
end

function is_solid(x,y)
	return fget(mget(x\8, y\8),0)
end