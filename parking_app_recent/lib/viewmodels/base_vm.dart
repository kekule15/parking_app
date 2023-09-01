
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/providers/providers.dart';

class BaseViewModel extends ChangeNotifier {
  final Ref ref;

  BaseViewModel(this.ref);
  bool _busy = false;

  bool get busy => _busy;

  void setErrorMessage(String message) {
    ref.read(errorState.notifier).state = message;
  }

  void setContentError(String message) {
    ref.read(contentErrorState.notifier).state = message;
  }

  void setBusy(bool value) {
    ref.read(loadingState.notifier).state = value;
    _busy = value;
    notifyListeners();
  }

  setPinErrorMessage(String message) {
    ref.read(pinErrorState.notifier).state = message;
  }

  bool validateAndSave(GlobalKey<FormState> key) {
    final form = key.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

}
