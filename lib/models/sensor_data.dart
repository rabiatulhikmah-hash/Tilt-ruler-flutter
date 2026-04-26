class TiltData {
  final double pitch; // kemiringan maju/mundur (derajat)
  final double roll;  // kemiringan kiri/kanan (derajat)
  final double gyroX;
  final double gyroY;
  final double gyroZ;
  final bool isLevel;

  TiltData({
    required this.pitch,
    required this.roll,
    required this.gyroX,
    required this.gyroY,
    required this.gyroZ,
    required this.isLevel,
  });

  factory TiltData.zero() => TiltData(
        pitch: 0,
        roll: 0,
        gyroX: 0,
        gyroY: 0,
        gyroZ: 0,
        isLevel: false,
      );
}

class CompassData {
  final double heading; // 0-360 derajat
  final String direction; // N, NE, E, SE, S, SW, W, NW

  CompassData({required this.heading, required this.direction});

  factory CompassData.zero() =>
      CompassData(heading: 0, direction: 'N');
}