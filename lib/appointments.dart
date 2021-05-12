class Appointments {
  final String name;
  final int appointmentsVal;
  final String colorVal;
  final String appointmentsYear;
  Appointments(
      this.name, this.appointmentsVal, this.colorVal, this.appointmentsYear);

  Appointments.fromMap(Map<String, dynamic> map)
      : assert(map['name'] != null),
        assert(map['appointmentsVal'] != null),
        assert(map['colorVal'] != null),
        assert(map['appointmentsYear'] != null),
        name = map['name'],
        appointmentsVal = map['appointmentsVal'],
        colorVal = map['colorVal'],
        appointmentsYear = map['appointmentsYear'];

  @override
  String toString() =>
      "Record<$name: $appointmentsVal: $colorVal: $appointmentsYear>";
}
