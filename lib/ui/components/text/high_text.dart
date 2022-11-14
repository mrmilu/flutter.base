import 'package:flutter/cupertino.dart';
import 'package:flutter_base/ui/styles/text_style.dart';

class HighTextS extends StatelessWidget {
  final String label;
  final Color? color;

  const HighTextS(
    this.label, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: MoggieTextStyles.highS,
    );
  }
}
class HighTextM extends StatelessWidget {
  final String label;
  final Color? color;

  const HighTextM(
    this.label, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: MoggieTextStyles.highM,
    );
  }
}

class HighTextL extends StatelessWidget {
  final String label;
  final Color? color;

  const HighTextL(
    this.label, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: MoggieTextStyles.highL,
    );
  }
}

class HighTextXl extends StatelessWidget {
  final String label;
  final Color? color;

  const HighTextXl(
    this.label, {
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: MoggieTextStyles.highXl,
    );
  }
}
