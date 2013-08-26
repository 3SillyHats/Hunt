for(i=0; i<global.nPlayers; i++) {
    global.players[i].isHunter = false
}

hunter++;
if(hunter >= global.nPlayers) {
    shuffleHunters(not firstRound);
    hunter = 0;
    firstRound = false;
}

hunters[hunter].isHunter = true;
hunters[hunter].boosts = 3;

audio_play_music(sndMusic, false);

alarm[0] = HUNT_TIME * room_speed;

