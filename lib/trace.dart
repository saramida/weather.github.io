
class Trace{
  static int maxTemp = 0;
  static int minTemp = 0;

  static bool isdebug = false;
  static void DebugPrintln(var log){
    if(isdebug) {
      print(log);
    }
  }
}