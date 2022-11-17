import 'package:flutter/cupertino.dart';

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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
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