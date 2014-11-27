/// checkAdjacent(check_x,check_y,type)

var check_x = argument0
var check_y = argument1
var type = argument2

if (check_x < 0) {
    check_x = check_x + room_width
} else if (check_x > room_width) {
    check_x = check_x - room_width
}

if (check_y < 0) {
    check_y = check_y + room_height
} else if (check_y > room_height) {
    check_y = check_y - room_height
}

addAdjacent(instance_position(check_x, check_y, type))
