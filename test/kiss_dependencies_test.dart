import 'package:kiss_dependencies/kiss_dependencies.dart';
import 'package:test/test.dart';

class A {}

class B {}

void main() {
  group(
    'A group of tests',
    () {
      register<String>('Hello world');
      register<A>(A());
      register<A>(A(), identifier: 'alt');
      test('First Test', () {
        expect(resolve<String>(), 'Hello world');
      });

      register<ObjectFactory<String, String>>(
        ObjectFactory<String, String>(
          (context) => 'Hello world 2 $context',
        ),
        identifier: 'factory',
      );

      test('Second Test', () {
        final factory = resolve<ObjectFactory<String, String>>(
          identifier: 'factory',
        );
        factory.build('Monkey');
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
    },
  );
}
