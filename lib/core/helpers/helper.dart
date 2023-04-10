import 'dart:async';

import 'package:flutter/material.dart';

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class Debouncer {
  final Duration duration;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.duration});

  run(VoidCallback action) {
    if (null != _timer) {
      debugPrint('cancel');
      _timer!.cancel();
    }
    _timer = Timer(duration, action);
  }
}

extension StringEx on String {
  List<SText> parseDescription() {
    String storeStroke(int index, String end) {
      var nums = '';
      for (var i = index; i < length; i++) {
        if (this[i] != end) {
          nums += this[i];
        } else {
          return nums;
        }
      }
      throw Exception();
    }

    bool textEqual(int index, String sequence) {
      for (var i = index; i < length; i++) {
        final offset = i - index;
        if (offset == sequence.length) return true;
        if (this[i] != sequence[offset]) {
          return false;
        }
      }
      return true;
    }

    var currentLine = '';
    List<SText> lines = [];
    var lineEntry = '[character';

    void flushLast() {
      lines.add(SText(currentLine));
      currentLine = '';
    }

    var c = 0;
    while (c < length) {
      if (textEqual(c, lineEntry)) {
        c += lineEntry.length + 1;
        final num = storeStroke(c, ']');
        c += num.length + 1;
        final name = storeStroke(c, '[');
        c += name.length + '[/character]'.length;
        flushLast();
        lines.add(Url('$name ', int.parse(num)));
      } else {
        currentLine += this[c];
      }
      c++;
    }
    flushLast();
    return lines;
  }
}

class SText {
  final String text;

  @override
  String toString() => text;

  SText(this.text);
}

class Url extends SText {
  @override
  String toString() => "[$text:$id]";

  final int id;
  Url(
    super.text,
    this.id,
  );
}
