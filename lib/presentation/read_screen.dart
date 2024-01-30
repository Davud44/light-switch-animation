import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  static const String _loremTxt =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  final ValueNotifier<bool> _switchNotifier = ValueNotifier(false);
  final ValueNotifier<double> _cordPositionNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF26252E),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  'assets/icons/lamp.svg',
                  height: 140,
                )),
            ValueListenableBuilder(
                valueListenable: _switchNotifier,
                builder: (context, lightOn, child) {
                  return Positioned(
                    top: 115,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: lightOn ? MediaQuery.of(context).size.height : 0,
                      padding:
                          const EdgeInsets.only(top: 140, left: 20, right: 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.7),
                                Colors.transparent
                              ]),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(300),
                            topRight: Radius.circular(300),
                          )),
                      child: const Text(
                        _loremTxt,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                }),
            Positioned(
              right: 20,
              child: ValueListenableBuilder(
                  valueListenable: _cordPositionNotifier,
                  builder: (context, cordPosition, child) {
                    return Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 700),
                          width: 2,
                          curve: Curves.elasticOut,
                          height: 100 + cordPosition,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onVerticalDragStart: (details) {},
                          onVerticalDragUpdate: (details) {
                            double y = details.localPosition.dy;
                            if (y > -50 && y < 80) {
                              _cordPositionNotifier.value = y;
                            }
                          },
                          onVerticalDragEnd: (details) {
                            if (_cordPositionNotifier.value > 40) {
                              _switchNotifier.value = !_switchNotifier.value;
                            }
                            _cordPositionNotifier.value = 0;
                          },
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        )
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
