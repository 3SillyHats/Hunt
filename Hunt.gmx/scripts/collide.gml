/// collide()
var t = 1.0
var iter = 0
var oldwall = noone
var r = other.sprite_width/2
while (sqr(t)*(sqr(xvel)+sqr(yvel)) > 0.01 and iter < 9) {
    iter = iter + 1
    var xold = x
    var yold = y
    
    var dt = t
    var wall = noone
    var normal_x = 0
    var normal_y = 0
    
    // Find nearest colliding rectangular wall
    with(objWallRect) {
        var dx = (x + sprite_width/2) - (other.x + t*other.xvel/2)
        var dy = (y + sprite_height/2) - (other.y + t*other.yvel/2)
        
        // Check that wall is close enough for collision to occur
        if (id != oldwall and
            not passable and
            abs(dx) <= abs(dt*other.xvel)/2 + r + sprite_width/2 and
            abs(dy) <= abs(dt*other.yvel)/2 + r + sprite_height/2 and
            (self.collidesHunter or ((not other.isHunter) and (not self.playerInside[other.controller])))) {
            
            debug_colour = c_black
            
            // If moving vertically
            if (other.xvel == 0) {
                //show_debug_message("vert")
                var yy = y + (1 - sign(other.yvel)) * sprite_height/2
                // If left of wall, check for collisions with near left corner
                if ( other.x < x ) {
                    var discriminant = (sqr(other.xvel)+sqr(other.yvel))*sqr(r) - sqr(other.yvel*(other.x-x))
                    if (discriminant > 0) {
                        var tc = (-other.yvel*(other.y-yy) - sqrt(discriminant))/(sqr(other.xvel)+sqr(other.yvel))
                        if (tc > -0.001 and tc < dt) {
                            //show_debug_message("vlc")
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.xvel - x
                            normal_y = other.y + tc*other.yvel - yy
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
                    var discriminant = (sqr(other.xvel)+sqr(other.yvel))*sqr(r) - sqr(other.yvel*(other.x-x-sprite_width))
                    if (discriminant > 0) {
                        var tc = (-other.yvel*(other.y-yy) - sqrt(discriminant))/(sqr(other.xvel)+sqr(other.yvel))
                        if (tc > -0.001 and tc < dt) {
                            //show_debug_message("vrc")
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.xvel - x - sprite_width
                            normal_y = other.y + tc*other.yvel - yy
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
                    var tc = (yy - other.y - r*sign(other.yvel)) / other.yvel
                    if (tc > -0.1 and tc < dt) {
                        //show_debug_message("vf")
                        dt = tc
                        wall = id
                        normal_x = 0
                        normal_y = -sign(other.yvel)
                        debug_colour = c_gray
                    } else {
                        debug_colour = c_aqua
                    }
                }
            // If moving horizontally
            } else if (other.yvel == 0) {
                //show_debug_message("horiz")
                var xx = x + (1 - sign(other.xvel)) * sprite_width/2
                // If above wall, check for collisions with near top corner
                if ( other.y < y ) {
                    var discriminant = (sqr(other.xvel)+sqr(other.yvel))*sqr(r) - sqr(other.xvel*(other.y-y))
                    if (discriminant > 0) {
                        var tc = (-other.xvel*(other.x-xx) - sqrt(discriminant))/(sqr(other.xvel)+sqr(other.yvel))
                        if (tc > -0.001 and tc < dt) {
                            //show_debug_message("htc")
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.xvel - xx
                            normal_y = other.y + tc*other.yvel - y
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
                    var discriminant = (sqr(other.xvel)+sqr(other.yvel))*sqr(r) - sqr(other.xvel*(other.y-y-sprite_height))
                    if (discriminant > 0) {
                        var tc = (-other.xvel*(other.x-xx) - sqrt(discriminant))/(sqr(other.xvel)+sqr(other.yvel))
                        if (tc > -0.001 and tc < dt) {
                            //show_debug_message("hbc")
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.xvel - xx
                            normal_y = other.y + tc*other.yvel - y - sprite_height
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
                    var tc = (xx - other.x - r*sign(other.xvel)) / other.xvel
                    if (tc > -0.1 and tc < dt) {
                        //show_debug_message("hf")
                        dt = tc
                        wall = id
                        normal_x = -sign(other.xvel)
                        normal_y = 0
                        debug_colour = c_gray
                    } else {
                        debug_colour = c_aqua
                    }
                }
            // If moving diagonally
            } else {
                // Check collisions with near faces only
                var xx = x + (1 - sign(other.xvel)) * sprite_width/2
                var yy = y + (1 - sign(other.yvel)) * sprite_height/2
            
                var tx = (xx - other.x - r*sign(other.xvel)) / other.xvel
                var ty = (yy - other.y - r*sign(other.yvel)) / other.yvel
            
                // If moving towards vertical face
                if (tx > ty) {
                    var yx = other.y + tx*other.yvel
                    // If falling short, must eventually hit near corner
                    if (sign(other.yvel)*yx < sign(other.yvel)*yy) {
                        var tc = (-other.xvel*(other.x-xx) - other.yvel*(other.y-yy) - sqrt((sqr(other.xvel)+sqr(other.yvel))*sqr(r) - sqr(other.xvel*(other.y-yy) - other.yvel*(other.x-xx))))/(sqr(other.xvel)+sqr(other.yvel))
                        if (tc > -0.001 and tc < dt) {
                            //show_debug_message("xnc")
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.xvel - xx
                            normal_y = other.y + tc*other.yvel - yy
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            debug_colour = c_purple
                        }
                    // If overshooting, check for collision with far corner
                    } else if (sign(other.yvel)*yx > sign(other.yvel)*yy + sprite_height) {
                        var discriminant = (sqr(other.xvel)+sqr(other.yvel))*sqr(r) - sqr(other.xvel*(other.y-yy-sign(other.yvel)*sprite_height) - other.yvel*(other.x-xx))
                        if (discriminant > 0) {
                            var tc = (-other.xvel*(other.x-xx) - other.yvel*(other.y-yy-sign(other.yvel)*sprite_height) - sqrt(discriminant))/(sqr(other.xvel)+sqr(other.yvel))
                            if (tc > -0.001 and tc < dt) {
                                //show_debug_message("xfc")
                                dt = tc
                                wall = id
                                normal_x = other.x + tc*other.xvel - xx
                                normal_y = other.y + tc*other.yvel - yy - sign(other.yvel)*sprite_height
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
                        //show_debug_message("xf")
                        dt = tx
                        wall = id
                        normal_x = -sign(other.xvel)
                        normal_y = 0
                        debug_colour = c_gray
                    } else {
                        debug_colour = c_green
                    }
                // Otherwise, moving towards horizontal face
                } else {
                    var xy = other.x + ty*other.xvel
                    // If falling short, must eventually hit near corner
                    if (sign(other.xvel)*xy < sign(other.xvel)*xx) {
                        var tc = (-other.xvel*(other.x-xx) - other.yvel*(other.y-yy) - sqrt((sqr(other.xvel)+sqr(other.yvel))*sqr(r) - sqr(other.xvel*(other.y-yy) - other.yvel*(other.x-xx))))/(sqr(other.xvel)+sqr(other.yvel))
                        if (tc > -0.001 and tc < dt) {
                            //show_debug_message("ync")
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.xvel - xx
                            normal_y = other.y + tc*other.yvel - yy
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            debug_colour = c_yellow
                        }
                    // If overshooting, check for collision with far corner
                    } else if (sign(other.xvel)*xy > sign(other.xvel)*xx + sprite_width) {
                        var discriminant = (sqr(other.xvel)+sqr(other.yvel))*sqr(r) - sqr(other.xvel*(other.y-yy) - other.yvel*(other.x-xx-sign(other.xvel)*sprite_width))
                        if (discriminant > 0) {
                            var tc = (-other.xvel*(other.x-xx-sign(other.xvel)*sprite_width) - other.yvel*(other.y-yy) - sqrt(discriminant))/(sqr(other.xvel)+sqr(other.yvel))
                            if (tc > -0.001 and tc < dt) {
                                //show_debug_message("yfc")
                                dt = tc
                                wall = id
                                normal_x = other.x + tc*other.xvel - xx - sign(other.xvel)*sprite_height
                                normal_y = other.y + tc*other.yvel - yy
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
                        //show_debug_message("yf")
                        dt = ty
                        wall = id
                        normal_x = 0
                        normal_y = -sign(other.yvel)
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
    
    // Find nearest colliding diagonal wall
    with(objWallDiag) {
        var dx = (x + sprite_width/2) - (other.x + t*other.xvel/2)
        var dy = (y + sprite_height/2) - (other.y + t*other.yvel/2)
        
        // Check that wall is close enough for collision to occur
        if (id != oldwall and
            not passable and
            abs(dx) <= abs(dt*other.xvel)/2 + r + sprite_width/2 and
            abs(dy) <= abs(dt*other.yvel)/2 + r + sprite_height/2 and
            (self.collidesHunter or ((not other.isHunter) and (not self.playerInside[other.controller])))) {
            
            debug_colour = c_black
            
            // If moving down/right
            if (other.xvel == other.yvel) {
                //show_debug_message("dr")
                // x + y along front face
                var xpy = x + y + (2 - sign(other.xvel)) * sprite_width / 2
                // If left/below wall, check for collisions with near left/lower corner
                if ( other.x - other.y < x - y - sprite_height/2 ) {
                    var discriminant = sqr(other.xvel)*(2*sqr(r) - sqr(other.y - other.x + x - y - sprite_height / 2))
                    if (discriminant > 0) {
                        var tc = (-other.xvel*(other.x+other.y - xpy) - sqrt(discriminant))/(2*sqr(other.xvel))
                        if (tc > -0.001 and tc < dt) {
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.xvel - (xpy + x - y - sprite_height/2) / 2
                            normal_y = other.y + tc*other.yvel - (xpy - x + y + sprite_height/2) / 2
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            //debug_colour = c_navy
                        }
                    } else {
                        //debug_colour = c_lime
                    }
                // If right/above wall, check for collisions with near right/upper corner
                } else if ( other.x - other.y > x + sprite_width/2 - y ) {
                    var discriminant = sqr(other.xvel)*(2*sqr(r) - sqr(other.y - other.x + x + sprite_width/2 - y))
                    if (discriminant > 0) {
                        var tc = (-other.xvel*(other.x+other.y - xpy) - sqrt(discriminant))/(2*sqr(other.xvel))
                        if (tc > -0.001 and tc < dt) {
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.xvel - (xpy + x + sprite_width/2 - y) / 2
                            normal_y = other.y + tc*other.yvel - (xpy - x - sprite_width/2 + y) / 2
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            //debug_colour = c_maroon
                        }
                    } else {
                        //debug_colour = c_fuchsia
                    }
                // Otherwise, collide with near face
                } else {
                    var tc = (xpy - other.x - other.y - sqrt(2)*r*sign(other.xvel)) / (2*other.xvel)
                    if (tc > -0.1 and tc < dt) {
                        dt = tc
                        wall = id
                        normal_x = -sign(other.xvel)/sqrt(2)
                        normal_y = -sign(other.yvel)/sqrt(2)
                        debug_colour = c_gray
                    } else {
                        //debug_colour = c_aqua
                    }
                }
            // If moving down/left
            } else if (other.yvel + other.xvel == 0) {
                //show_debug_message("dl")
                // x - y along front face
                var xmy = x - y - sign(other.xvel) * sprite_width / 2
                // If left/above wall, check for collisions with near left/top corner
                if ( other.x + other.y < x + y + sprite_width / 2 ) {
                    var discriminant = sqr(other.xvel)*(2*sqr(r) - sqr(other.x + other.y - x - y - sprite_width / 2))
                    if (discriminant > 0) {
                        var tc = (-other.xvel*(other.x - other.y - xmy) - sqrt(discriminant))/(2*sqr(other.xvel))
                        if (tc > -0.001 and tc < dt) {
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.xvel - (xmy + x + y + sprite_width / 2) / 2
                            normal_y = other.y + tc*other.yvel + (xmy - x - y - sprite_width / 2) / 2
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            //debug_colour = c_navy
                        }
                    } else {
                        //debug_colour = c_lime
                    }
                // If right/below wall, check for collisions with near right/bottom corner
                } else if ( other.x + other.y > x + y + 3*sprite_height/2 ) {
                    var discriminant = sqr(other.xvel)*(2*sqr(r) - sqr(other.x + other.y - x - y - 3*sprite_height/2))
                    if (discriminant > 0) {
                        var tc = (-other.xvel*(other.x  - other.y - xmy) - sqrt(discriminant))/(2*sqr(other.xvel))
                        if (tc > -0.001 and tc < dt) {
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.xvel - (xmy + x + y + 3 * sprite_width / 2) / 2
                            normal_y = other.y + tc*other.yvel + (xmy - x - y - 3 * sprite_width / 2) / 2
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            //debug_colour = c_maroon
                        }
                    } else {
                        //debug_colour = c_fuchsia
                    }
                // Otherwise, collide with near face
                } else {
                    var tc = (xmy - other.x + other.y - sqrt(2)*r*sign(other.xvel)) / (2*other.xvel)
                    if (tc > -0.1 and tc < dt) {
                        dt = tc
                        wall = id
                        normal_x = -sign(other.xvel)/sqrt(2)
                        normal_y = -sign(other.yvel)/sqrt(2)
                        debug_colour = c_gray
                    } else {
                        //debug_colour = c_aqua
                    }
                }
            // If moving diagonally
            } else {
                // Check collisions with near faces only
                var xpy = x + y + (2 - sign(other.xvel + other.yvel)) * sprite_width/2
                var xmy = x - y - sign(other.xvel - other.yvel) * sprite_width/2
            
                var txpy = (xpy - other.x - other.y - sqrt(2)*r*sign(other.xvel + other.yvel)) / (other.xvel + other.yvel)
                var txmy = (xmy - other.x + other.y - sqrt(2)*r*sign(other.xvel - other.yvel)) / (other.xvel - other.yvel)
            
                // If moving towards upper-left/lower-right face
                if (txpy > txmy) {
                    var xmyp = other.x - other.y + txpy*(other.xvel - other.yvel)
                    // If falling short, must eventually hit near corner
                    if (sign(other.xvel - other.yvel)*xmyp < sign(other.xvel - other.yvel)*xmy) {
                        var discriminant = 4*(sqr(other.xvel)+sqr(other.yvel))*sqr(r) - sqr((other.xvel+other.yvel)*(other.x-other.y-xmy) - (other.xvel-other.yvel)*(other.x+other.y-xpy))
                        var tc = (-(other.xvel+other.yvel)*(other.x+other.y-xpy) - (other.xvel-other.yvel)*(other.x-other.y-xmy) - sqrt(discriminant))/(2*(sqr(other.xvel)+sqr(other.yvel)))
                        if (tc > -0.001 and tc < dt) {
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.xvel - (xpy + xmy)/2
                            normal_y = other.y + tc*other.yvel - (xpy - xmy)/2
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            debug_colour = c_purple
                        }
                    // If overshooting, check for collision with far corner
                    } else if (sign(other.xvel - other.yvel)*xmyp > sign(other.xvel - other.yvel)*xmy + sprite_height) {
                        var discriminant = 4*(sqr(other.xvel)+sqr(other.yvel))*sqr(r) - sqr((other.xvel+other.yvel)*(other.x-other.y-xmy-sign(other.xvel-other.yvel)*sprite_height) - (other.xvel-other.yvel)*(other.x+other.y-xpy))
                        if (discriminant > 0) {
                            var tc = (-(other.xvel+other.yvel)*(other.x+other.y-xpy) - (other.xvel-other.yvel)*(other.x-other.y-xmy-sign(other.xvel-other.yvel)*sprite_height) - sqrt(discriminant))/(2*(sqr(other.xvel)+sqr(other.yvel)))
                            if (tc > -0.001 and tc < dt) {
                                dt = tc
                                wall = id
                                normal_x = other.x + tc*other.xvel - (xpy + xmy + sign(other.xvel-other.yvel)*sprite_height)/2
                                normal_y = other.y + tc*other.yvel - (xpy - xmy - sign(other.xvel-other.yvel)*sprite_height)/2
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
                    // Otherwise, collide with upper-left/lower-right face
                    } else if (txpy > -0.1 and txpy < dt) {
                        dt = txpy
                        wall = id
                        normal_x = -sign(other.xvel+other.yvel)/sqrt(2)
                        normal_y = -sign(other.xvel+other.yvel)/sqrt(2)
                        debug_colour = c_gray
                    } else if txpy < 0 {
                        debug_colour = c_blue
                    } else {
                        debug_colour = c_green
                    }
                // Otherwise, moving towards upper-right/lower-left face
                } else {
                    var xpyp = other.x + other.y + txmy*(other.xvel + other.yvel)
                    // If falling short, must eventually hit near corner
                    if (sign(other.xvel + other.yvel)*xpyp < sign(other.xvel + other.yvel)*xpy) {
                        var discriminant = 4*(sqr(other.xvel)+sqr(other.yvel))*sqr(r) - sqr((other.xvel+other.yvel)*(other.x-other.y-xmy) - (other.xvel-other.yvel)*(other.x+other.y-xpy))
                        var tc = (-(other.xvel+other.yvel)*(other.x+other.y-xpy) - (other.xvel-other.yvel)*(other.x-other.y-xmy) - sqrt(discriminant))/(2*(sqr(other.xvel)+sqr(other.yvel)))
                        if (tc > -0.001 and tc < dt) {
                            dt = tc
                            wall = id
                            normal_x = other.x + tc*other.xvel - (xpy + xmy)/2
                            normal_y = other.y + tc*other.yvel - (xpy - xmy)/2
                            var norm = sqrt(sqr(normal_x) + sqr(normal_y))
                            normal_x = normal_x/norm
                            normal_y = normal_y/norm
                            debug_colour = c_gray
                        } else {
                            debug_colour = c_yellow
                        }
                    // If overshooting, check for collision with far corner
                    } else if (sign(other.xvel + other.yvel)*xpyp > sign(other.xvel + other.yvel)*xpy + sprite_width) {
                        var discriminant = 4*(sqr(other.xvel)+sqr(other.yvel))*sqr(r) - sqr((other.xvel+other.yvel)*(other.x-other.y-xmy) - (other.xvel-other.yvel)*(other.x+other.y-xpy-sign(other.xvel+other.yvel)*sprite_height))
                        if (discriminant > 0) {
                            var tc = (-(other.xvel+other.yvel)*(other.x+other.y-xpy-sign(other.xvel+other.yvel)*sprite_height) - (other.xvel-other.yvel)*(other.x-other.y-xmy) - sqrt(discriminant))/(2*(sqr(other.xvel)+sqr(other.yvel)))
                            if (tc > -0.001 and tc < dt) {
                                dt = tc
                                wall = id
                                normal_x = other.x + tc*other.xvel - (xpy + sign(other.xvel+other.yvel)*sprite_height + xmy)/2
                                normal_y = other.y + tc*other.yvel - (xpy + sign(other.xvel+other.yvel)*sprite_height - xmy)/2
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
                    } else if (txmy > -0.1 and txmy < dt) {
                        dt = txmy
                        wall = id
                        normal_x = -sign(other.xvel-other.yvel)/sqrt(2)
                        normal_y = sign(other.xvel-other.yvel)/sqrt(2)
                        debug_colour = c_gray
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
        x = x + dt*xvel
        y = y + dt*yvel
    }
    
    if (x < 0) {
        x = x + room_width
    } else if (x > room_width) {
        x = x - room_width
    }

    if (y < 0) {
        y = y + room_height
    } else if (y > room_height) {
        y = y - room_height
    }
    
    if (wall != noone) {
        var dot = normal_x*xvel + normal_y*yvel
        self.normal_x = normal_x
        self.normal_y = normal_y
        if(wall.breakable and abs(dot) > 1.5*SPEED_MAX) {
            breakWall(wall)
            dot = sign(dot)*SPEED_MAX/2
            xvel = xvel - dot*normal_x;
            yvel = yvel - dot*normal_y;
        } else {
            var perp_dot = normal_y*xvel - normal_x*yvel
            xvel = xvel - dot*normal_x*(1+wall.restitution) - perp_dot*normal_y*wall.frict;
            yvel = yvel - dot*normal_y*(1+wall.restitution) + perp_dot*normal_x*wall.frict;
        }
        collided = true
        global.bounces[controller]++;
    }
    
    oldwall = wall
}
