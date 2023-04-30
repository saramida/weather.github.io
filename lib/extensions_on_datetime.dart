extension DateTimeExtensions on DateTime {
  String get time => toString().split(" ")[1].toString();

  String get hr => time.split(":")[0];

  String get hr24 => hour > 12
      ? int.parse(time.split(":")[0]) > 10
      ? (int.parse(time.split(":")[0]) - 12).toString()
      : "0" + (int.parse(time.split(":")[0]) - 12).toString()
      : hr;

  String get min => time.split(":")[1];

  String get sec => time.split(":")[2];
  String get date => toString().split(" ")[0];
}
