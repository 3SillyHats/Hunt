if (isHunter) {
    boosts = HUNTER_BOOSTS;
} else {
    boosts = SPAWN_BOOSTS;
}
if (invulnerability < INVULNERABLE_SPAWN_TIME) {
    invulnerability = INVULNERABLE_SPAWN_TIME;
}
dodged = INVULNERABLE_SPAWN_TIME;

speed = 0;
xvel = 0;
yvel = 0;
x = xstart;
y = ystart;
dead = false

