/// setPlayerInside(player, wall, state)

var player = argument0
var wall = argument1
var state = argument2

with(wall) {
    if (not collidesHunter and playerInsideTemp[player] != state) {
        playerInsideTemp[player] = state;
        for(var i = 0; i < ds_list_size(adjacent); i+=1) {
            setPlayerInside(player, ds_list_find_value(adjacent, i), state)
        }
    }
}
