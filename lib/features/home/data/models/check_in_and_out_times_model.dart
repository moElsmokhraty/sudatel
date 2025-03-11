class CheckInAndOutTimesModel {
  final String? checkInTime;
  final String? checkOutTime;

  CheckInAndOutTimesModel({
    this.checkInTime,
    this.checkOutTime,
  });

  factory CheckInAndOutTimesModel.fromJson(Map<String, dynamic> json) {
    return CheckInAndOutTimesModel(
      checkInTime: json['checkInTime'],
      checkOutTime: json['checkOutTime'],
    );
  }
}