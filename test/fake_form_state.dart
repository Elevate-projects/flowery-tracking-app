import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeFormState extends Fake implements FormState {
  @override
  bool validate() => true;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FakeFormState';
  }
}

class FakeGlobalKey extends Fake implements GlobalKey<FormState> {
  final FormState _state;
  FakeGlobalKey(this._state);

  @override
  FormState? get currentState => _state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FakeGlobalKey';
  }
}
