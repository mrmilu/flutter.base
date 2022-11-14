import 'package:flutter/cupertino.dart';
import 'package:flutter_base/ui/styles/text_style.dart';

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
      style: MoggieTextStyles.midXs.copyWith(
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
      style: MoggieTextStyles.midS.copyWith(
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
      style: MoggieTextStyles.midM.copyWith(
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
      style: MoggieTextStyles.midL.copyWith(
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
      style: MoggieTextStyles.midXl.copyWith(
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
      style: MoggieTextStyles.midXxl.copyWith(
        color: color,
      ),
    );
  }
}
