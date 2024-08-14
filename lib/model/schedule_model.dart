class Slot {
  final String slotStartTime;
  final String slotEndTime;

  Slot({required this.slotStartTime, required this.slotEndTime});

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      slotStartTime: json['slotStartTime'],
      slotEndTime: json['slotEndTime'],
    );
  }
}

class Datum {
  final String id;
  final String date;
  final int duration;
  final String doctorId;
  final List<Slot> slots;

  Datum({
    required this.id,
    required this.date,
    required this.duration,
    required this.doctorId,
    required this.slots,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    var slotsJson = json['slots'] as List;
    List<Slot> slotsList = slotsJson.map((slot) => Slot.fromJson(slot)).toList();

    return Datum(
      id: json['_id'],
      date: json['date'],
      duration: json['duration'] ?? 0,
      doctorId: json['doctorId'],
      slots: slotsList,
    );
  }
}
