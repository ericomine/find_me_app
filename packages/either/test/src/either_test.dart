// ignore_for_file: cascade_invocations

import 'package:either/either.dart';
import 'package:test/test.dart';

void main() {
  const leftString = 'Left';
  const rightString = 'Right';

  group('Left', () {
    test('Deve ser do tipo Left e Either', () {
      const sut = Left<String, dynamic>(leftString);

      expect(sut, isA<Left>());
      expect(sut, isA<Either<String, dynamic>>());
    });

    test('equals e hashCode devem ser iguais', () {
      const left1 = Left<String, dynamic>(rightString);
      const left2 = Left<String, dynamic>(rightString);

      expect(left1, equals(left2));
      expect(left1.hashCode, left2.hashCode);
    });

    test('isLeft deve retornar true', () {
      const sut = Left<String, dynamic>(leftString);

      expect(sut.isRight, isFalse);
      expect(sut.isLeft, isTrue);
    });

    test('fold onLeft deve conter "Left"', () {
      const sut = Left<String, dynamic>(leftString);

      sut.fold(
        onLeft: (left) {
          expect(left, isA<String>());
          expect(left, leftString);
        },
        onRight: (dynamic _) {},
      );
    });

    test('get deve retornar null e orElse deve conter "Left"', () {
      const sut = Left<String, dynamic>(leftString);

      final dynamic rightOrLeft = sut.getOrElse((left) {
        expect(left, isA<String>());
        expect(left, leftString);
      });
      expect(rightOrLeft, isNull);
    });
  });

  group('Right', () {
    test('Deve ser do tipo Right e Either', () {
      const sut = Right<dynamic, String>(rightString);

      expect(sut, isA<Right>());
      expect(sut, isA<Either<dynamic, String>>());
    });

    test('equals e hashCode devem ser iguais', () {
      const right1 = Right<dynamic, String>(rightString);
      const right2 = Right<dynamic, String>(rightString);

      expect(right1, equals(right2));
      expect(right1.hashCode, right2.hashCode);
    });

    test('isRight deve retornar true', () {
      const sut = Right<dynamic, String>(rightString);

      expect(sut.isLeft, isFalse);
      expect(sut.isRight, isTrue);
    });

    group('fold', () {
      test('onRight deve conter "Right"', () {
        const sut = Right<dynamic, String>(rightString);

        sut.fold(
          onLeft: (dynamic _) {},
          onRight: (right) {
            expect(right, isA<String>());
            expect(right, rightString);
          },
        );
      });
    });

    test('get deve retornar "Right"', () {
      const sut = Right<dynamic, String>(rightString);

      final rightOrLeft = sut.getOrElse((dynamic _) => leftString);
      expect(rightOrLeft, isNotNull);
      expect(rightOrLeft, rightString);
    });
  });
}
