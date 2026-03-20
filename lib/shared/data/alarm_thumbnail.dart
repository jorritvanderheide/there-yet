import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AlarmThumbnail {
  AlarmThumbnail._();

  static Future<String> _thumbnailDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final thumbDir = Directory(p.join(dir.path, 'thumbnails'));
    if (!thumbDir.existsSync()) {
      await thumbDir.create(recursive: true);
    }
    return thumbDir.path;
  }

  static Future<void> save(int alarmId, Uint8List bytes) async {
    final dir = await _thumbnailDir();
    final file = File(p.join(dir, 'alarm_$alarmId.png'));
    await file.writeAsBytes(bytes);
  }

  static Future<File?> get(int alarmId) async {
    final dir = await _thumbnailDir();
    final file = File(p.join(dir, 'alarm_$alarmId.png'));
    if (await file.exists()) return file;
    return null;
  }

  static Future<void> delete(int alarmId) async {
    final dir = await _thumbnailDir();
    final file = File(p.join(dir, 'alarm_$alarmId.png'));
    if (await file.exists()) {
      await file.delete();
    }
  }
}
