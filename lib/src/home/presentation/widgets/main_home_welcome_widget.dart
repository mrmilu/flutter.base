import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/providers/auth/auth_cubit.dart';
import '../../../shared/helpers/extensions.dart';
import '../../../shared/presentation/widgets/text/text_title.dart';

class MainHomeWelcomeWidget extends StatelessWidget {
  const MainHomeWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, stateAuth) {
                  final name = stateAuth.user?.name ?? 'Unkown';
                  return Expanded(
                    child: TextTitle.two(
                      context.cl.translate('pages.mainHome.title', {
                        'name': name,
                      }),
                    ),
                  );
                },
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }
}
