// ignore_for_file: prefer-single-widget-per-file
import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/styles/text_styles.dart';

class MidTextXs extends StatelessWidget {
  final String label;
  final Color? color;
  final TextAlign? textAlign;

  const MidTextXs(
    this.label, {
    super.key,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: TextStyles.midXs.copyWith(
        color: color,
      ),
    );
  }
}

class MidTextS extends StatelessWidget {
  final String label;
  final Color? color;
  final TextAlign? textAlign;

  const MidTextS(
    this.label, {
    super.key,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: TextStyles.midS.copyWith(
        color: color,
      ),
    );
  }
}

class MidTextM extends StatelessWidget {
  final String label;
  final Color? color;
  final TextAlign? textAlign;

  const MidTextM(
    this.label, {
    super.key,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: TextStyles.midM.copyWith(
        color: color,
      ),
    );
  }
}

class MidTextL extends StatelessWidget {
  final String label;
  final Color? color;
  final TextAlign? textAlign;

  const MidTextL(
    this.label, {
    super.key,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: TextStyles.midL.copyWith(
        color: color,
      ),
    );
  }
}

class MidTextXl extends StatelessWidget {
  final String label;
  final Color? color;
  final TextAlign? textAlign;

  const MidTextXl(
    this.label, {
    super.key,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: TextStyles.midXl.copyWith(
        color: color,
      ),
    );
  }
}

class MidTextXll extends StatelessWidget {
  final String label;
  final Color? color;
  final TextAlign? textAlign;

  const MidTextXll(
    this.label, {
    super.key,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: TextStyles.midXxl.copyWith(
        color: color,
      ),
    );
  }
}
