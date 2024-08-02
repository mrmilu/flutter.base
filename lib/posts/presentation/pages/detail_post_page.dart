import 'package:flutter/material.dart';
import 'package:flutter_base/posts/application/detail_post_provider.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/error_message.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:flutter_base/ui/components/loaders/circular_progress.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/styles/insets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPostPage extends StatelessWidget {
  final int id;
  const DetailPostPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FlutterBaseAppBar(),
      body: Padding(
        padding: Insets.a16,
        child: Consumer(
          builder: (context, ref, child) {
            final post = ref.watch(detailPostProvider(id));
            return post.when(
              data: (data) => Column(
                children: [
                  HighText.l(data.title),
                  BoxSpacer.h16(),
                  HighText.m(data.body),
                ],
              ),
              error: (error, _) => ErrorMessage(error: error),
              loading: () => const CircularProgress(),
            );
          },
        ),
      ),
    );
  }
}
