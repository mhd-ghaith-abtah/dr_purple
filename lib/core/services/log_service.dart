import 'package:dr_purple/core/utils/constants.dart';
import 'package:flutter_logs/flutter_logs.dart';

class LogService {
  static final LogService _instance = LogService._();

  LogService._();

  factory LogService() => _instance;

  Future<void> initializeLoggingService() async => await FlutterLogs.initLogs(
        logLevelsEnabled: [
          LogLevel.INFO,
          LogLevel.WARNING,
          LogLevel.ERROR,
          LogLevel.SEVERE
        ],
        timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
        directoryStructure: DirectoryStructure.FOR_DATE,
        logTypesEnabled: [Constants.logFileName],
        logFileExtension: LogFileExtension.TXT,
        logsWriteDirectoryName: Constants.logDirectory,
        logsExportDirectoryName: Constants.logExportedDirectory,
        debugFileOperations: true,
        isDebuggable: true,
      );

  void log(String message) => FlutterLogs.logToFile(
        logFileName: Constants.logFileName,
        overwrite: false,
        logMessage: "$message\n",
        appendTimeStamp: true,
      );
}
