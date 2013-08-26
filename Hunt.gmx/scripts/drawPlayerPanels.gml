
var w = 360;
var h = 720;
var spacing = 100;
var xmargin = 90 + ((w + spacing) * (4 - gamepads))/2;
var ymargin = 90;

for (i = 0; i < gamepads; i++) {
    // Draw box
    draw_set_color(c_black);
    draw_set_alpha(HUD_BOX_FADE);
    draw_roundrect(
        (w + spacing) * i + xmargin, ymargin,
        w + ((w + spacing) * i) + xmargin, h + ymargin,
        false
    );
    
    if (selected[i]) {
        draw_set_alpha(1);
    } else {
        draw_set_alpha(HUD_AVATAR_FADE);
    }
    
    // Draw avatar
    draw_set_color(c_white);
    var aw = sprite_get_width(sprAvatars);
    
    draw_sprite(sprAvatars, global.players[i],
        (w - aw) / 2 + (w + spacing) * i + xmargin,
        30 + ymargin
    );
    
    // Draw icon
    var icon
    switch (global.players[i]) {
        case 0: icon = sprPlayer1; break;
        case 1: icon = sprPlayer2; break;
        case 2: icon = sprPlayer3; break;
        case 3: icon = sprPlayer4; break;
    }
    draw_sprite(icon, 0,
        w  / 2 + (w + spacing) * i + xmargin,
        640 + ymargin
    );
    draw_set_alpha(1);
    
    // Draw arrows
    if (not selected[i]) {
        draw_sprite_ext(sprArrow, 0,
            w  / 2 + (w + spacing) * i + xmargin,
            640 + ymargin, 1, 1,
            0,
            c_white, 1
        );
        draw_sprite_ext(sprArrow, 0,
            w  / 2 + (w + spacing) * i + xmargin,
            640 + ymargin, 1, 1,
            180,
            c_white, 1
        );
    }
}

