import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

Widget _buildWhyTraceAgroSection(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isMobile = screenWidth < 768;

  final reasons = [
    {
      'title': 'Regulatory Moat',
      'description': 'ISA 2025 compliance creates barriers to entry',
      'stat': '2025',
    },
    {
      'title': 'Climate Resilience',
      'description': 'Solar-powered operations with 70% energy savings',
      'stat': '70%',
    },
    {
      'title': 'Premium Pricing',
      'description': '90–267% uplift on processed commodities',
      'stat': '267%',
    },
    {
      'title': 'Smallholder Impact',
      'description': 'Receipt financing serving 8,000+ farmers',
      'stat': '8K+',
    },
  ];

  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: isMobile ? 20 : 80,
      vertical: isMobile ? 60 : 100,
    ),
    decoration: const BoxDecoration(color: Color(0xFF0F1419)),
    child: Column(
      children: [
        Text(
          'Why TraceAgro?',
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3, end: 0),

        const SizedBox(height: 60),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : 2,
            crossAxisSpacing: 32,
            mainAxisSpacing: 32,
            childAspectRatio: isMobile ? 2.5 : 2,
          ),
          itemCount: reasons.length,
          itemBuilder: (context, index) {
            return _buildReasonCard(
              reasons[index]['title']!,
              reasons[index]['description']!,
              reasons[index]['stat']!,
              index,
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildReasonCard(
  String title,
  String description,
  String stat,
  int index,
) {
  return VisibilityDetector(
    key: Key('reason-$index'),
    onVisibilityChanged: (info) {},
    child:
        Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF1A2332), const Color(0xFF0F1419)],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF22C55E).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          description,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white70,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    stat,
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF22C55E).withOpacity(0.3),
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
            .slideX(begin: 0.3, end: 0),
  );
}
