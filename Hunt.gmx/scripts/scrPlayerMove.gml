ax = gamepad_axis_value(gp, gp_axislh);
ay = gamepad_axis_value(gp, gp_axislv);
var boost = gamepad_button_check_pressed(gp, gp_face1);

var norm = sqrt(ax * ax + ay * ay);

if (norm > amax) {
    ax = amax * ax / norm;
    ay = amax * ay / norm;
}

if (norm < 0.2) {
    ax = -0.05*hspeed;
    ay = -0.05*vspeed;
}

if (boost and boosts > 0) {
    boosts--
    hspeed = (ax / norm) * vmax / 20;
    vspeed = (ay / norm) * vmax / 20;
} else {
    hspeed = hspeed + ax / 2;
    vspeed = vspeed + ay / 2;
    
    hspeed = hspeed - (hspeed * speed * amax / vmax);
    vspeed = vspeed - (vspeed * speed * amax / vmax);
}
    
