/// breakWall(wall)

with(argument0) {
    if(breakable) {
        instance_change(broken,true)
        for(var i = 0; i < ds_list_size(adjacent); i+=1) {
            breakWall(ds_list_find_value(adjacent, i))
        }
    }
}
