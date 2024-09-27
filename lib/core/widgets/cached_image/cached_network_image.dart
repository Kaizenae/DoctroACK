import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/values_manager.dart';

class CachedNetworkImageCustom extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final double? shimmerHeight;
  final double? shimmerWidth;
  final double? boarder;
  final BoxFit? boxFit;
  final Color? color;

  const CachedNetworkImageCustom({
    super.key,
    required this.url,
    this.height = AppSize.s100,
    this.width = double.infinity,
    this.shimmerHeight = AppSize.s100,
    this.shimmerWidth = double.infinity,
    this.boarder = 0.0,
    this.color,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(boarder!),
      child: CachedNetworkImage(
        height: height,
        color: color,
        width: width,
        fit: boxFit,
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[500]!,
          highlightColor: Colors.grey[400]!,
          child: Container(
            height: shimmerHeight,
            width: shimmerWidth,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(boarder!),
            ),
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          ImageAssets.logo1,
          width: AppSize.s60,
          height: AppSize.s40,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
