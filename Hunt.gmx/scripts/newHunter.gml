/// newHunter()

for(i=0; i<global.nPlayers; i++) {
    hunters[i].isNext = false
    hunters[i].isHunter = false
}

nextHunter++;
if(nextHunter >= global.nPlayers) {
    shuffleHunters(not firstRound);
    nextHunter = 0;
}

hunter = next
next = hunters[nextHunter]

next.isNext = true;
if ( hunter != noone ) {
    huntCount += 1
    hunter.isHunter = true;
    
    var maxKills = 0
    var minKills = WIN_THRESHOLD
    
    var maxDeaths = 0
    var minDeaths = WIN_THRESHOLD*PLAYERS_MAX
    
    with (objPlayer) {
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
    
    with(hunter) {
        var minBoosts = 0
        if (maxKills - minKills >= HANDICAP_KILLS_THRESHOLD and global.kills[controller] == maxKills) {
            minBoosts = HANDICAP_BOOSTS_MIN;
        //} else if (maxDeaths - minDeaths >= HANDICAP_DEATHS_THRESHOLD and global.deaths[controller] == maxDeaths) {
        //    minBoosts = HANDICAP_BOOSTS_MAX;
        } else {
            minBoosts = HUNTER_BOOSTS;
        }
        
        if (boosts < minBoosts) {
            boosts = minBoosts;
        }
    }
}

if (not firstRound) {
    audio_play_sound(sndMusic, 100, false);
    hunt_remaining = hunt_remaining + HUNT_TIME * 1000000;
}
