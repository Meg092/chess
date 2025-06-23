import 'package:flutter/material.dart';

class VolumeControl extends StatefulWidget {
  final double width;
  final double height;
  final double minValue;
  final double maxValue;
  final double initialValue;
  final Color bgColor;
  final Widget child;

  const VolumeControl({
    super.key,
    required this.width,
    required this.height,
    required this.minValue,
    required this.maxValue,
    this.initialValue = 50,
    required this.bgColor,
    required this.child,
  });

  @override
  State<VolumeControl> createState() => _VolumeControlState();
}

class _VolumeControlState extends State<VolumeControl>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _targetValue = 50;

  @override
  void initState() {
    super.initState();
    _targetValue = widget.initialValue;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(
      begin: widget.initialValue,
      end: widget.initialValue,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildProgressBackground(),
              _buildProgressFill(widget.initialValue),
              widget.child
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressBackground() {
    return Positioned.fill(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    ));
  }

  Widget _buildProgressFill(double currentValue) {
    final progressPercentage =
        (currentValue - widget.minValue) / (widget.maxValue - widget.minValue);
    final progressHeight = widget.height * progressPercentage;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        height: progressHeight,
        duration: const Duration(milliseconds: 1000),
        decoration: BoxDecoration(
          color: widget.bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
