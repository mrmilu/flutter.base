import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_primary.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:flutter_base/ui/components/scaffold_bottom_sheet.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/components/views/column_scroll_view.dart';
import 'package:flutter_base/ui/components/with_transparent_bottom_sheet.dart';
import 'package:flutter_base/ui/features/auth/views/verify_account/verify_account_provider.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/styles/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VerifyAccountPageData {
  final String? token;

  const VerifyAccountPageData({
    required this.token,
  });
}

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
                      onPressed: userVerified
                          ? () {
                              GoRouter.of(context).go('/home');
                            }
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
            padding: const EdgeInsets.symmetric(horizontal: Spacing.sp24),
            children: [
              BoxSpacer.v16(),
              HighTextL(LocaleKeys.verifyAccount_title.tr()),
              BoxSpacer.v24(),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyAccount() {
    if (widget.token != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ref.read(verifyAccountProvider).verifyAccount(widget.token!);
      });
    }
  }
}