objWall.solid = true
move_outside_solid(direction-180, 6)
if floor(speed) > 0 {
    var xold = x
    var yold = y
    move_contact_solid(direction, floor(speed))
    move_outside_solid(direction-180, floor(speed))
    var dr = sqrt(sqr(x-xold) + sqr(y-yold))
    var dt = (1.0 - dr / speed)
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

    var vwall = noone;
    var hwall = noone;
    if (hspeed > 0) {
        vwall = instance_place(x+1, y, objWall)
    } else if (hspeed < 0) {
        vwall = instance_place(x-1, y, objWall)
    }
    if (vspeed > 0) {
        hwall = instance_place(x, y+1, objWall)
    } else if (vspeed < 0) {
        hwall = instance_place(x, y-1, objWall)
    }
    if (vwall != noone) {
        if (hwall != noone) {
            if place_meeting(x+6*sign(vspeed), y-6*sign(hspeed), objWall) and place_meeting(x-6*sign(vspeed), y+6*sign(hspeed), objWall) {
                hspeed = -hspeed*vwall.restitution*(1-hwall.frict)
                vspeed = -vspeed*hwall.restitution*(1-vwall.frict)
                //show_debug_message("in corner")
            } else {
                normal_x = other.x + other.sprite_width/2 - self.x
                normal_y = other.y + other.sprite_height/2 - self.y
                normal_x = normal_x - sign(normal_x)*other.sprite_width/2
                normal_y = normal_y - sign(normal_y)*other.sprite_height/2
                var normal = sqrt(normal_x*normal_x + normal_y*normal_y)
                normal_x = normal_x / normal
                normal_y = normal_y / normal
                normal_time = 3
                //var dot = normal_x*hspeed + normal_y*vspeed
                //hspeed = hspeed - dot*normal_x*(1+BOUNCE_SLOW);
                //vspeed = vspeed - dot*normal_y*(1+BOUNCE_SLOW);
                //normal_x = -hspeed
                //normal_y = -vspeed
                //var normal = sqrt(normal_x*normal_x + normal_y*normal_y)
                //normal_x = normal_x / normal
                //normal_y = normal_y / normal
                //speed = -speed * BOUNCE_SLOW
                //var normal_x = -1/sqrt(2)*sign(hspeed)
                //var normal_y = -1/sqrt(2)*sign(vspeed)
                var dot = normal_x*hspeed + normal_y*vspeed
                var perp_dot = normal_y*hspeed - normal_x*vspeed
                hspeed = hspeed - dot*normal_x*(1+vwall.restitution) - perp_dot*normal_y*hwall.frict;
                vspeed = vspeed - dot*normal_y*(1+hwall.restitution) + perp_dot*normal_x*vwall.frict;
                //show_debug_message(speed)
                //show_debug_message("out corner")
            }
            if floor(speed*dt) > 0 {
                move_contact_solid(direction, floor(speed*dt))
            }
        } else  {
            hspeed = -hspeed * vwall.restitution
            vspeed = vspeed * (1 - vwall.frict)
            //show_debug_message("vertical wall")
            //show_debug_message(vwall.restitution)
            if floor(speed*dt) > 0 {
                move_contact_solid(direction, floor(speed*dt))
                if (vspeed > 0) {
                    var hwall = instance_position(x, y+1, objWall)
                } else if (vspeed < 0) {
                    var hwall = instance_position(x, y-1, objWall)
                }
                if (hwall != noone) {
                    hspeed = hspeed * (1 - hwall.frict)
                    vspeed = -vspeed * hwall.restitution
                    //show_debug_message("horizontal wall")
                    //show_debug_message(hwall.restitution)
                }
            }
        }
    } else if (hwall != noone) {
        hspeed = hspeed * (1 - hwall.frict)
        vspeed = -vspeed * hwall.restitution
        //show_debug_message("horizontal wall")
        //show_debug_message(hwall.restitution)
        if floor(speed*dt) > 0 {
            move_contact_solid(direction, floor(speed*dt))
            if (hspeed > 0) {
                var vwall = instance_position(x+1, y, objWall)
            } else if (hspeed < 0) {
                var vwall = instance_position(x-1, y, objWall)
            }
            if (vwall != noone) {
                hspeed = -hspeed * vwall.restitution
                vspeed = vspeed * (1 - vwall.frict)
                //show_debug_message("vertical wall")
                //show_debug_message(vwall.restitution)
            }
        }
    } else {
        normal_x = other.x + other.sprite_width/2 - self.x
        normal_y = other.y + other.sprite_height/2 - self.y
        normal_x = normal_x - sign(normal_x)*other.sprite_width/2
        normal_y = normal_y - sign(normal_y)*other.sprite_height/2
        var normal = sqrt(normal_x*normal_x + normal_y*normal_y)
        normal_x = normal_x / normal
        normal_y = normal_y / normal
        normal_time = 3
        
        var dot = normal_x*hspeed + normal_y*vspeed
        var perp_dot = normal_y*hspeed - normal_x*vspeed
        hspeed = hspeed - dot*normal_x*(1+other.restitution) - perp_dot*normal_y*other.frict;
        vspeed = vspeed - dot*normal_y*(1+other.restitution) + perp_dot*normal_x*other.frict;
        //show_debug_message("no contact")
        
        if floor(speed*dt) > 0 {
            move_contact_solid(direction, floor(speed*dt))
        }
    }
}
objWall.solid = false

