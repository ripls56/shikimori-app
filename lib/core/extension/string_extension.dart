///String extension (syntactic sugar)
extension StringExtension on String {
  ///String to [Uri]
  Uri get toUri => Uri.parse(this);

  ///Capitalize string
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
}
