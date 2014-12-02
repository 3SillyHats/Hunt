/*
 * Awards are arranged in an absolute hierarchy. Each award is determined from highest rank
 * to lowest rank, and is only given if that player does not already have an award.
 */

var record, player;

var default_award = "Mr. Boring";

// Reset awards
for(var i = 0; i < global.nPlayers; ++i) {
    global.awards[i] = default_award;
}

// Untouchable (no deaths)
player = noone;
for (var i = 0; i < global.nPlayers; ++i) {
    if (global.deaths[i] == 0) {
      player = i;
    }
}
if (player != noone and global.awards[player] == default_award) {
  global.awards[player] = "Untouchable";
}

// Deadly (most kills)
record = 0; player = noone;
for (var i = 0; i < global.nPlayers; ++i) {
    if (global.kills[i] > record) {
      record = global.kills[i];
      player = i;
    }
}
if (player != noone and global.awards[player] == default_award) {
  global.awards[player] = "Deadly";
}

// Pilot (fewest bounces)
record = 1000000; player = noone;
for (var i = 0; i < global.nPlayers; ++i) {
    if (global.bounces[i] < record) {
      record = global.bounces[i];
      player = i;
    }
}
if (player != noone and global.awards[player] == default_award) {
  global.awards[player] = "Pilot";
}

// Speedy (most boosts)
record = 0; player = noone;
for (var i = 0; i < global.nPlayers; ++i) {
    if (global.boosts[i] > record) {
      record = global.boosts[i];
      player = i;
    }
}
if (player != noone and global.awards[player] == default_award) {
  global.awards[player] = "Speedy";
}

// Squash (most bounces)
record = 0; player = noone;
for (var i = 0; i < global.nPlayers; ++i) {
    if (global.bounces[i] > record) {
      record = global.bounces[i];
      player = i;
    }
}
if (player != noone and global.awards[player] == default_award) {
  global.awards[player] = "Squash";
}

// Meek (least kills)
record = WIN_THRESHOLD * PLAYERS_MAX; player = noone;
for (var i = 0; i < global.nPlayers; ++i) {
    if (global.kills[i] < record) {
      record = global.kills[i];
      player = i;
    }
}
if (player != noone and global.awards[player] == default_award) {
  global.awards[player] = "Meek";
}
