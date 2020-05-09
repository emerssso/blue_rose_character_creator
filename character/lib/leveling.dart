/// Returns a count of even levels up to [level].
int evenLevels(int level) => ((level - 1) / 2.0).ceil();

/// Returns a count of odd levels up to [level].
int oddLevels(int level) => ((level - 1) / 2.0).floor();