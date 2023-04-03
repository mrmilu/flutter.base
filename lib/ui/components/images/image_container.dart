import 'package:flutter/cupertino.dart';
import 'package:flutter_base/ui/styles/border_radius.dart';

class ImageContainer extends StatelessWidget {
  final String imageName;
  final double height;
  final Widget child;

  const ImageContainer({
    super.key,
    required this.imageName,
    this.height = 408,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: CircularBorderRadius.br24),
      clipBehavior: Clip.antiAlias,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/$imageName',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: child,
          ),
        ],
      ),
    );
  }
}
