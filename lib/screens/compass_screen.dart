import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sensor_provider.dart';

class CompassScreen extends StatelessWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SensorProvider>().compassData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kompas'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Jarum kompas
          Center(
            child: SizedBox(
              width: 280,
              height: 280,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Lingkaran luar kompas
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.cyan,
                        width: 3,
                      ),
                      color: Colors.grey[900],
                    ),
                  ),
                  // Label arah
                  ..._buildDirectionLabels(),
                  // Jarum kompas berputar
                  Transform.rotate(
                    angle: -data.heading * (math.pi / 180),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Jarum merah (utara)
                        Container(
                          width: 4,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        // Titik tengah
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        // Jarum putih (selatan)
                        Container(
                          width: 4,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Heading dalam derajat
          Text(
            '${data.heading.toStringAsFixed(1)}°',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
          ),

          // Arah
          Text(
            data.direction,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 16),
          Text(
            _getDirectionFull(data.direction),
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDirectionLabels() {
    final labels = {
      'U': const Offset(0, -110),
      'S': const Offset(0, 110),
      'T': const Offset(110, 0),
      'B': const Offset(-110, 0),
    };

    return labels.entries.map((e) {
      return Positioned(
        left: 140 + e.value.dx - 10,
        top: 140 + e.value.dy - 10,
        child: Text(
          e.key,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: e.key == 'U' ? Colors.red : Colors.white,
          ),
        ),
      );
    }).toList();
  }

  String _getDirectionFull(String dir) {
    const map = {
      'U': 'Utara',
      'TL': 'Timur Laut',
      'T': 'Timur',
      'TG': 'Tenggara',
      'S': 'Selatan',
      'BD': 'Barat Daya',
      'B': 'Barat',
      'BL': 'Barat Laut',
    };
    return map[dir] ?? '';
  }
}