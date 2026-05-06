import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Crops [src] vertically so that [pinY] is the visual center of the result,
/// and returns it as PNG bytes. Returns null if [pinY] would produce a
/// degenerate crop. Does not dispose [src]; the caller owns it.
Future<Uint8List?> cropImageVerticallyCenteredOn(
  ui.Image src,
  double pinY,
) async {
  final h = src.height.toDouble();
  final halfH = min(pinY, h - pinY);
  final cropTop = (pinY - halfH).round();
  final cropHeight = (halfH * 2).round();
  if (cropHeight <= 0) return null;

  final srcWidth = src.width.toDouble();
  final recorder = ui.PictureRecorder();
  Canvas(recorder).drawImageRect(
    src,
    Rect.fromLTWH(0, cropTop.toDouble(), srcWidth, cropHeight.toDouble()),
    Rect.fromLTWH(0, 0, srcWidth, cropHeight.toDouble()),
    Paint(),
  );

  final croppedPicture = recorder.endRecording();
  final croppedImage = await croppedPicture.toImage(
    srcWidth.round(),
    cropHeight,
  );
  croppedPicture.dispose();

  final byteData = await croppedImage.toByteData(
    format: ui.ImageByteFormat.png,
  );
  croppedImage.dispose();
  return byteData?.buffer.asUint8List();
}
