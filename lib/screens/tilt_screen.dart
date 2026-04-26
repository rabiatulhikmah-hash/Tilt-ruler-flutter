import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sensor_provider.dart';

class TiltScreen extends StatelessWidget {
  const TiltScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SensorProvider>().tiltData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tilt Angle'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Kemiringan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Pitch bar
            _SensorBar(
              label: 'Pitch (Maju/Mundur)',
              value: data.pitch,
              color: Colors.orange,
              icon: Icons.height,
            ),
            const SizedBox(height: 12),

            // Roll bar
            _SensorBar(
              label: 'Roll (Kiri/Kanan)',
              value: data.roll,
              color: Colors.purple,
              icon: Icons.swap_horiz,
            ),
            const SizedBox(height: 24),

            const Text(
              'Rotasi (Gyroscope)',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Gyro X
            _SensorBar(
              label: 'Gyro X',
              value: data.gyroX,
              color: Colors.red,
              icon: Icons.rotate_right,
              maxValue: 360,
            ),
            const SizedBox(height: 12),

            // Gyro Y
            _SensorBar(
              label: 'Gyro Y',
              value: data.gyroY,
              color: Colors.green,
              icon: Icons.rotate_left,
              maxValue: 360,
            ),
            const SizedBox(height: 12),

            // Gyro Z
            _SensorBar(
              label: 'Gyro Z',
              value: data.gyroZ,
              color: Colors.blue,
              icon: Icons.rotate_90_degrees_ccw,
              maxValue: 360,
            ),
          ],
        ),
      ),
    );
  }
}

class _SensorBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final IconData icon;
  final double maxValue;

  const _SensorBar({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    this.maxValue = 90,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (value.abs() / maxValue).clamp(0.0, 1.0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color, size: 18),
                    const SizedBox(width: 8),
                    Text(label),
                  ],
                ),
                Text(
                  '${value.toStringAsFixed(1)}°/s',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percent,
                backgroundColor: Colors.grey[800],
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}