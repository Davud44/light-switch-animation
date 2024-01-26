import 'package:flutter/material.dart';

class LightSwitchScreen extends StatefulWidget {
  const LightSwitchScreen({super.key});

  @override
  State<LightSwitchScreen> createState() => _LightSwitchScreenState();
}

class _LightSwitchScreenState extends State<LightSwitchScreen>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> _switchNotifier = ValueNotifier(true);
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animation =
        Tween<double>(begin: 0.0, end: 90.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _switchNotifier,
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: Color(value ? 0xFFF1D621 : 0xFF26252E),
            body: Stack(
              children: [
                Positioned(
                  right: 50,
                  bottom: MediaQuery.of(context).size.height * 0.3,
                  child: GestureDetector(
                    onTap: () async {
                      if (!_animationController.isAnimating) {
                        _animationController.forward();
                        await Future.delayed(const Duration(milliseconds: 200));
                        _animationController.reverse();
                        _switchNotifier.value = !_switchNotifier.value;
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 150,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: value
                              ? Colors.black.withOpacity(0.2)
                              : Colors.black,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white.withOpacity(0.3),
                                blurRadius: 2,
                                offset: const Offset(2, 2))
                          ],
                          borderRadius: BorderRadius.circular(50)),
                      alignment: Alignment.topCenter,
                      child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _animation.value),
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                Positioned(
                  right: 75,
                  child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Container(
                          width: 2,
                          height: 514 + _animation.value,
                          color: Colors.white,
                        );
                      }),
                )
              ],
            ),
          );
        });
  }
}
