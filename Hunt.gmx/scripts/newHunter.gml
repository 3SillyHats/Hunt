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
    hunter.isHunter = true;
    if hunter.boosts < 1 {
        hunter.boosts = 1;
    }
}

if (not firstRound) {
    audio_play_sound(sndMusic, 100, false);
    hunt_remaining = hunt_remaining + HUNT_TIME * 1000000;
}

