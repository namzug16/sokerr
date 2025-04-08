import "package:sokerr/src/result.dart";

/// Result extension on Future
extension FutureResult<O> on Future<O> {
  /// Wraps a Future with a Result, if no exception is thrown
  /// returns `Ok` otherwise returns `Err`
  Future<Result<O, Object?>> result() async {
    late Result<O, Object?> res;
    await then(
      (ok) {
        res = Ok(ok);
      },
      onError: (Object? err, StackTrace st) {
        res = Err(err, st);
      },
    );
    return res;
  }
}

/// Result extension on Function
extension FunctionExtensions<T> on T Function() {
  /// Wraps a Function with a Result, if no exception is thrown
  /// returns `Ok` otherwise returns `Err`
  Result<T, Object?> result() {
    try {
      ///
      //ignore: avoid_dynamic_calls
      return Ok(call());
    } catch (e, st) {
      return Err(e, st);
    }
  }
}
