import 'dart:async';
import 'package:flutter/material.dart';
import '../models/sensor_data.dart';
import '../services/tilt_service.dart';
import '../services/compass_service.dart';

class SensorProvider extends ChangeNotifier {
  final TiltService _tiltService = TiltService();
  final CompassService _compassService = CompassService();

  TiltData tiltData = TiltData.zero();
  CompassData compassData = CompassData.zero();

  StreamSubscription? _tiltSub;
  StreamSubscription? _gyroSub;
  StreamSubscription? _compassSub;

  void initialize() {
    _tiltSub = _tiltService.tiltStream.listen((data) {
      tiltData = data;
      notifyListeners();
    });

    _gyroSub = _tiltService.gyroStream.listen((_) {
      notifyListeners();
    });

    _compassSub = _compassService.compassStream.listen((data) {
      compassData = data;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _tiltSub?.cancel();
    _gyroSub?.cancel();
    _compassSub?.cancel();
    super.dispose();
  }
}