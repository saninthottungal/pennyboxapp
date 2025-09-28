import 'package:flutter_test/flutter_test.dart';
import 'package:pennyboxapp/core/utils/list.utils.dart';

void main() {
  late List<int> numbers;

  setUp(() {
    numbers = [1, 2, 3, 4, 5];
  });

  group("nextOrNull", () {
    test(
      "should return next value when index is valid",
      () {
        final nextNumber = numbers.nextOrNull(0);
        expect(nextNumber, numbers[1]);
      },
    );

    test(
      "should return null when index is of last element",
      () {
        final nextNumber = numbers.nextOrNull(4);
        expect(nextNumber, isNull);
      },
    );

    test(
      "should return null when index is out of bound",
      () {
        final nextNumber = numbers.nextOrNull(10);
        expect(nextNumber, isNull);
      },
    );

    test(
      "should return null when index is negative",
      () {
        final nextNumber = numbers.nextOrNull(-1);
        expect(nextNumber, isNull);
      },
    );

    test(
      "should handle empty list",
      () {
        final empty = <int>[];
        final nextNumber = empty.nextOrNull(0);
        expect(nextNumber, isNull);
      },
    );
  });

  group(
    "previousOrNull",
    () {
      test(
        "should return previous value if index is valid",
        () {
          final prevNumber = numbers.previousOrNull(1);
          expect(prevNumber, numbers[0]);
        },
      );

      test(
        "should return null if index is of first element",
        () {
          final prev = numbers.previousOrNull(0);
          expect(prev, isNull);
        },
      );

      test(
        "should return null if index is out of range",
        () {
          final prev = numbers.previousOrNull(10);
          expect(prev, isNull);
        },
      );

      test(
        "should return null if index is negative",
        () {
          final prev = numbers.previousOrNull(-5);
          expect(prev, isNull);
        },
      );

      test(
        "should return null if list is empty",
        () {
          final empty = List<int>.empty();
          final prev = empty.previousOrNull(12);
          expect(prev, isNull);
        },
      );
    },
  );
}
