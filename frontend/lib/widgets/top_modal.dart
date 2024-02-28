import 'package:flutter/material.dart';

class TopModal extends StatefulWidget {
  final Widget child;

  const TopModal({Key? key, required this.child}) : super(key: key);

  @override
  _TopModalState createState() => _TopModalState();
}

class _TopModalState extends State<TopModal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
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
        return Transform.translate(
          offset: Offset(0.0, MediaQuery.of(context).size.height * _animation.value),
          child: GestureDetector(
            onTap: () {
              _controller.reverse().then((value) {
                Navigator.pop(context);
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
