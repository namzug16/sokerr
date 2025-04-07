import "package:meta/meta.dart";

/// Represents either a Success `Ok` or an Error `Err`
@immutable
sealed class Result<O, E> {
  const Result();

  /// is ok?
  bool get isOk => switch (this) {
        Ok() => true,
        _ => false,
      };

  /// is err?
  bool get isErr => !isOk;

  /// Unwraps the value of a possible Ok, in case of Err it will throw an State Error
  O get unwrap => switch (this) {
        Ok(:final ok) => ok,
        Err() => throw StateError("Cannot unwrap <O> in Err"),
      };

  /// Unwraps the value of a possible Err, in case of Ok it will throw an State Error
  E get unwrapErr => switch (this) {
        Ok() => throw StateError("Cannot unwrap <E> in Ok"),
        Err(:final err) => err,
      };

  @override
  String toString() => switch (this) {
        Ok(:final ok) => "Ok($ok)",
        Err(:final err, :final st) => "Err($err)\nStackTrace: $st",
      };
}

/// Represents a Success
@immutable
final class Ok<O, E> extends Result<O, E> {
  /// Create an `Ok` Result with the given value
  const Ok(this.ok);

  /// Wrapped value
  final O ok;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Ok<O, E> && runtimeType == other.runtimeType && ok == other.ok;

  @override
  int get hashCode => ok.hashCode;
}

/// Represents an Error
@immutable
final class Err<O, E> extends Result<O, E> {
  /// Create an `Err` Result with the given error and stack trace
  const Err(this.err, this.st);

  /// Wrapped error value
  final E err;

  /// Stack trace. Specially useful when debugging
  final StackTrace st;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Err<O, E> && runtimeType == other.runtimeType && err == other.err && st == other.st;

  @override
  int get hashCode => Object.hash(err, st);
}
