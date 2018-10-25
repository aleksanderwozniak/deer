import 'dart:async';

import 'package:rxdart/rxdart.dart';

class InMemory<T> {
  T seedValue;
  BehaviorSubject<T> _subject;

  InMemory({this.seedValue});

  T get value => _subject?.value;

  Stream<T> stream() {
    if (_subject == null) {
      _subject = BehaviorSubject(
          seedValue: seedValue,
          onCancel: () {
            _subject.close();
            _subject = null;
          });
    }

    return _subject.distinct();
  }

  void add(T value) {
    if (_subject == null) {
      return;
    }

    _subject.add(value);
  }
}
