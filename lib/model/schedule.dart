class Schedule {
  DateTime date;
  List<Slot> slots;

  Schedule({required this.date, required this.slots});
}

class Slot {
  // Define your slot properties here
  // For example:
  String startTime;
  String endTime;

  Slot({required this.startTime, required this.endTime});
}