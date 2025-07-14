import 'package:kiss_dependencies/kiss_dependencies.dart';
import 'package:test/test.dart';

class A {}

class A2 extends A {}

class B {}

void main() {
  group(
    'A group of tests',
    () {
      register<String>(() => 'Hello world');
      register<A>(A.new);
      register<A>(A.new, identifier: 'alt');
      test('First Test', () {
        expect(resolve<String>(), 'Hello world');
      });

      register<ObjectFactory<String, String>>(
        () => ObjectFactory<String, String>(
          (context) => 'Hello world 2 $context',
        ),
        identifier: 'factory',
      );

      test('Second Test', () {
        final factory = resolve<ObjectFactory<String, String>>(
          identifier: 'factory',
        )..build('Monkey');
        expect(factory.build('Monkey'), 'Hello world 2 Monkey');
      });

      test(
        'Third Test',
        () {
          expect(
            () => resolve<B>(),
            throwsA(
              isA<UnregisteredDependencyException>(),
            ),
          );
        },
      );

      test(
        'Fourth Test',
        () {
          expect(resolve<A>(identifier: 'alt'), isA<A>());
        },
      );

      test(
        'Fifth Test',
        () {
          expect(
            () => register<A>(A.new),
            throwsA(
              isA<AlreadyRegisteredException>(),
            ),
          );
        },
      );

      test('Override dependency', () {
        overrideDependency<A>(A2.new);
        expect(resolve<A>(), isA<A2>());
      });

      test('Unregister dependency', () {
        register<B>(B.new);
        expect(resolve<B>(), isA<B>());
        unregister<B>();
        expect(
          () => resolve<B>(),
          throwsA(
            isA<UnregisteredDependencyException>(),
          ),
        );
      });

      test('Unregister dependency with identifier', () {
        register<B>(B.new, identifier: 'test');
        expect(resolve<B>(identifier: 'test'), isA<B>());
        unregister<B>(identifier: 'test');
        expect(
          () => resolve<B>(identifier: 'test'),
          throwsA(
            isA<UnregisteredDependencyException>(),
          ),
        );
      });

      test('Register immediate', () {
        registerImmediate<B>(B());
        expect(resolve<B>(), isA<B>());
      });
    },
  );
}
