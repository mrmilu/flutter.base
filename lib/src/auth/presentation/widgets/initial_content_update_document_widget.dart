import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/data/services/app_flyer_service.dart';
import '../../../shared/domain/failures_extensions/fullname_failure_extension.dart';
import '../../../shared/domain/types/document_type.dart';
import '../../../shared/domain/vos/nie_vos.dart';
import '../../../shared/domain/vos/nif_vos.dart';
import '../../../shared/helpers/extensions.dart';
import '../../../shared/presentation/utils/const.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_elevated_button.dart';
import '../../../shared/presentation/widgets/components/buttons/custom_outlined_button.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_dropdown_field_widget.dart';
import '../../../shared/presentation/widgets/components/inputs/custom_text_field_widget.dart';
import '../../../shared/presentation/widgets/components/inputs/uppercase_input_formatter.dart';
import '../../../shared/presentation/widgets/text/text_body.dart';
import '../../../shared/presentation/widgets/text/text_title.dart';
import '../pages/initial_page.dart';
import '../providers/auth/auth_cubit.dart';
import '../providers/link_encoded/link_encoded_cubit.dart';
import '../providers/update_document/update_document_cubit.dart';

class InitialContentUpdateDocumentWidget extends StatefulWidget {
  const InitialContentUpdateDocumentWidget({
    super.key,
    required this.currentStep,
  });
  final ValueNotifier<int> currentStep;

  @override
  State<InitialContentUpdateDocumentWidget> createState() =>
      _InitialContentUpdateDocumentWidgetState();
}

class _InitialContentUpdateDocumentWidgetState
    extends State<InitialContentUpdateDocumentWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (typeGlobalDynamicLink != null && keyGlobalDynamicLink != null) {
        if (typeGlobalDynamicLink == dynamicLinkTypeLinkEncoded) {
          context.read<LinkEncodedCubit>().linkEncoded(keyGlobalDynamicLink!);
        }
      }
    });

    appsflyerSdk?.onDeepLinking((p0) {
      final deepLink = p0.deepLink?.clickEvent;
      final type = deepLink?[dynamicLinkParamType] ?? '';
      final encoded = deepLink?[dynamicLinkParamEncoded] ?? '';

      if (type == dynamicLinkTypeLinkEncoded) {
        context.read<LinkEncodedCubit>().linkEncoded(encoded);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    typeGlobalDynamicLink = null;
    keyGlobalDynamicLink = null;
    encodeGlobalDynamicLink = null;
    appsflyerSdk?.onDeepLinking((p0) {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateDocumentCubit, UpdateDocumentState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  TextTitle.three(
                    context.cl.translate('pages.auth.updateDocument.title'),
                  ),
                  const SizedBox(height: 20),
                  TextBody.two(
                    context.cl.translate('pages.auth.updateDocument.subtitle'),
                  ),
                  const SizedBox(height: 24),
                  CustomTextFieldWidget(
                    labelText: context.cl.translate(
                      'pages.auth.updateDocument.form.firstName',
                    ),
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    showError: state.showErrors,
                    onChanged: context
                        .read<UpdateDocumentCubit>()
                        .changeFirstName,
                    errorText: state.firstNameVos.value.map(
                      isLeft: (p0) => p0.toTranslation(context),
                      isRight: (_) => null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFieldWidget(
                    labelText: context.cl.translate(
                      'pages.auth.updateDocument.form.lastName',
                    ),
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    showError: state.showErrors,
                    onChanged: context
                        .read<UpdateDocumentCubit>()
                        .changeLastName,
                    errorText: state.lastNameVos.value.map(
                      isLeft: (p0) => p0.toTranslation(context),
                      isRight: (_) => null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomDropdownFieldWidget<DocumentType>(
                    title: context.cl.translate(
                      'pages.auth.updateDocument.form.documentType',
                    ),
                    onChanged: context
                        .read<UpdateDocumentCubit>()
                        .changeDocumentType,
                    initialValue: state.documentType.toTranslate(context),
                    items: [
                      DropdownMenuItem(
                        value: DocumentType.nif,
                        child: Text(DocumentType.nif.toTranslate(context)),
                      ),
                      DropdownMenuItem(
                        value: DocumentType.nie,
                        child: Text(DocumentType.nie.toTranslate(context)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CustomTextFieldWidget(
                    labelText: context.cl.translate(
                      'pages.auth.updateDocument.form.documentCode',
                    ),
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    showError: state.showErrors,
                    onChanged: context
                        .read<UpdateDocumentCubit>()
                        .changeDocumentValue,
                    errorText: state.documentType == DocumentType.nif
                        ? NifVos(state.documentValue).value.map(
                            isLeft: (p0) => p0.toTranslate(context),
                            isRight: (_) => null,
                          )
                        : NieVos(state.documentValue).value.map(
                            isLeft: (p0) => p0.toTranslate(context),
                            isRight: (_) => null,
                          ),
                  ),
                  const SizedBox(height: 8),
                  CustomElevatedButton.inverse(
                    onPressed: () =>
                        context.read<UpdateDocumentCubit>().updateDocument(),
                    padding: const EdgeInsets.symmetric(
                      vertical: paddingHightButtons,
                    ),
                    label: context.cl.translate(
                      'pages.auth.updateDocument.form.button',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: BlocConsumer<AuthCubit, AuthState>(
                listenWhen: (previous, current) =>
                    previous.user != current.user,
                listener: (context, state) {
                  if (state.user == null) {
                    widget.currentStep.value = InitialStep.signInEmail.index;
                  }
                },
                builder: (context, state) {
                  return CustomOutlinedButton.primary(
                    onPressed: () => context.read<AuthCubit>().logout(),
                    padding: const EdgeInsets.symmetric(
                      vertical: paddingHightButtons,
                    ),
                    label: context.cl.translate(
                      'pages.auth.updateDocument.logout',
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: context.paddingBottomPlus),
          ],
        );
      },
    );
  }
}
