import 'package:counter_app/logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class StepperTouch extends StatefulWidget {
  const StepperTouch({
    Key? key,
  }) : super(key: key);

  @override
  _Stepper2State createState() => _Stepper2State();
}

class _Stepper2State extends State<StepperTouch>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;
  double? _startAnimationPosX;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, lowerBound: -0.5, upperBound: 0.5);
    _controller!.value = 0.0;
    _controller!.addListener(() {});

    _animation = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(0.0, 1.5))
        .animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    _animation = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(0.0, 1.5))
        .animate(_controller!);
  }

  @override
  Widget build(BuildContext context) {
    var d = 55.0;
    var e = 12.0;
    return FittedBox(
      // ignore: sized_box_for_whitespace
      child: Container(
        width: d.w,
        height: e.h,
        child: Material(
          type: MaterialType.canvas,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(60.0),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: 10.0,
                bottom: null,
                child: Icon(
                  Icons.remove,
                  size: 10.0.w,
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.7),
                ),
              ),
              Positioned(
                right: 10.0,
                top: null,
                child: Icon(
                  Icons.add,
                  size: 10.0.w,
                  color: Theme.of(context).iconTheme.color!.withOpacity(0.7),
                ),
              ),
              GestureDetector(
                onHorizontalDragStart: _onPanStart,
                onHorizontalDragUpdate: _onPanUpdate,
                onHorizontalDragEnd: _onPanEnd,
                child: SlideTransition(
                  position: _animation!,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Theme.of(context).colorScheme.primary,
                      shape: const CircleBorder(),
                      elevation: 5.0,
                      child: Center(
                        child: Icon(
                          Icons.trip_origin,
                          size: 10.0.w,
                          color: Theme.of(context)
                              .iconTheme
                              .color!
                              .withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double offsetFromGlobalPos(Offset globalPosition) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset local = box.globalToLocal(globalPosition);
    _startAnimationPosX = ((local.dx * 0.75) / box.size.width) - 0.4;

    return ((local.dx * 0.75) / box.size.width) - 0.4;
  }

  void _onPanStart(DragStartDetails details) {
    _controller!.stop();
    _controller!.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _controller!.value = offsetFromGlobalPos(details.globalPosition);
  }

  void _onPanEnd(DragEndDetails details) {
    _controller!.stop();

    if (_controller!.value <= -0.20) {
      context.read<CounterCubit>().decrement();
    } else if (_controller!.value >= 0.20) {
      context.read<CounterCubit>().increment();
    }

    final SpringDescription _kDefaultSpring =
        SpringDescription.withDampingRatio(
      mass: 0.9,
      stiffness: 250.0,
      ratio: 0.6,
    );

    _controller!.animateWith(
        SpringSimulation(_kDefaultSpring, _startAnimationPosX!, 0.0, 0.0));
  }
}
