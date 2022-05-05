class StringTimeFormatter {
  String formatTime(int time) {
    return (time.toString().length == 1) ? '0$time' : time.toString();
  }
}
