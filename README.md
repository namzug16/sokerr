# SOKERR

Simple OK Err

Simple Result sum type for Dart

## Why?

There are already many other packages that offer a similar implementation 
of a Result type, the problem is that all of them try to do too 
many things at the same time, like implementing methods that could be
simply avoided by using [Dart's switch expressions](https://dart.dev/language/branches#switch-expressions).
So I decided to implement my own **SIMPLE** Result.

> I found myself copy-pasting this code on all my new projects and got tired of it. So here we are.

## Examples

Return a `Result` from a function

```dart
Future<Result<(), String>> updateTable() async {
  ...
  if (somethingWentWrong) {
    return Err("My error");
  }
  ...

  /// Want to know if successful but don't want to return anything?
  /// return an empty pattern `()`
  return Ok(());
}
```

Wrap a Future (extension)

```dart
Future<Result<String, Object?>> mySafeFunction() async {
  final res = await unsafeFutureFromAPackageIDidNotWrite().result();

  ...

  return switch (res) {
    Ok(:final ok) => () {
        ...
        return Ok("");
      }(),
    Err() => res,
  };
}
```

Wrap a Function (extension)

```dart
void main() {
  /// JWT's constructor throws an exception when the token has expired
  final res = (() => JWT.verify(token, SecretKey(secret))).result();
  ...
}
```

How can I map a result?

```dart
void main() {
  final Result<Data, ()> res = getResult();

  final orElse = "orElse";

  final String mappedValue = switch (res) { Ok(:final ok) => ok.myVal, Err() => orElse };
}
```
