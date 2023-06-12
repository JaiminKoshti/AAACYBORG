class Campaign {
  final String id;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  String thumbnailUrl;

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.thumbnailUrl = '', // Initialize with an empty string
  });
}