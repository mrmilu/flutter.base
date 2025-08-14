import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../extensions/buildcontext_extensions.dart';

class TextWithArrowWidget extends StatelessWidget {
  const TextWithArrowWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.titleStyle,
    this.padding,
  });
  final String title;
  final TextStyle? titleStyle;
  final VoidCallback onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: titleStyle ?? context.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(width: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.string(arrowIosRightIcon),
            ),
          ],
        ),
      ),
    );
  }
}

final arrowIosRightIcon =
    '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M8.64645 5.64645C8.84171 5.45118 9.15829 5.45118 9.35355 5.64645L15.3536 11.6464C15.5488 11.8417 15.5488 12.1583 15.3536 12.3536L9.35355 18.3536C9.15829 18.5488 8.84171 18.5488 8.64645 18.3536C8.45118 18.1583 8.45118 17.8417 8.64645 17.6464L14.2929 12L8.64645 6.35355C8.45118 6.15829 8.45118 5.84171 8.64645 5.64645Z" fill="#172121"/>
</svg>
''';
