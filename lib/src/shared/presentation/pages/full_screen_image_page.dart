import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/images/image_network_widget.dart';

class FullscreenImagePage extends StatelessWidget {
  final String imageUrl;

  const FullscreenImagePage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: InteractiveViewer(
                clipBehavior: Clip.none,
                child: ImageNetworkWidget(
                  imageUrl: imageUrl,
                  boxFit: BoxFit.scaleDown,
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
