/// allClear(wall)

with(argument0) {
    if(checked){
        return true
    }
    checked = true
    if(not clear) {
        return false
    }
    
    for(var i = 0; i < ds_list_size(adjacent); i+=1) {
        var otherWall = ds_list_find_value(adjacent, i)
        if(otherWall.wait_id == wait_id) {
            if(not allClear(otherWall)) {
                return false
            }
        }
    }
}

return true
