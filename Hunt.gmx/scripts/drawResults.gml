
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
    var frame;
    switch (global.players[j]) {
        case objPlayer1: frame = 0; break;
        case objPlayer2: frame = 1; break;
        case objPlayer3: frame = 2; break;
        case objPlayer4: frame = 3; break;
    }
    draw_sprite(sprAvatars, frame,
        (w - aw) / 2 + (w + spacing) * i + xmargin,
        60 + ymargin
    );
    
    // Draw icon
    var icon = object_get_sprite(global.players[j]);
    draw_sprite(icon, 0,
        w  / 2 + (w + spacing) * i + xmargin,
        -60 + h + ymargin
    );
    
    // Draw options
    draw_set_font(fntMain);
    for (k = 0; k < array_length_1d(options); k++) {
        if (k == selected) {
            draw_set_alpha(1);
        } else {
            draw_set_alpha(HUD_OPTION_FADE);
        }
        draw_text(
            room_width/2 - 300,
            room_height - 300 + (70 * k),
            options[k]
        );
    }
    draw_set_alpha(1);
    
    i++;
}

