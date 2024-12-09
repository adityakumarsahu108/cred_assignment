class StackItem {
  final String? openStateTitle;
  final String? openStateSubtitle;
  final String? openStateFooter;
  final String? ctaText;
  final String? cardHeader;
  final String? cardDescription;
  final int? cardMaxRange;
  final int? cardMinRange;
  final String? closedStateKey1;
  final String? closedStateKey2;
  final List<Map<String, dynamic>>? items; 

  StackItem({
    this.openStateTitle,
    this.openStateSubtitle,
    this.openStateFooter,
    this.ctaText,
    this.cardHeader,
    this.cardDescription,
    this.cardMaxRange,
    this.cardMinRange,
    this.closedStateKey1,
    this.closedStateKey2,
    this.items,
  });

  factory StackItem.fromJson(Map<String, dynamic> json) {
    final openState = json['open_state']?['body'];
    final closedState = json['closed_state']?['body'];
    final items = (openState?['items'] as List<dynamic>?)
        ?.map((item) => Map<String, dynamic>.from(item))
        .toList();

    return StackItem(
      openStateTitle: openState?['title'] ?? '',
      openStateSubtitle: openState?['subtitle'] ?? '',
      openStateFooter: openState?['footer'] ?? '',
      ctaText: json['cta_text'] ?? 'Proceed',
      cardHeader: openState?['card']?['header'] ?? '',
      cardDescription: openState?['card']?['description'] ?? '',
      cardMaxRange: openState?['card']?['max_range'] ?? 10000000,
      cardMinRange: openState?['card']?['min_range'] ?? 0,
      closedStateKey1: closedState?['key1'] ?? '',
      closedStateKey2: closedState?['key2'] ?? '',
      items: items, 
    );
  }
}
