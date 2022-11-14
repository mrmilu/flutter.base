import 'package:flutter/cupertino.dart';
import 'package:flutter_base/ui/styles/text_style.dart';

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
      style: MoggieTextStyles.smallXxs.copyWith(
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
      style: MoggieTextStyles.smallXs.copyWith(
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
      style: MoggieTextStyles.smallS.copyWith(
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
      style: MoggieTextStyles.smallM.copyWith(
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
      style: MoggieTextStyles.smallL.copyWith(
        color: color,
      ),
    );
  }
}

