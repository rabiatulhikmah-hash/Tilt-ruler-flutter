import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sensor_provider.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<SensorProvider>().tiltData;

    // Posisi bubble: pitch & roll dikonversi ke offset layar
    double bubbleX = (data.roll / 45).clamp(-1.0, 1.0);
    double bubbleY = (data.pitch / 45).clamp(-1.0, 1.0);

    final isLevel = data.isLevel;
    final levelColor = isLevel ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bubble Level'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Bubble level visual
          Expanded(
            flex: 3,
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final size = constraints.maxWidth;
                      final center = size / 2;
                      final maxOffset = size * 0.35;
                      final bubbleSize = size * 0.18;

                      return Stack(
                        children: [
                          // Lingkaran luar
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: levelColor,
                                width: 3,
                              ),
                              color: Colors.grey[900],
                            ),
                          ),
                          // Garis silang tengah
                          Center(
                            child: Container(
                              width: 1,
                              height: size,
                              color: Colors.grey[700],
                            ),
                          ),
                          Center(
                            child: Container(
                              width: size,
                              height: 1,
                              color: Colors.grey[700],
                            ),
                          ),
                          // Lingkaran target tengah
                          Center(
                            child: Container(
                              width: size * 0.2,
                              height: size * 0.2,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey[600]!,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                          // Bubble
                          Positioned(
                            left: center +
                                (bubbleX * maxOffset) -
                                bubbleSize / 2,
                            top: center +
                                (bubbleY * maxOffset) -
                                bubbleSize / 2,
                            child: Container(
                              width: bubbleSize,
                              height: bubbleSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: levelColor.withOpacity(0.8),
                                boxShadow: [
                                  BoxShadow(
                                    color: levelColor.withOpacity(0.4),
                                    blurRadius: 12,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // Status level
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              isLevel ? '✅ RATA / LEVEL' : '⚠️ BELUM RATA',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: levelColor,
              ),
            ),
          ),

          // Nilai pitch & roll
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AngleCard(
                  label: 'Pitch',
                  value: data.pitch,
                  icon: Icons.height,
                ),
                _AngleCard(
                  label: 'Roll',
                  value: data.roll,
                  icon: Icons.swap_horiz,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _AngleCard extends StatelessWidget {
  final String label;
  final double value;
  final IconData icon;

  const _AngleCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.cyan),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: Colors.grey[400])),
            Text(
              '${value.toStringAsFixed(1)}°',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
          ],
        ),
      ),
    );
  }
}