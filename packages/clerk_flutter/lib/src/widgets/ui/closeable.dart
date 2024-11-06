import 'package:flutter/material.dart';

class Closeable extends StatelessWidget {
  static const _defaultDuration = Duration(milliseconds: 250);

  final Duration duration;
  final double _value;
  final Widget child;

  const Closeable({
    super.key,
    bool? closed,
    bool? open,
    required this.child,
    this.duration = _defaultDuration,
  })  : assert((closed is bool) || (open is bool), 'One of closed or open required'),
        assert((closed is bool) != (open is bool), 'Only one of closed or open allowed'),
        _value = (open == true || closed == false) ? 1 : 0;

  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: duration,
      opacity: _value,
      child: AnimatedAlign(
        duration: duration,
        alignment: Alignment.topLeft,
        heightFactor: _value,
        child: child,
      ),
    );
  }
}
