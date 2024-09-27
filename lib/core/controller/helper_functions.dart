import 'dart:convert';
import 'dart:io';

class HelperFunctions {
  static imageConverter(String image) {
    return const Base64Decoder().convert(image);
  }

  static dynamic convertToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    return base64Image;
  }
}
