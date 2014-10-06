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
        if (abs(dx) <= abs(dt*other.hspeed)/2 + r + sprite_width/2 and
            abs(dy) <= abs(dt*other.vspeed)/2 + r + sprite_height/2) {
            
            debug_colour = c_black
            
            // If moving vertically
            if (other.hspeed == 0) {
                show_debug_message("vert")
                var yy = y + (1 - sign(other.vspeed)) * sprite_height/2
                // If left of wall, check for collisions with near left corner
                if ( other.x < x ) {
                    var discriminant = sqr(other.speed*r) - sqr(other.vspeed*(other.x-x))
                    if (discriminant > 0) {
                        var tc = (-other.vspeed*(other.y-yy) - sqrt(discriminant))/sqr(other.speed)
                        if (tc > 0 and tc < dt) {
                            show_debug_message("vlc")
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.hspeed - x
                            normal_y = other.y + tc*other.vspeed - yy
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            debug_colour = c_aqua
                        }
                    } else {
                        debug_colour = c_lime
                    }
                // If right of wall, check for collisions with near right corner
                } else if ( other.x > x + sprite_width ) {
                    var discriminant = sqr(other.speed*r) - sqr(other.vspeed*(other.x-x-sprite_width))
                    if (discriminant > 0) {
                        var tc = (-other.vspeed*(other.y-yy) - sqrt(discriminant))/sqr(other.speed)
                        if (tc > 0 and tc < dt) {
                            show_debug_message("vrc")
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.hspeed - x - sprite_width
                            normal_y = other.y + tc*other.vspeed - yy
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            debug_colour = c_maroon
                        }
                    } else {
                        debug_colour = c_fuchsia
                    }
                // Otherwise, collide with near face
                } else {
                    var tc = (yy - other.y - r*sign(other.vspeed)) / other.vspeed
                    if (tc > -0.1 and tc < dt) {
                        show_debug_message("vf")
                        dt = tc
                        wall = id
                        normal_x = 0
                        normal_y = -sign(other.vspeed)
                        debug_colour = c_gray
                    } else {
                        debug_colour = c_aqua
                    }
                }
            // If moving horizontally
            } else if (other.vspeed == 0) {
                show_debug_message("horiz")
                var xx = x + (1 - sign(other.hspeed)) * sprite_width/2
                // If above wall, check for collisions with near top corner
                if ( other.y < y ) {
                    var discriminant = sqr(other.speed*r) - sqr(other.hspeed*(other.y-y))
                    if (discriminant > 0) {
                        var tc = (-other.hspeed*(other.x-xx) - sqrt(discriminant))/sqr(other.speed)
                        if (tc > 0 and tc < dt) {
                            show_debug_message("htc")
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.hspeed - xx
                            normal_y = other.y + tc*other.vspeed - y
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            debug_colour = c_aqua
                        }
                    } else {
                        debug_colour = c_lime
                    }
                // If below wall, check for collisions with near bottom corner
                } else if ( other.y > y + sprite_height ) {
                    var discriminant = sqr(other.speed*r) - sqr(other.hspeed*(other.y-y-sprite_height))
                    if (discriminant > 0) {
                        var tc = (-other.hspeed*(other.x-xx) - sqrt(discriminant))/sqr(other.speed)
                        if (tc > 0 and tc < dt) {
                            show_debug_message("hbc")
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.hspeed - xx
                            normal_y = other.y + tc*other.vspeed - y - sprite_height
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            debug_colour = c_maroon
                        }
                    } else {
                        debug_colour = c_fuchsia
                    }
                // Otherwise, collide with near face
                } else {
                    var tc = (xx - other.x - r*sign(other.hspeed)) / other.hspeed
                    if (tc > -0.1 and tc < dt) {
                        show_debug_message("hf")
                        dt = tc
                        wall = id
                        normal_x = -sign(other.hspeed)
                        normal_y = 0
                        debug_colour = c_gray
                    } else {
                        debug_colour = c_aqua
                    }
                }
            // If moving diagonally
            } else {
                // Check collisions with near faces only
                var xx = x + (1 - sign(other.hspeed)) * sprite_width/2
                var yy = y + (1 - sign(other.vspeed)) * sprite_height/2
            
                var tx = (xx - other.x - r*sign(other.hspeed)) / other.hspeed
                var ty = (yy - other.y - r*sign(other.vspeed)) / other.vspeed
            
                // If moving towards vertical face
                if (tx > ty) {
                    var yx = other.y + tx*other.vspeed
                    // If falling short, must eventually hit near corner
                    if (sign(other.vspeed)*yx < sign(other.vspeed)*yy) {
                        var tc = (-other.hspeed*(other.x-xx) - other.vspeed*(other.y-yy) - sqrt(sqr(other.speed*r) - sqr(other.hspeed*(other.y-yy) - other.vspeed*(other.x-xx))))/sqr(other.speed)
                        if (tc > 0 and tc < dt) {
                            show_debug_message("xnc")
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.hspeed - xx
                            normal_y = other.y + tc*other.vspeed - yy
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            debug_colour = c_purple
                        }
                    // If overshooting, check for collision with far corner
                    } else if (sign(other.vspeed)*yx > sign(other.vspeed)*yy + sprite_height) {
                        var discriminant = sqr(other.speed*r) - sqr(other.hspeed*(other.y-yy-sign(other.vspeed)*sprite_height) - other.vspeed*(other.x-xx))
                        if (discriminant > 0) {
                            var tc = (-other.hspeed*(other.x-xx) - other.vspeed*(other.y-yy-sign(other.vspeed)*sprite_height) - sqrt(discriminant))/sqr(other.speed)
                            if (tc > 0 and tc < dt) {
                                show_debug_message("xfc")
                                dt = tc
                                wall = id
                                normal_x = other.x + tc*other.hspeed - xx
                                normal_y = other.y + tc*other.vspeed - yy - sign(other.vspeed)*sprite_height
                                var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                                normal_x = normal_x/norm
                                normal_y = normal_y/norm
                                debug_colour = c_gray
                            } else {
                                debug_colour = c_blue
                            }
                        } else {
                            debug_colour = c_lime
                        }
                    // Otherwise, collide with vertical face
                    } else if (tx > -0.1 and tx < dt) {
                        show_debug_message("xf")
                        dt = tx
                        wall = id
                        normal_x = -sign(other.hspeed)
                        normal_y = 0
                        debug_colour = c_gray
                    } else {
                        debug_colour = c_green
                    }
                // Otherwise, moving towards horizontal face
                } else {
                    var xy = other.x + ty*other.hspeed
                    // If falling short, must eventually hit near corner
                    if (sign(other.hspeed)*xy < sign(other.hspeed)*xx) {
                        var tc = (-other.hspeed*(other.x-xx) - other.vspeed*(other.y-yy) - sqrt(sqr(other.speed*r) - sqr(other.hspeed*(other.y-yy) - other.vspeed*(other.x-xx))))/sqr(other.speed)
                        if (tc > 0 and tc < dt) {
                            show_debug_message("ync")
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.hspeed - xx
                            normal_y = other.y + tc*other.vspeed - yy
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            debug_colour = c_yellow
                        }
                    // If overshooting, check for collision with far corner
                    } else if (sign(other.hspeed)*xy > sign(other.hspeed)*xx + sprite_width) {
                        var discriminant = sqr(other.speed*r) - sqr(other.hspeed*(other.y-yy) - other.vspeed*(other.x-xx-sign(other.hspeed)*sprite_width))
                        if (discriminant > 0) {
                            var tc = (-other.hspeed*(other.x-xx-sign(other.hspeed)*sprite_width) - other.vspeed*(other.y-yy) - sqrt(discriminant))/sqr(other.speed)
                            if (tc > 0 and tc < dt) {
                                show_debug_message("yfc")
                                dt = tc
                                wall = id
                                normal_x = other.x + tc*other.hspeed - xx - sign(other.hspeed)*sprite_height
                                normal_y = other.y + tc*other.vspeed - yy
                                var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                                normal_x = normal_x/norm
                                normal_y = normal_y/norm
                                debug_colour = c_gray
                            } else {
                                debug_colour = c_orange
                            }
                        } else {
                            debug_colour = c_lime
                        }
                    // Otherwise, collide with horizontal face
                    } else if (ty > -0.1 and ty < dt) {
                        show_debug_message("yf")
                        dt = ty
                        wall = id
                        normal_x = 0
                        normal_y = -sign(other.vspeed)
                        debug_colour = c_gray
                    } else if (ty < 0) {
                        debug_colour = c_blue
                    } else {
                        debug_colour = c_red
                    }
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

