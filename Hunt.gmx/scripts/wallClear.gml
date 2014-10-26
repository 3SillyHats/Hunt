/// wallClear()

with (objPlayer) {
    if(abs(other.x+other.sprite_width/2 - x) < other.sprite_width/2 + sprite_width/2 + 1 and
       abs(other.y+other.sprite_height/2 - y) < other.sprite_height/2 + sprite_height/2 + 1) {
       return false
    }
}
return true
