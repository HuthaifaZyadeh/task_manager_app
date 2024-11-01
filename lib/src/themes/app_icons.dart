abstract class AppIcons {
  static String apple = 'ic_apple.svg'.iconAssetPath;
  static String google = 'ic_google.svg'.iconAssetPath;
  static String facebook = 'ic_facebook.svg'.iconAssetPath;
}

extension IconsPath on String {
  String get iconAssetPath => 'assets/icons/$this';
}
