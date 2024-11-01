import 'package:flutter/material.dart';

extension IterableExtensions on Iterable<Widget> {
  Iterable<Widget> expanded(List<int> element) sync* {
    assert(element.length == length, 'flexible list must be good dummy');
    final iterator = this.iterator;
    int elementCount = 0;
    while (iterator.moveNext()) {
      yield Expanded(flex: element[elementCount], child: iterator.current);
      elementCount++;
    }
  }

  Iterable<Widget> addSpaces({double? height, double? width}) sync* {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      yield iterator.current;
      while (iterator.moveNext()) {
        yield SizedBox(
          height: height,
          width: width,
        );
        yield iterator.current;
      }
    }
  }
}
