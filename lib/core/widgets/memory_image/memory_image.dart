import 'dart:typed_data';

import 'package:doctor_ack/core/utils/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../utils/values_manager.dart';

class MemoryImageCustom extends StatelessWidget {
  final Uint8List url;
  final double? height;
  final double? width;
  final double? shimmerHeight;
  final double? shimmerWidth;
  final double? boarder;
  final BoxFit? boxFit;
  final Color? color;

  const MemoryImageCustom({
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
      child: Image.memory(
        url,
        height: height,
        color: color,
        width: width,
        fit: boxFit,
        errorBuilder: (context, url, error) => Image.asset(
          ImageAssets.logo1,
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
