
var w = 360;
var h = 660;
var spacing = 100;
var xmargin = 90;
var ymargin = 90;

for (i = 0; i < PLAYERS_MAX; i++) {
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
        60 + ymargin
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
        -60 + h + ymargin
    );
    draw_set_alpha(1);
    
    // Draw arrows
    if (not selected[i]) {
        draw_sprite_ext(sprArrow, 0,
            w  / 2 + (w + spacing) * i + xmargin,
            -60 + h + ymargin, 1, 1,
            0,
            c_white, 1
        );
        draw_sprite_ext(sprArrow, 0,
            w  / 2 + (w + spacing) * i + xmargin,
            -60 + h + ymargin, 1, 1,
            180,
            c_white, 1
        );
    }
    
    // Draw controller
    var controller;
    if gamepad_is_connected(i) {
        switch (gamepad_get_description(i)) {
            case "Xbox 360 Controller (XInput STANDARD GAMEPAD)": controller = 2; break;
            case "PLAYSTATION(R)3 Controller": controller = 3; break;
            default: controller = 1; break;
        }
    } else {
        controller = 0;
    }
    draw_sprite(sprController, controller,
        w  / 2 + (w + spacing) * i + xmargin,
        60 + h + ymargin
    );
}

