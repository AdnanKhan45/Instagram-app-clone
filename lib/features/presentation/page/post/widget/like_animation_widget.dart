import 'package:flutter/material.dart';

class LikeAnimationWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool isLikeAnimating;
  final VoidCallback? onLikeFinish;

  const LikeAnimationWidget(
      {Key? key,
      required this.child,
      required this.duration,
      required this.isLikeAnimating,
      this.onLikeFinish})
      : super(key: key);

  @override
  State<LikeAnimationWidget> createState() => _LikeAnimationWidgetState();
}

class _LikeAnimationWidgetState extends State<LikeAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scale;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration.inMilliseconds ~/2));
    scale = Tween<double>(begin: 1, end: 1.2).animate(_controller);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LikeAnimationWidget oldWidget) {
    if (widget.isLikeAnimating != oldWidget.isLikeAnimating) {
      beginLikeAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  beginLikeAnimation() async {
    if (widget.isLikeAnimating) {
      await _controller.forward();
      await _controller.reverse();
      await Future.delayed(Duration(milliseconds: 200));
      if (widget.onLikeFinish != null) {
        widget.onLikeFinish!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
