/// wallDiagClear()

with (objPlayer) {
    if(abs(other.x+other.sprite_width/2+other.y+other.sprite_height/2 - x - y) < other.sprite_width/2 + sqrt(2)*sprite_width/2 + 1 and
        abs(other.x+other.sprite_width/2-other.y-other.sprite_height/2 - x + y) < other.sprite_width/2 + sqrt(2)*sprite_width/2 + 1) {
        return false
    }
}
return true
