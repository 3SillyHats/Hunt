if (isHunter) {
    boosts = HUNTER_BOOSTS;
} else {
    boosts = SPAWN_BOOSTS;
}
if (invulnerability < INVULNERABLE_SPAWN_TIME) {
    invulnerability = INVULNERABLE_SPAWN_TIME;
}
dodged = INVULNERABLE_SPAWN_TIME;

if (argument0) {
    var hunter = objTimer.hunter
    var nearest = instance_nearest(hunter.x, hunter.y, objSpawn)
    var spawns = ds_list_create()
    with(objSpawn) {
        if (id != nearest) {
            ds_list_add(spawns, id)
        }
    }

    ds_list_shuffle(spawns)
    var target = ds_list_find_value(spawns, 0)
    ds_list_destroy(spawns)
    
    x = target.x;
    y = target.y;
}

speed = 0;
xvel = 0;
yvel = 0;
dead = false

