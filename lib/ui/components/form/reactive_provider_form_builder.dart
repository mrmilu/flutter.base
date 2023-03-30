import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class ReactiveProviderFormBuilder<T extends FormModel> extends StatefulWidget {
  final Widget Function(BuildContext context, Widget? child) builder;
  final T formModel;
  final Widget? child;
  const ReactiveProviderFormBuilder({
    super.key,
    required this.formModel,
    required this.builder,
    this.child,
  });

  @override
  State<ReactiveProviderFormBuilder<T>> createState() =>
      ReactiveProviderFormBuilderState<T>();
}

///  Copy behaviour from generated code by `reactive_forms_generator`
class ReactiveProviderFormBuilderState<T extends FormModel>
    extends State<ReactiveProviderFormBuilder<T>> {
  @override
  void initState() {
    if (widget.formModel.form.disabled) {
      widget.formModel.form.markAsDisabled();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ReactiveProviderFormBuilder<T> oldWidget) {
    if (widget.formModel != widget.formModel) {
      if (widget.formModel.form.disabled) {
        widget.formModel.form.markAsDisabled();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => widget.formModel.form,
      child: widget.child,
      builder: (context, formGroup, child) => widget.builder(context, child),
    );
  }
}
