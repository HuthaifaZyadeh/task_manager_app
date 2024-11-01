abstract class AppImages {
  static String fallback = 'im_fallback.svg'.imageAssetPath;
}

extension ImagesPath on String {
  String get imageAssetPath => 'assets/images/$this';
}
