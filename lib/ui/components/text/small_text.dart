// ignore_for_file: prefer-single-widget-per-file
import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/styles/text_styles.dart';

class SmallTextXxs extends StatelessWidget {
  final String label;
  final Color? color;
  final TextAlign? textAlign;

  const SmallTextXxs(
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
      style: TextStyles.smallXxs.copyWith(
        color: color,
      ),
    );
  }
}

class SmallTextXs extends StatelessWidget {
  final String label;
  final Color? color;
  final TextAlign? textAlign;

  const SmallTextXs(
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
      style: TextStyles.smallXs.copyWith(
        color: color,
      ),
    );
  }
}

class SmallTextS extends StatelessWidget {
  final String label;
  final Color? color;
  final TextAlign? textAlign;

  const SmallTextS(
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
      style: TextStyles.smallS.copyWith(
        color: color,
      ),
    );
  }
}

class SmallTextM extends StatelessWidget {
  final String label;
  final Color? color;
  final TextAlign? textAlign;

  const SmallTextM(
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
      style: TextStyles.smallM.copyWith(
        color: color,
      ),
    );
  }
}

class SmallTextL extends StatelessWidget {
  final String label;
  final Color? color;
  final TextAlign? textAlign;

  const SmallTextL(
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
      style: TextStyles.smallL.copyWith(
        color: color,
      ),
    );
  }
}
