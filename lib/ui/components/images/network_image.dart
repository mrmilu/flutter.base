import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/ui/styles/colors.dart';

class NetworkImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit? fit;

  const NetworkImage(
    this.url, {
    super.key,
    required this.width,
    required this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: FlutterBaseColors.specificContentLow.withOpacity(.20),
        borderRadius: BorderRadius.circular(16),
      ),
    );

    return CachedNetworkImage(
      errorWidget: (ctx, _, __) => placeholder,
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, _) => Center(child: placeholder),
    );
  }
}
