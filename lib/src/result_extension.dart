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
