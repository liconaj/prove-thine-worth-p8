function draw_map(level)
    map(level.tx,level.ty,level.sx)
end

function get_map_position(level,x,y)
    local tx=flr((x-level.sx)/8)
    local ty=flr((y-level.sy)/8)
end

function is_solid(tx,ty)
    return fget(mget(tx,ty))==1
end