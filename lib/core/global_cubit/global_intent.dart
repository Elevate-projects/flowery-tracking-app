sealed class GlobalIntent {}

class GlobalInitializationIntent extends GlobalIntent {}

class ChangeLanguageIntent extends GlobalIntent {
  ChangeLanguageIntent({required this.index});
  final int index;
}
