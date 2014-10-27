/// spawn(randomise_location)

var maxKills = 0
var minKills = WIN_THRESHOLD

var maxDeaths = 0
var minDeaths = WIN_THRESHOLD*PLAYERS_MAX

with (objPlayer) {
    if(controller >= 0) {
        if(global.kills[controller] > maxKills) {
            maxKills = global.kills[controller]
        }
        if(global.kills[controller] < minKills) {
            minKills = global.kills[controller]
        }
        if(global.deaths[controller] > maxDeaths) {
            maxDeaths = global.deaths[controller]
        }
        if(global.deaths[controller] < minDeaths) {
            minDeaths = global.deaths[controller]
        }
    }
}

if (isHunter) {
    boosts = HUNTER_BOOSTS;
} else if (maxKills - minKills >= HANDICAP_KILLS_THRESHOLD and global.kills[controller] == maxKills) {
    boosts = HANDICAP_BOOSTS_MIN;
} else if (maxDeaths - minDeaths >= HANDICAP_DEATHS_THRESHOLD and global.deaths[controller] == maxDeaths) {
    boosts = HANDICAP_BOOSTS_MAX;
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

