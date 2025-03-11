class AnnouncementModel {
  final String title;
  final String subtitle;
  final String date;

  AnnouncementModel({
    required this.title,
    required this.subtitle,
    required this.date,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      date: json['date'] ?? '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    );
  }
}
