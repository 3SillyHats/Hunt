for(i=0; i<global.nPlayers; i++) {
    hunters[i].isHunter = false
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

audio_play_music(sndMusic, false);

alarm[0] = HUNT_TIME * room_speed;

