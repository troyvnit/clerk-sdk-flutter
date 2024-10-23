class ClerkTranslator {
  static const _substitutionKey = '###';

  const ClerkTranslator();

  /// Translate a string into a different language. Identity function for English
  String translate(String phrase, {String? substitution, List<String> substitutions = const []}) {
    if (substitution case String sub) {
      return phrase.replaceFirst(_substitutionKey, sub);
    }

    for (final sub in substitutions) {
      phrase = phrase.replaceFirst(_substitutionKey, sub);
    }
    return phrase;
  }

  /// A method that takes a list of strings ['first', 'second', 'third']
  /// and returns a string representation of its contents as alternates
  /// e.g. "First, second or third"
  ///
  /// Should be overridden for languages where that is not the correct
  /// representation for alternates
  String alternates(List<String> items) {
    if (items.isEmpty) return '';

    final buf = StringBuffer();

    final firstItem = translate(items.first);
    buf.write(firstItem[0].toUpperCase());
    buf.write(firstItem.substring(1));

    for (final item in items.skip(1)) {
      buf.write(item == items.last ? translate(' or ') : ', ');
      buf.write(translate(item));
    }

    return buf.toString();
  }
}
