import 'dart:convert';

import '../../domain/models/page_model.dart';

class PageDto<T> {
  final int total;
  final int page;
  final int size;
  final int totalPages;
  final List<T> items;
  PageDto({
    required this.total,
    required this.page,
    required this.size,
    required this.totalPages,
    required this.items,
  });
  PageDto._({
    required this.total,
    required this.page,
    required this.size,
    required this.totalPages,
    required this.items,
  });

  factory PageDto.fromDomain(PageModel<T> model) {
    return PageDto._(
      total: model.total,
      page: model.page,
      size: model.size,
      totalPages: model.totalPages,
      items: model.items,
    );
  }

  PageModel<T> toDomain({T Function(T dataResults)? domainCallback}) {
    return PageModel(
      total: total,
      page: page,
      size: size,
      totalPages: totalPages,
      items: domainCallback != null ? items.map(domainCallback).toList() : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'page': page,
      'size': size,
      'totalPages': totalPages,
      'items': items,
    };
  }

  factory PageDto.fromMap(
    Map<String, dynamic> map,
    T Function(Object? json) fromJsonT,
  ) {
    return PageDto(
      total: map['total'],
      page: map['page'],
      size: map['size'],
      totalPages: map['pages'],
      items: (map['items'] as List<dynamic>?)?.map(fromJsonT).toList() ?? [],
    );
  }

  String toJson() => json.encode(toMap());

  factory PageDto.fromJson(
    String source,
    T Function<T>(dynamic) fromJson,
  ) => PageDto.fromMap(
    json.decode(source),
    fromJson,
  );
}
