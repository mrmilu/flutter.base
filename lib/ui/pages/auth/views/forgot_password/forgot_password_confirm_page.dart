import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_primary.dart';
import 'package:flutter_base/ui/components/buttons/button_tertiary.dart';
import 'package:flutter_base/ui/components/column_scroll_view.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/components/scaffold_bottom_sheet.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base/ui/pages/auth/views/change_password/change_password_page.dart';
import 'package:flutter_base/ui/pages/auth/views/forgot_password/providers/forgot_password_confirm_provider.dart';
import 'package:flutter_base/ui/styles/spacing.dart';
import 'package:flutter_base/ui/with_transparent_bottom_sheet.dart';

class ForgotPasswordConfirmPageData {
  final String? uid;
  final String? email;
  final String? token;

  const ForgotPasswordConfirmPageData({
    this.uid,
    this.email,
    this.token,
  });
}

class ForgotPasswordConfirmPage extends StatelessWidget {
  final ForgotPasswordConfirmPageData data;

  const ForgotPasswordConfirmPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return WithTransparentBottomSheet(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: FlutterBaseAppBar.dialog(),
        bottomSheet: ScaffoldBottomSheet(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonPrimary(
                onPressed: data.token?.isNotEmpty == true
                    ? () {
                        GoRouter.of(context).push(
                          "/change-password",
                          extra: ChangePasswordPageData(
                            token: data.token!,
                            uid: data.uid!,
                          ),
                        );
                      }
                    : null,
                text: LocaleKeys.forgotPasswordConfirm_continue.tr(),
              ),
              BoxSpacer.v8(),
              if (data.email?.isNotEmpty == true)
                Consumer(builder: (context, ref, _) {
                  return ButtonTertiary(
                      onPressed: () => ref
                          .read(forgotPasswordConfirmProvider.notifier)
                          .resendRequestChange(data.email!),
                      text: LocaleKeys.forgotPasswordConfirm_resend.tr());
                }),
            ],
          ),
        ),
        body: SafeArea(
          child: ColumnScrollView(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            padding: const EdgeInsets.symmetric(horizontal: Spacing.sp24),
            children: [
              BoxSpacer.v16(),
              Consumer(builder: (context, ref, _) {
                final title = ref.watch(forgotPasswordConfirmProvider
                    .select((state) => state.pageTitle!));
                return HighTextL(title);
              }),
              BoxSpacer.v64(),
            ],
          ),
        ),
      ),
    );
  }
}
