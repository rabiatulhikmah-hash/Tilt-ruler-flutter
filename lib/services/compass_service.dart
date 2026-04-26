import 'package:flutter_compass/flutter_compass.dart';
import '../models/sensor_data.dart';

class CompassService {
  Stream<CompassData> get compassStream {
    return FlutterCompass.events!.map((event) {
      double heading = event.heading ?? 0;
      if (heading < 0) heading += 360;

      return CompassData(
        heading: heading,
        direction: _getDirection(heading),
      );
    });
  }

  String _getDirection(double heading) {
    if (heading >= 337.5 || heading < 22.5) return 'U'; // Utara
    if (heading >= 22.5 && heading < 67.5) return 'TL'; // Timur Laut
    if (heading >= 67.5 && heading < 112.5) return 'T'; // Timur
    if (heading >= 112.5 && heading < 157.5) return 'TG'; // Tenggara
    if (heading >= 157.5 && heading < 202.5) return 'S'; // Selatan
    if (heading >= 202.5 && heading < 247.5) return 'BD'; // Barat Daya
    if (heading >= 247.5 && heading < 292.5) return 'B'; // Barat
    return 'BL'; // Barat Laut
  }
}