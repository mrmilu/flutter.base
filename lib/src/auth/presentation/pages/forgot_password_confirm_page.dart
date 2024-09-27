import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/auth/presentation/pages/change_password_page.dart';
import 'package:flutter_base/src/auth/presentation/states/forgot_password_confirm_provider.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/box_spacer.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/buttons/button_primary.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/buttons/button_tertiary.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/flutter_base_app_bar.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/sheets/scaffold_bottom_sheet.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/sheets/with_transparent_bottom_sheet.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/text/high_text.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/views/column_scroll_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordConfirmPageData {
  final String uid;
  final String email;
  final String token;

  const ForgotPasswordConfirmPageData({
    this.uid = '',
    this.email = '',
    this.token = '',
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
                key: const Key('forgot-pass-confirm-button'),
                onPressed: data.token.isNotEmpty
                    ? () {
                        GoRouter.of(context).push(
                          '/change-password',
                          extra: ChangePasswordPageData(
                            token: data.token,
                            uid: data.uid,
                          ),
                        );
                      }
                    : null,
                text: LocaleKeys.forgotPasswordConfirm_continue.tr(),
              ),
              BoxSpacer.v8(),
              if (data.email.isNotEmpty)
                Consumer(
                  builder: (context, ref, _) {
                    return ButtonTertiary(
                      key: const Key('forgot-pass-confirm-resend-button'),
                      onPressed: () => ref
                          .read(forgotPasswordConfirmProvider.notifier)
                          .resendRequestChange(data.email),
                      text: LocaleKeys.forgotPasswordConfirm_resend.tr(),
                    );
                  },
                ),
            ],
          ),
        ),
        body: SafeArea(
          child: ColumnScrollView(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            padding: Insets.h24,
            children: [
              BoxSpacer.v16(),
              Consumer(
                builder: (context, ref, _) {
                  final title = ref.watch(
                    forgotPasswordConfirmProvider
                        .select((state) => state.pageTitle),
                  );
                  return HighText.l(title);
                },
              ),
              BoxSpacer.v64(),
            ],
          ),
        ),
      ),
    );
  }
}
