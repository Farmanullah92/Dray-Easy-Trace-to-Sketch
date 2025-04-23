import 'dart:isolate';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ImageProcessor {
  static Future<Uint8List> processImage(
    Uint8List imageBytes,
    double edgeLevel,
  ) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(
      _isolateImageProcessor,
      _IsolateData(imageBytes, edgeLevel, receivePort.sendPort),
    );
    return await receivePort.first as Uint8List;
  }

  static void _isolateImageProcessor(_IsolateData isolateData) {
    try {
      final original = img.decodeImage(isolateData.imageBytes);
      if (original == null) throw Exception('Failed to decode image');

      img.Image gray = img.grayscale(original);
      img.Image edges = img.sobel(gray);
      img.Image blended = img.copyResize(
        original,
        width: edges.width,
        height: edges.height,
      );

      for (int y = 0; y < edges.height; y++) {
        for (int x = 0; x < edges.width; x++) {
          final originalPixel = blended.getPixel(x, y);
          final edgePixel = edges.getPixel(x, y);

          int r =
              ((originalPixel.r * (1 - isolateData.edgeLevel)) +
                      (edgePixel.r * isolateData.edgeLevel))
                  .toInt();
          int g =
              ((originalPixel.g * (1 - isolateData.edgeLevel)) +
                      (edgePixel.g * isolateData.edgeLevel))
                  .toInt();
          int b =
              ((originalPixel.b * (1 - isolateData.edgeLevel)) +
                      (edgePixel.b * isolateData.edgeLevel))
                  .toInt();

          blended.setPixelRgba(x, y, r, g, b, originalPixel.a);
        }
      }

      Isolate.exit(
        isolateData.sendPort,
        Uint8List.fromList(img.encodeJpg(blended)),
      );
    } catch (e) {
      Isolate.exit(isolateData.sendPort, isolateData.imageBytes);
    }
  }
}

class _IsolateData {
  final Uint8List imageBytes;
  final double edgeLevel;
  final SendPort sendPort;

  _IsolateData(this.imageBytes, this.edgeLevel, this.sendPort);
}
