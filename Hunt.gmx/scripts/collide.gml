objWall.solid = true
move_outside_solid(direction-180, 6)
var dt = 1.0
var iter = 0
while (floor(dt*speed) > 0 and iter < 9) {
    //show_debug_message("dt = ")
    //show_debug_message(dt)
    //show_debug_message("iter = ")
    //show_debug_message(iter)
    //show_debug_message("------------")
    iter = iter + 1
    var xold = x
    var yold = y
    move_contact_solid(direction, floor(dt*speed))
    move_outside_solid(direction-180, floor(dt*speed + 1))
    var dr = sqrt(sqr(x-xold) + sqr(y-yold))
    dt = (dt - dr / speed)
    if dt < 0.1 {
        dt = 0
    } else if dt > 1.0 {
        show_debug_message("dt > 1.0")
        show_debug_message("speed = ")
        show_debug_message(speed)
        show_debug_message("dr = ")
        show_debug_message(dr)
        show_debug_message("dt = ")
        show_debug_message(dt)
        show_debug_message("------------")
    }
    
    var wall = noone;

    var vwall = noone;
    var hwall = noone;
    if (hspeed > 0) {
        vwall = instance_place(x+1, y, objWallRect)
    } else if (hspeed < 0) {
        vwall = instance_place(x-1, y, objWallRect)
    }
    if (vspeed > 0) {
        hwall = instance_place(x, y+1, objWallRect)
    } else if (vspeed < 0) {
        hwall = instance_place(x, y-1, objWallRect)
    }
    if (vwall != noone) {
        if (hwall == vwall) {
            normal_x = vwall.x + vwall.sprite_width/2 - self.x
            normal_y = vwall.y + vwall.sprite_height/2 - self.y
            normal_x = normal_x - sign(normal_x)*vwall.sprite_width/2
            normal_y = normal_y - sign(normal_y)*vwall.sprite_height/2
            var normal = sqrt(normal_x*normal_x + normal_y*normal_y)
            normal_x = normal_x / normal
            normal_y = normal_y / normal
            normal_time = 3
            wall = vwall
        } else  {
            normal_x = 1
            normal_y = 0
            wall = vwall
        }
    } else if (hwall != noone) {
        normal_x = 0
        normal_y = 1
        wall = hwall
    } else {
        var dlwall = noone;
        var drwall = noone;
        if (hspeed + vspeed > 0) {
            //show_debug_message("x+1, y+1")
            dlwall = instance_place(x+1, y+1, objWallDiag)
        } else if (hspeed + vspeed < 0) {
            //show_debug_message("x-1, y-1")
            dlwall = instance_place(x-1, y-1, objWallDiag)
        }
        if (hspeed - vspeed > 0) {
            //show_debug_message("x+1, y-1")
            drwall = instance_place(x+1, y-1, objWallDiag)
        } else if (hspeed - vspeed < 0) {
            //show_debug_message("x-1, y+1")
            drwall = instance_place(x-1, y+1, objWallDiag)
        }
        //show_debug_message(dlwall)
        //show_debug_message(drwall)
        if (dlwall != noone) {
            if (drwall == dlwall) {
                show_debug_message("corner")
                normal_x = dlwall.x + dlwall.sprite_width/2 - self.x
                normal_y = dlwall.y + dlwall.sprite_height/2 - self.y
                if (abs(normal_x) > abs(normal_y)) {
                    normal_x = normal_x - sign(normal_x)*dlwall.sprite_width/2
                } else {
                    normal_y = normal_y - sign(normal_y)*dlwall.sprite_height/2
                }
                var normal = sqrt(normal_x*normal_x + normal_y*normal_y)
                normal_x = normal_x / normal
                normal_y = normal_y / normal
                normal_time = 3
                wall = dlwall
            } else {
                normal_x = 1 / sqrt(2)
                normal_y = 1 / sqrt(2)
                normal_time = 3
                wall = dlwall
            }
        } else if (drwall != noone) {
            normal_x = 1 / sqrt(2)
            normal_y = -1 / sqrt(2)
            normal_time = 3
            wall = drwall
        }
    }
    
    if (wall != noone) {
        var dot = normal_x*hspeed + normal_y*vspeed
        var perp_dot = normal_y*hspeed - normal_x*vspeed
        //show_debug_message(normal_x)
        //show_debug_message(hspeed)
        //show_debug_message(normal_y)
        //show_debug_message(vspeed)
        //show_debug_message("-----")
        hspeed = hspeed - dot*normal_x*(1+wall.restitution) - perp_dot*normal_y*wall.frict;
        vspeed = vspeed - dot*normal_y*(1+wall.restitution) + perp_dot*normal_x*wall.frict;
    } else {
        //show_debug_message("no wall")
        //show_debug_message("hspeed = ")
        //show_debug_message(hspeed)
        //show_debug_message("vspeed = ")
        //show_debug_message(vspeed)
        //show_debug_message("x = ")
        //show_debug_message(x)
        //show_debug_message("y = ")
        //show_debug_message(y)
        //show_debug_message("dt = ")
        //show_debug_message(dt)
        //show_debug_message("------------")
        x += hspeed*dt
        y += vspeed*dt
        dt = 0
    }
}
objWall.solid = false

