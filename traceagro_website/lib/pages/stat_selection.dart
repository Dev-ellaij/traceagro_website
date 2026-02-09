import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

Widget _buildStatsSection(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isMobile = screenWidth < 768;

  final stats = [
    {'number': '25+', 'label': 'Years Export\nExperience'},
    {'number': '28%', 'label': 'Price Premium\nAchieved'},
    {'number': '₦800M', 'label': 'Year 1 Target\nRevenue'},
    {'number': '8,000+', 'label': 'Smallholders\nto be Served'},
  ];

  return VisibilityDetector(
    key: const Key('stats-section'),
    onVisibilityChanged: (info) {},
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 40 : 80,
      ),
      decoration: const BoxDecoration(color: Color(0xFF0F1419)),
      child: Wrap(
        spacing: 32,
        runSpacing: 32,
        alignment: WrapAlignment.spaceAround,
        children: stats.asMap().entries.map((entry) {
          return _buildStatCard(
            entry.value['number']!,
            entry.value['label']!,
            entry.key,
          );
        }).toList(),
      ),
    ),
  );
}

Widget _buildStatCard(String number, String label, int index) {
  return VisibilityDetector(
    key: Key('stat-$index'),
    onVisibilityChanged: (info) {},
    child:
        Container(
              width: 200,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF1A2332), const Color(0xFF0F1419)],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF22C55E).withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF22C55E).withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    number,
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF22C55E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(
              duration: 800.ms,
              delay: Duration(milliseconds: 200 * index),
            )
            .slideY(begin: 0.3, end: 0)
            .then()
            .shimmer(duration: 2000.ms, delay: 1000.ms),
  );
}
