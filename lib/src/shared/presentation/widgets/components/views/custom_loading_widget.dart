import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
    this.height,
    this.title,
    this.imageUrl,
  });
  final double? height;
  final String? title;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 200,
      child: const Center(
        // TODO: Change to lottie better
        child: CircularProgressIndicator(),
      ),
    );
  }
}
