import 'package:flutter/material.dart';

import '../shared/presentation/widgets/text/text_body.dart';
import '../shared/presentation/widgets/text/text_title.dart';

class MainTap2Page extends StatelessWidget {
  const MainTap2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextTitle.four('Tap 2 Page'),
      ),
      body: Center(
        child: TextBody.one(
          'This is the main Tap 2 page.',
        ),
      ),
    );
  }
}
