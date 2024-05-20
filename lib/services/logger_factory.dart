import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;

class LoggerFactory {
  static final LoggerFactory _instance = LoggerFactory._();

  static LoggerFactory get instance => _instance;

  LoggerFactory._();

  Logger _logger = Logger();

  Logger getLogger() {
    return _logger;
  }

  Future<void> init() async {
    final multiOutput = await getMultiOutput();
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 8,
        printTime: true,
      ),
      output: multiOutput,
    );
  }

  Future<FileOutput?> _createFileOutput() async {
    final fileDir = await getExternalStorageDirectory();
    if (fileDir == null) {
      Logger().e('Failed to get external storage directory');
      return null;
    }

    final filePath = p.join(fileDir.path, 'log.txt');
    final file = File(filePath);
    return FileOutput(file: file);
  }

  Future<MultiOutput> getMultiOutput() async {
    final fileOutput = await _createFileOutput();
    return MultiOutput([ConsoleOutput(), fileOutput]);
  }
}
