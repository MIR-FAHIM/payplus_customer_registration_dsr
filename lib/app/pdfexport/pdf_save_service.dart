import 'dart:io';
import 'dart:typed_data';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfSaveService {
  /// Save PDF bytes to device storage & open it externally
  static Future<String> saveAndOpenPdf(Uint8List bytes, String filename) async {
    // Request permission for Android 10-
    await Permission.storage.request();

    Directory? directory;

    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory(); // Android safe path
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final path = "${directory!.path}/$filename.pdf";
    final file = File(path);

    await file.writeAsBytes(bytes);

    await OpenFilex.open(path);

    return path;
  }
}
