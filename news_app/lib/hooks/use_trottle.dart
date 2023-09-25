import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef TrottleFn = void Function({required VoidCallback fn, int waitForMs});

TrottleFn useTrottle() => use(const Trottle());

class Trottle extends Hook<TrottleFn> {
  const Trottle();

  @override
  TrottleState createState() => TrottleState();
}

class TrottleState extends HookState<TrottleFn, Trottle> {
  Timer? _debounceTimer;

  @override
  void initHook() {
    super.initHook();
  }

  void trottle({required VoidCallback fn, int waitForMs = 2000}) {
    if (_debounceTimer == null || !_debounceTimer!.isActive) {
      fn();
      _debounceTimer = Timer(Duration(milliseconds: waitForMs), () {});
    }
  }

  @override
  TrottleFn build(BuildContext context) {
    return trottle;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
