import 'package:sokerr/src/result.dart';
import 'package:sokerr/src/result_extension.dart';
import 'package:test/test.dart';

void main() {
  group('Result Tests', () {
    test('Ok instance behaves correctly', () {
      const ok = Ok<int, String>(42);
      expect(ok.isOk, isTrue);
      expect(ok.isErr, isFalse);
      expect(ok.unwrap, equals(42));
      expect(() => ok.unwrapErr, throwsA(isA<StateError>()));
      expect(ok.toString(), equals('Ok(42)'));
    });

    test('Err instance behaves correctly', () {
      final stackTrace = StackTrace.current;
      final err = Err<int, String>('error message', stackTrace);
      expect(err.isErr, isTrue);
      expect(err.isOk, isFalse);
      expect(() => err.unwrap, throwsA(isA<StateError>()));
      expect(err.unwrapErr, equals('error message'));
      expect(err.toString(), contains('Err(error message)'));
      expect(err.toString(), contains('StackTrace:'));
    });

    test('Ok equality works as expected', () {
      const ok1 = Ok<int, String>(100);
      const ok2 = Ok<int, String>(100);
      const ok3 = Ok<int, String>(200);
      expect(ok1, equals(ok2));
      expect(ok1, isNot(equals(ok3)));
    });

    test('Err equality works as expected', () {
      final stackTrace = StackTrace.current;
      final err1 = Err<int, String>('error', stackTrace);
      final err2 = Err<int, String>('error', stackTrace);
      final err3 = Err<int, String>('different error', stackTrace);
      expect(err1, equals(err2));
      expect(err1, isNot(equals(err3)));
    });
  });

  group('FutureResult Extension Tests', () {
    test('Future completes normally and returns Ok', () async {
      Future<int> future() async => 55;
      final result = await future().result();
      expect(result.isOk, isTrue);
      expect(result.unwrap, equals(55));
    });

    test('Future completes with error and returns Err', () async {
      final error = Exception('future error');
      Future<int> future() async => throw error;
      final result = await future().result();
      expect(result.isErr, isTrue);
      expect(result.unwrapErr, equals(error));
    });
  });

  group('FunctionResult Extension Tests', () {
    test('Function throws an Exception', () async {
      final error = Exception('future error');
      int fn() => throw error;
      final result = fn.result();
      expect(result.isErr, isTrue);
      expect(result.unwrapErr, equals(error));
    });
  });
}
