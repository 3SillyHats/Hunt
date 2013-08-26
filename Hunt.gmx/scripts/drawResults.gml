
var w = 360;
var h = 660;
var spacing = 100;
var xmargin = 90 + ((w + spacing) * (4 - global.nPlayers))/2;
var ymargin = 90;

var i = 0;
for (j = 0; j < PLAYERS_MAX; j++) {
    if (global.players[j] == noone) { continue; }
    
    // Draw box
    draw_set_color(c_black);
    draw_set_alpha(HUD_BOX_FADE);
    draw_roundrect(
        (w + spacing) * i + xmargin, ymargin,
        w + ((w + spacing) * i) + xmargin, h + ymargin,
        false
    );
    
    // Draw avatar
    draw_set_alpha(1);
    draw_set_color(c_white);
    var aw = sprite_get_width(sprAvatars);
    
    draw_sprite(sprAvatars, global.players[j],
        (w - aw) / 2 + (w + spacing) * i + xmargin,
        60 + ymargin
    );
    
    // Draw icon
    var icon
    switch (global.players[j]) {
        case 0: icon = sprPlayer1; break;
        case 1: icon = sprPlayer2; break;
        case 2: icon = sprPlayer3; break;
        case 3: icon = sprPlayer4; break;
    }
    draw_sprite(icon, 0,
        w  / 2 + (w + spacing) * i + xmargin,
        -60 + h + ymargin
    );
    
    i++;
}

