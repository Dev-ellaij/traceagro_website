import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

Widget _buildWhatWeDoSection(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isMobile = screenWidth < 768;

  final services = [
    {
      'icon': Icons.warehouse,
      'title': 'Warehousing & Receipt Banking',
      'description':
          'SEC-compliant, NAIC-insured storage with collateral receipts for farmer financing',
    },
    {
      'icon': Icons.wb_sunny,
      'title': 'Solar Value-Add Processing',
      'description':
          'Dehulling, drying, milling, oil expelling with 70% energy savings',
    },
    {
      'icon': Icons.link,
      'title': 'Blockchain Traceability',
      'description':
          'VeChain-powered tracking, EUDR-ready for premium export markets',
    },
  ];

  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 20 : 80,
      vertical: isMobile ? 60 : 100,
    ),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0A0F1A), Color(0xFF1A2332)],
      ),
    ),
    child: Column(
      children: [
        Text(
          'What We Do',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),

        const SizedBox(height: 16),

        Text(
          'Transforming Nigeria\'s agricultural value chain',
          style: GoogleFonts.inter(fontSize: 18, color: Colors.white60),
        ).animate().fadeIn(duration: 800.ms, delay: 200.ms),

        const SizedBox(height: 60),

        Wrap(
          spacing: 32,
          runSpacing: 32,
          alignment: WrapAlignment.center,
          children: services.asMap().entries.map((entry) {
            return _buildServiceCard(
              entry.value['icon'] as IconData,
              entry.value['title'] as String,
              entry.value['description'] as String,
              entry.key,
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildServiceCard(
  IconData icon,
  String title,
  String description,
  int index,
) {
  return VisibilityDetector(
    key: Key('service-$index'),
    onVisibilityChanged: (info) {},
    child:
        Container(
              width: 320,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2332),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF22C55E).withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, size: 48, color: const Color(0xFF22C55E)),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(
              duration: 800.ms,
              delay: Duration(milliseconds: 300 * index),
            )
            .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
  );
}
