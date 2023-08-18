import 'package:dr_purple/core/utils/enums.dart';

class Constants {
  static const empty = "";
  static const zero = 0;
  static const applicationJson = "application/json";
  static const multipart = "multipart/form-data";
  static const contentType = "content-type";
  static const accept = "accept";
  static const role = "role";
  static const file = "file";
  static const email = "email";
  static const authorization = "Authorization";
  static const language = "lang";
  static const timeout = 60 * 1000;
  static const logTag = "dr_purple";
  static const logFileName = "dr_purple_log_file";
  static const logDirectory = "dr_purple_logs";
  static const logExportedDirectory = "dr_purple_logs/Exported";
  static const bookedServiceTimeState = "BookedServiceTimeState";
  static const canceledServiceTimeState = "CanceledServiceTimeState";
  static const doneServiceTimeState = "DoneServiceTimeState";

  // static RegExp passwordRegex =
  //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d).{8,}$');
  static RegExp passwordRegex = RegExp(r'^(?=.*?[aA-zZ])(?=.*?\d).{8,}$');
  static RegExp emailRegex =
      RegExp(r"^[a-zA-Z\d.a-zA-Z!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+");
  static RegExp phoneNumberRegex = RegExp(r'(^(?:[+0]96309)?[0-9]{8}$)');

  static const genders = [Gender.male, Gender.female];
}
