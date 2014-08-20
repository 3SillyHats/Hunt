for(i=0; i<global.nPlayers; i++) {
    hunters[i].isHunter = false
}


if firstRound {
    global.paused = false
}

hunter++;
if(hunter >= global.nPlayers) {
    shuffleHunters(not firstRound);
    hunter = 0;
    firstRound = false;
}

hunters[hunter].isHunter = true;
if hunters[hunter].boosts < 1 {
    hunters[hunter].boosts = 1;
}

audio_play_sound(sndMusic, 100, false);

hunt_remaining = hunt_remaining + HUNT_TIME * 1000000;

