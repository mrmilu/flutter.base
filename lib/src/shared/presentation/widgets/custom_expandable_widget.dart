import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'simple_block_widget.dart';

class CustomExpandableWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget? collapsedContent;
  final Widget? collapsedFooterContent;
  final List<Widget> children;
  final Color? backgroundColor;
  final Border? border;
  final TextStyle? titleStyle;
  final bool collapsedContentWithTap;
  final bool isInitiallyExpanded;
  final EdgeInsets? titlePadding;

  const CustomExpandableWidget({
    super.key,
    required this.title,
    this.subtitle = '',
    this.collapsedContent,
    this.collapsedFooterContent,
    required this.children,
    this.backgroundColor,
    this.border,
    this.titleStyle,
    this.collapsedContentWithTap = false,
    this.isInitiallyExpanded = false,
    this.titlePadding,
  });

  @override
  State<CustomExpandableWidget> createState() => _CustomExpandableWidgetState();
}

class _CustomExpandableWidgetState extends State<CustomExpandableWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    _isExpanded = widget.isInitiallyExpanded;
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: _isExpanded ? 1.0 : 0.0,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleBlockWidget(
      padding: const EdgeInsets.all(4),
      backgroundColor: widget.backgroundColor,
      border: widget.border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            contentPadding: widget.titlePadding,
            title: Text(
              widget.title,
              style:
                  widget.titleStyle ??
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: widget.subtitle.isNotEmpty ? Text(widget.subtitle) : null,
            trailing: RotationTransition(
              turns: _animation.drive(Tween<double>(begin: 0.0, end: 0.5)),
              child: const Icon(Icons.expand_more, color: Colors.black),
            ),
            onTap: _toggleExpand,
          ),
          (widget.collapsedContent != null)
              ? widget.collapsedContentWithTap
                    ? InkWell(
                        onTap: _toggleExpand,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: widget.collapsedContent!,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: widget.collapsedContent!,
                      )
              : const SizedBox.shrink(),
          SizeTransition(
            sizeFactor: _animation,
            child: ClipRect(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.children,
                        )
                        .animate(
                          target: _isExpanded ? 1.0 : 0.0,
                        )
                        .fadeIn(),
              ),
            ),
          ),
          (widget.collapsedFooterContent != null)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: widget.collapsedFooterContent!,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
