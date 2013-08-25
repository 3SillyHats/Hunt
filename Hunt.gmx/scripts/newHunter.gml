for(i=0; i<global.nPlayers; i++) {
    global.players[i].isHunter = false
}

hunter++;
if(hunter >= global.nPlayers) {
    shuffleHunters();
    hunter = 0;
}

hunters[hunter].isHunter = true;

audio_play_music(sndMusic, false);

alarm[0] = 10*room_speed;

