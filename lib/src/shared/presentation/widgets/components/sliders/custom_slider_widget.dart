import 'package:flutter/material.dart';

import '../../../utils/styles/colors/colors_context.dart';
import '../text/rm_text.dart';

class CustomSliderWidget extends StatefulWidget {
  const CustomSliderWidget({
    super.key,
    required this.min,
    required this.max,
    required this.initialValue,
    this.onChanged,
    this.divisions,
    this.isDisabled = false,
  });
  final double min;
  final double max;
  final double initialValue;
  final Function(double)? onChanged;
  final int? divisions;
  final bool isDisabled;

  @override
  State<CustomSliderWidget> createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  late double _selectedValue;

  @override
  void initState() {
    _selectedValue = widget.initialValue;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateValue(double value) {
    setState(() {
      _selectedValue = value;
    });
    widget.onChanged?.call(value);
  }

  int division() {
    return ((widget.max - widget.min) * 10).round();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RMText.bodyMedium(widget.min.toInt().toString()),
        const SizedBox(width: 4),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final sliderWidth = constraints.maxWidth - 32;
              final thumbRadius = 12.0;
              final thumbWidth = thumbRadius * 2;
              final labelWidth = 40.0;

              final percent =
                  (_selectedValue - widget.min) / (widget.max - widget.min);

              final thumbPosition = percent * (sliderWidth - thumbWidth);

              final left = thumbPosition + ((labelWidth - thumbWidth) / 2);

              return SizedBox(
                height: 80,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 100),
                      top: 0,
                      left: left,
                      child: SizedBox(
                        width: labelWidth,
                        child: Center(
                          child: RMText.bodyMedium(
                            _selectedValue.toInt().toString(),
                          ),
                        ),
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        // tickMarkShape: SliderTickMarkShape.noTickMark,
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 12,
                        ),
                      ),
                      child: Slider(
                        value: _selectedValue,
                        min: widget.min,
                        max: widget.max,
                        divisions: widget.divisions ?? division(),
                        onChanged: widget.isDisabled ? null : _updateValue,
                        activeColor: context.colors.primary,
                        thumbColor: thumbColor,
                        inactiveColor: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 4),
        RMText.titleMedium(widget.max.toInt().toString()),
      ],
    );
  }

  Color? get thumbColor {
    final brightness = Theme.of(context).brightness;
    final color = brightness == Brightness.dark ? Colors.white : Colors.black;
    return color;
  }
}
