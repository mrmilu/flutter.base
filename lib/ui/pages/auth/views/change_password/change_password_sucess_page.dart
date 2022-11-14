import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_primary.dart';
import 'package:flutter_base/ui/components/column_scroll_view.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/components/scaffold_bottom_sheet.dart';
import 'package:flutter_base/ui/extensions/media_query.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/styles/spacing.dart';

class ChangePasswordSuccessPage extends ConsumerWidget {
  final bool? skipOnboarding;

  const ChangePasswordSuccessPage({
    super.key,
    this.skipOnboarding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: FlutterBaseAppBar.dialog(customPopRoute: "/login"),
      bottomSheet: ScaffoldBottomSheet(
        child: ButtonPrimary(
          onPressed: (){
            GoRouter.of(context).go("/login");
          },
          text: LocaleKeys.changePasswordSuccess_button.tr(),
        ),
      ),
      body: ColumnScrollView(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoxSpacer.v16(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.sp16),
            child: HighTextM(LocaleKeys.changePasswordSuccess_title.tr()),
          ),
          BoxSpacer(verticalSpacing: MediaQuery.of(context).heightPercentage(30)),
        ],
      ),
    );
  }
}
