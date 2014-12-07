/// shuffleHunters(stop_repeats)

var stopRepeats = argument0;

if (stopRepeats) {
    var last = hunters[global.nPlayers-1]
}

for(i=global.nPlayers-1; i>0; i--) {
    j = irandom(i);
    var temp = hunters[i];
    hunters[i] = hunters[j];
    hunters[j] = temp;
}

if(stopRepeats) {
    if (hunters[0] == last and global.nPlayers >= 2) {
        var j = irandom_range(1,global.nPlayers-1);
        hunters[0] = hunters[j];
        hunters[j] = last;
    }
}
