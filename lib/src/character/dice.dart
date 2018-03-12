import 'dart:math';

var _rng = new Random();

///Role a die with [x] sides
int d(int x) => _rng.nextInt(x) + 1;

///Role a d6 (primary die for Blue Rose)
int d6() => d(6);

///Role X d6
int Xd6(int times) =>
    new List.generate(times, (i) => d6()).fold(0, (i, j) => i + j);

///flip a coin
bool coinFlip() => _rng.nextInt(2) == 1;

///randomly select a T from passed list
T drawFrom<T>(List<T> deck) => deck[_rng.nextInt(deck.length)];