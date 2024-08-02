import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/auth/application/verify_account_provider.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/box_spacer.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/buttons/button_primary.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/flutter_base_app_bar.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/sheets/scaffold_bottom_sheet.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/sheets/with_transparent_bottom_sheet.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/text/high_text.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/views/column_scroll_view.dart';
import 'package:flutter_base/src/user/application/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VerifyAccountPage extends ConsumerStatefulWidget {
  final String? token;

  const VerifyAccountPage({super.key, this.token});

  @override
  ConsumerState<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends ConsumerState<VerifyAccountPage> {
  @override
  void initState() {
    _verifyAccount();
    super.initState();
  }

  void _verifyAccount() {
    if (widget.token?.isNotEmpty ?? false) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref
            .read(verifyAccountProvider.notifier)
            .verifyAccount(widget.token ?? '');
      });
    }
  }

  @override
  void didUpdateWidget(covariant VerifyAccountPage oldWidget) {
    _verifyAccount();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return WithTransparentBottomSheet(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: FlutterBaseAppBar(customPopRoute: '/'),
        bottomSheet: IntrinsicHeight(
          child: ScaffoldBottomSheet(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer(
                  builder: (context, ref, _) {
                    final userVerified =
                        ref.watch(userVerifiedComputedProvider);
                    return ButtonPrimary(
                      key: const Key('verify-button'),
                      onPressed: userVerified
                          ? () => GoRouter.of(context).go('/home')
                          : null,
                      text: LocaleKeys.verifyAccount_continue.tr(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: ColumnScrollView(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            padding: Insets.h24,
            children: [
              BoxSpacer.v16(),
              HighText.l(LocaleKeys.verifyAccount_title.tr()),
              BoxSpacer.v24(),
            ],
          ),
        ),
      ),
    );
  }
}
