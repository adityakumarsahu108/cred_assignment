//trial model
class StackItemModel {
  final String title;
  final String subtitle;
  final String footer;
  final String ctaText;
  final int maxRange;
  final int minRange;
  final String header;
  final String description;

  StackItemModel({
    required this.title,
    required this.subtitle,
    required this.footer,
    required this.ctaText,
    required this.maxRange,
    required this.minRange,
    required this.header,
    required this.description,
  });

  factory StackItemModel.fromJson(Map<String, dynamic> json) {
    final openState = json['open_state']['body'];
    return StackItemModel(
      title: openState['title'],
      subtitle: openState['subtitle'],
      footer: openState['footer'],
      ctaText: json['cta_text'],
      maxRange: openState['card']['max_range'],
      minRange: openState['card']['min_range'],
      header: openState['card']['header'],
      description: openState['card']['description'],
    );
  }
}
