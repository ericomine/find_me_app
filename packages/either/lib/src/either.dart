import 'package:equatable/equatable.dart';

abstract class Either<L, R> extends Equatable {
  const Either();

  bool get isLeft;
  bool get isRight;

  T fold<T>({
    required T Function(L left) onLeft,
    required T Function(R right) onRight,
  });

  R getOrElse(R Function(L left) orElse);
}

class Left<L, R> extends Either<L, R> {
  const Left(this._value);

  final L _value;

  @override
  bool get isLeft => true;

  @override
  bool get isRight => false;

  @override
  T fold<T>({
    required T Function(L left) onLeft,
    required T Function(R right) onRight,
  }) {
    return onLeft(_value);
  }

  @override
  R getOrElse(R Function(L left) orElse) => orElse(_value);

  @override
  List<Object?> get props => [_value];
}

class Right<L, R> extends Either<L, R> {
  const Right(this._value);

  final R _value;

  @override
  bool get isLeft => false;

  @override
  bool get isRight => true;

  @override
  T fold<T>({
    required T Function(L left) onLeft,
    required T Function(R right) onRight,
  }) {
    return onRight(_value);
  }

  @override
  R getOrElse(R Function(L left) orElse) => _value;

  @override
  List<Object?> get props => [_value];
}
