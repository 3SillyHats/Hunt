ax = gamepad_axis_value(gp,gp_axislh)/2;
ay = gamepad_axis_value(gp,gp_axislv)/2;

var norm = sqrt(ax * ax + ay * ay);

if (norm > amax) {
    ax = amax * ax / norm;
    ay = amax * ay / norm;
}

if (norm < 0.2) {
    ax = -0.05*hspeed;
    ay = -0.05*vspeed;
}

hspeed = hspeed + ax;
vspeed = vspeed + ay;

hspeed = hspeed - (hspeed * speed * amax / vmax);
vspeed = vspeed - (vspeed * speed * amax / vmax);

