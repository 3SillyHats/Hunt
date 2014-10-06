x = oldx
y = oldy

var t = 1.0
var iter = 0
var r = other.sprite_width/2
while (t*speed > 0.1 and iter < 9) {
    iter = iter + 1
    var xold = x
    var yold = y
    
    var dt = t
    var wall = noone
    var normal_x = 0
    var normal_y = 0
    
    // Find nearest colliding rectangular wall
    with(objWallRect) {
        var dx = (x + sprite_width/2) - (other.x + t*other.hspeed/2)
        var dy = (y + sprite_height/2) - (other.y + t*other.vspeed/2)
        
        // Check that wall is close enough for collision to occur
        if (abs(dx) <= abs(dt*other.hspeed)/2 + r + sprite_width/2 + 50 and
            abs(dy) <= abs(dt*other.vspeed)/2 + r + sprite_height/2 + 50) {
            
            debug_colour = c_black
            
            // Check collisions with near faces only
            var xx = x + (1 - sign(other.hspeed)) * sprite_width/2
            var yy = y + (1 - sign(other.vspeed)) * sprite_height/2
            
            var tx
            var ty
            if (other.hspeed == 0) {
                tx = -1
            } else {
                tx = (xx - other.x - r*sign(other.hspeed)) / other.hspeed
            }
            if (other.vspeed == 0) {
                ty = -1
            } else {
                ty = (yy - other.y - r*sign(other.vspeed)) / other.vspeed
            }
            
            // If moving towards vertical face
            if (tx > ty) {
                var yx = other.y + tx*other.vspeed
                if (yx >= y and yx <= y + sprite_height) {
                    if(tx > -0.1 and tx < dt) {
                    show_debug_message("xf")
                    dt = tx
                    wall = id
                    normal_x = -sign(other.hspeed)
                    normal_y = 0
                    debug_colour = c_gray
                    } else {
                        debug_colour = c_green
                    }
                } else {
                    debug_colour = c_yellow
                }
            // Otherwise, moving towards horizontal face
            } else {
                var xy = other.x + ty*other.hspeed
                if (xy >= x and xy <= x + sprite_width) {
                    if (ty > -0.1 and ty < dt) {
                        show_debug_message("yf")
                        dt = ty
                        wall = id
                        normal_x = 0
                        normal_y = -sign(other.vspeed)
                        debug_colour = c_gray
                    } else if (ty < 0) {
                        debug_colour = c_blue
                    } else {
                        show_debug_message(ty)
                        debug_colour = c_red
                    }
                } else {
                    debug_colour = c_orange
                }
            }
        } else {
            debug_colour = c_white
        }
    }
    
    if (dt > 0) {
        t -= dt
        x = x + dt*hspeed
        y = y + dt*vspeed
    }
    
    if (wall != noone) {
        var dot = normal_x*hspeed + normal_y*vspeed
        var perp_dot = normal_y*hspeed - normal_x*vspeed
        //show_debug_message("collide")
        //show_debug_message(dt)
        //show_debug_message(normal_x)
        //show_debug_message(normal_y)
        hspeed = hspeed - dot*normal_x*(1+wall.restitution) - perp_dot*normal_y*wall.frict;
        vspeed = vspeed - dot*normal_y*(1+wall.restitution) + perp_dot*normal_x*wall.frict;
    }
}

oldx = x
oldy = y

