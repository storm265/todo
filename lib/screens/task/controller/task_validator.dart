class TaskValidator {
  String? isTitleValid({String? text}) {
    if (text == null || text.isEmpty) {
      return 'Title can\'t be empty. 😑';
    }
    return null;
  }

  String? isDateValid({String? text}) {
    if (text == null || text.isEmpty) {
      return 'Pick date. 😑';
    }
    return null;
  }

  String? isTimeValid({String? text}) {
    if (text == null || text.isEmpty) {
      return 'Pick time. 😑';
    }
    return null;
  }

  bool isNowBeforePast({required DateTime pickedDate}) =>
      DateTime.now().isBefore(pickedDate);
}
