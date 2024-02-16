import 'package:sensors_plus/sensors_plus.dart';

import 'GyroscopeDataSource.dart';

class InternalGyroscopeDataSource implements GyroscopeDataSource {
  @override
  Stream<GyroscopeEvent> getGyroscopeStream() {
    return SensorsPlatform.instance.gyroscopeEventStream();
  }
}