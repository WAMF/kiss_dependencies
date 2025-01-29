import 'package:kiss_dependencies/kiss_dependencies.dart';

void main() {
  register<String>('Hello world');
  print(resolve<String>());

  register<ObjectFactory<String, String>>(
    ObjectFactory<String, String>(
      (context) => 'Hello $context',
    ),
  );

  print(resolve<ObjectFactory<String, String>>().build('Monkey'));
}
