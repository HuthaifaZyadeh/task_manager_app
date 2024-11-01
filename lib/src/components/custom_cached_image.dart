import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../themes/app_colors.dart';
import '../themes/app_images.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    this.color,
    required this.url,
    this.boxFit = BoxFit.contain,
    this.width,
    this.height,
    this.circleFallback = false,
    this.fallbackColor,
    this.borderRadius,
  });

  final String url;
  final Color? color;
  final BoxFit boxFit;
  final double? width;
  final double? height;
  final bool circleFallback;
  final Color? fallbackColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return buildCachedNetworkImage();
  }

  Widget buildCachedNetworkImage() {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: boxFit,
        width: width,
        height: height,
        placeholder: (context, _) => Center(
          child: LoadingAnimationWidget.progressiveDots(
            color: color ?? AppColors.primary,
            size: 40,
          ),
        ),
        errorWidget: (context, _, __) => ClipRRect(
          borderRadius: BorderRadius.circular(circleFallback ? 90 : 0),
          child: SvgPicture.asset(
            AppImages.fallback,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
