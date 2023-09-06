import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;

  void incrementCounter() {
    _counter++;

    rebuildUi();
  }
}