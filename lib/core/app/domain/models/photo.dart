enum ImageType { cat, chat, moments, tips }

class Photo {
  final int? id;
  final String url;
  final ImageType type;

  Photo({
    this.id,
    required this.url,
    required this.type,
  });
}
