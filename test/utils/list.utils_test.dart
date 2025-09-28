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
        expect(nextNumber, 2);
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
}
