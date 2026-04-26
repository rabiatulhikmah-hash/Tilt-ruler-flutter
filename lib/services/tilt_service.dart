import 'dart:math' as math;
import 'package:sensors_plus/sensors_plus.dart';
import '../models/sensor_data.dart';

class TiltService {
  static const double _levelThreshold = 2.0; // toleransi level dalam derajat

  double _gyroX = 0, _gyroY = 0, _gyroZ = 0;

  // Stream gabungan accelerometer untuk pitch & roll
  Stream<TiltData> get tiltStream {
    return accelerometerEventStream().map((event) {
      // Hitung pitch (kemiringan maju/mundur)
      double pitch = math.atan2(
            event.y,
            math.sqrt(event.x * event.x + event.z * event.z),
          ) *
          (180 / math.pi);

      // Hitung roll (kemiringan kiri/kanan)
      double roll = math.atan2(
            event.x,
            math.sqrt(event.y * event.y + event.z * event.z),
          ) *
          (180 / math.pi);

      // HP dianggap level jika pitch & roll mendekati 0
      bool isLevel =
          pitch.abs() < _levelThreshold && roll.abs() < _levelThreshold;

      return TiltData(
        pitch: pitch,
        roll: roll,
        gyroX: _gyroX,
        gyroY: _gyroY,
        gyroZ: _gyroZ,
        isLevel: isLevel,
      );
    });
  }

  // Stream gyroscope terpisah, update nilai internal
  Stream<void> get gyroStream {
    return gyroscopeEventStream().map((event) {
      _gyroX = event.x * (180 / math.pi); // konversi rad/s ke derajat/s
      _gyroY = event.y * (180 / math.pi);
      _gyroZ = event.z * (180 / math.pi);
    });
  }
}