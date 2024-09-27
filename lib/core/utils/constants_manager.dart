// ignore_for_file: constant_identifier_names

import 'package:doctor_ack/core/local/cache_helper.dart';
import 'package:doctor_ack/core/utils/strings_manager.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';

enum MessageType { success, error, warning }

enum LangType { ar_001, en_US }

class AppConstants {
  static Map<MessageType, Color> messageColors = {
    MessageType.success: ColorManager.primary,
    MessageType.error: ColorManager.error,
    MessageType.warning: Colors.orange
  };

  static Map<MessageType, IconData> messageIcon = {
    MessageType.success: Icons.done_rounded,
    MessageType.error: Icons.error_outline_rounded,
    MessageType.warning: Icons.warning_amber_rounded
  };

  static const int splashDelay = 2;
  static const int sliderAnimationTime = 300;
  static double height = 812;
  static double width = 375;
  static String token = '';
  static String languageCode = '';
  static String expireToken = '';
  static String type = '';
  static String role = CacheHelper.get(key: AppStrings.cachedRole) ?? '';
  static int cachedId = CacheHelper.get(key: AppStrings.cachedID) ?? 0;
  static bool language = false;
}
