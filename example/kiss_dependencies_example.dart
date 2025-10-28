import 'package:kiss_dependencies/kiss_dependencies.dart';

class Logger {
  void log(String message) => print('LOG: $message');
}

void main() {
  register<String>(() => 'Hello world');
  print(resolve<String>());

  register<Logger>(Logger.new);
  resolve<Logger>().log('Started');

  registerImmediate<String>('Production', identifier: 'env');
  print('Environment: ${resolve<String>(identifier: 'env')}');

  register<ObjectFactory<String, String>>(
    () => ObjectFactory<String, String>((context) => 'Hello $context'),
  );
  print(resolve<ObjectFactory<String, String>>().build('Monkey'));
  print(resolve<ObjectFactory<String, String>>().build('Elephant'));

  overrideDependency<String>(() => 'Goodbye world');
  print(resolve<String>());
}
