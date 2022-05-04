class StringTimeFormatter {
  String formatTime(int time) {
    if (time.toString().length == 1) {
      return '0$time';
    } else {
      return time.toString();
    }
  }
}
