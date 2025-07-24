class PageModel<T> {
  final int total;
  final int page;
  final int size;
  final int totalPages;
  final List<T> items;

  const PageModel({
    required this.total,
    required this.page,
    required this.size,
    required this.totalPages,
    required this.items,
  });

  static PageModel<T> empty<T>() => PageModel<T>(
    total: 0,
    page: 0,
    size: 0,
    totalPages: 0,
    items: [],
  );

  PageModel<T> copyWith({
    int? total,
    int? page,
    int? size,
    int? totalPages,
    List<T>? items,
  }) {
    return PageModel<T>(
      total: total ?? this.total,
      page: page ?? this.page,
      size: size ?? this.size,
      totalPages: totalPages ?? this.totalPages,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return 'Page(total: $total, page: $page, size: $size, totalPages: $totalPages, items: $items)';
  }
}
