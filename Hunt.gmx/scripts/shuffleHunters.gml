var last = hunters[global.nPlayers-1]

for(i=global.nPlayers-1; i>0; i--) {
    j = irandom(i);
    var temp = hunters[i];
    hunters[i] = hunters[j];
    hunters[j] = temp;
}

if(hunters[0] == last) {
    var j = irandom_range(1,global.nPlayers-1);
    hunters[0] = hunters[j];
    hunters[j] = last;
}

