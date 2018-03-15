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
T drawFrom<T>(List<T> deck) {
  if(deck == null) return null;
  if(deck.length == 0) return null;
  if(deck.length == 1) return deck.first;

  return deck[_rng.nextInt(deck.length)];
}

/// Returns a random element of T that meets the passed predicate,
/// or null if none can
T drawWhere<T>(Iterable<T> deck, bool predicate(T)) {
  if(deck == null) return null;
  return drawFrom(deck.where(predicate).toList());
}

T drawWithoutRepeats<T>(Iterable<T> deck, Iterable<T> repeats) {
  if(deck == null) return null;
  return drawWhere(deck, (t) => !repeats.contains(t));
}

///returns N unique draws from the deck, or the whole deck if N >= deck.length
List<T> drawN<T>(Iterable<T> deck, int n) {
  if(n >= deck.length) {
    return new List.from(deck);
  }

  List<T> returns = new List();

  while(returns.length < n) {
    returns.add(drawWithoutRepeats(deck, returns));
  }

  return returns;
}

