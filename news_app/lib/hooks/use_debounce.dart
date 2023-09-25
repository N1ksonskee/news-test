import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef DebouncedFn = void Function({required VoidCallback fn, int waitForMs});

DebouncedFn useDebounce() => use(const Debounce());

class Debounce extends Hook<DebouncedFn> {
  const Debounce();

  @override
  DebounceState createState() => DebounceState();
}

class DebounceState extends HookState<DebouncedFn, Debounce> {
  Timer? _debounceTimer;

  @override
  void initHook() {
    super.initHook();
  }

  void debounce({required VoidCallback fn, int waitForMs = 300}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: waitForMs), fn);
  }

  @override
  DebouncedFn build(BuildContext context) {
    return debounce;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
