import 'package:sensors_plus/sensors_plus.dart';

abstract class GyroscopeDataSource {
  Stream<GyroscopeEvent> getGyroscopeStream();
}
