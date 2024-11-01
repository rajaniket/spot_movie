import 'dart:async';

class Debouncer {
  Debouncer({required this.delay});

  final Duration delay;
  Timer? _timer;

  void run(void Function() action) {
    // Cancel any existing timer
    _timer?.cancel();

    // Start a new timer to trigger the action after the delay
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
