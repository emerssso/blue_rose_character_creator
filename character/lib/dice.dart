import 'dart:math';

final rng = Random();

extension Dice on int {
  /// Allows fancy `2.d(6)` notation.
  int d(int sides) => List.generate(this, (i) => rng.nextInt(sides) + 1)
      .fold(0, (i, j) => i + j);

  /// Fancy `2.d6` notation.
  int get d6 => this.d(6);
}

///Role a die with [x] sides
int d(int x) => rng.nextInt(x) + 1;

///Role a d6 (primary die for Blue Rose)
int get d6 => d(6);

///flip a coin
bool get flipCoin => rng.nextInt(2) == 1;

///randomly select a T from passed list
T drawFrom<T>(List<T> deck) {
  if (deck == null) return null;
  if (deck.length == 0) return null;
  if (deck.length == 1) return deck.first;

  return deck[rng.nextInt(deck.length)];
}

/// Returns a random element of T that meets the passed predicate,
/// or null if none can
T drawWhere<T>(Iterable<T> deck, bool Function(T) predicate) {
  if (deck == null) return null;
  return drawFrom(deck.where(predicate).toList());
}

T drawWithoutRepeats<T>(Iterable<T> deck, Iterable<T> repeats) {
  if (deck == null) return null;
  return drawWhere(deck, (t) => !repeats.contains(t));
}

///returns N unique draws from the deck, or the whole deck if N >= deck.length
List<T> drawN<T>(int n, Iterable<T> deck) {
  if (deck == null) return null;
  if (n >= deck.length) return List.from(deck);

  List<T> returns = List();

  while (returns.length < n) {
    returns.add(drawWithoutRepeats(deck, returns));
  }

  return returns;
}

List<T> drawNWithoutRepeats<T>(int n, Iterable<T> deck, Iterable<T> repeats) {
  if (deck == null) return null;
  if (repeats == null) return drawN(n, deck);
  if (n >= deck.length) return List.from(deck);

  final returns = <T>[];
  final neitherContains = (t) => !repeats.contains(t) && !returns.contains(t);

  while (returns.length < n) {
    returns.add(drawWhere(deck, neitherContains));
  }

  return returns;
}
