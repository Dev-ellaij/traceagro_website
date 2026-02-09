import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showNavbar = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showNavbar = _scrollController.offset > 100;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _buildHeroSection(context),
                _buildStatsSection(context),
                _buildWhatWeDoSection(context),
                _buildWhyTraceAgroSection(context),
                _buildTrustSection(context),
                _buildCTASection(context),
                _buildFooter(context),
              ],
            ),
          ),

          // Floating Navbar
          if (_showNavbar) _buildFloatingNavbar(context),
        ],
      ),
    );
  }

  // Floating Navbar
  Widget _buildFloatingNavbar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0F1A).withOpacity(0.95),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF22C55E).withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'TraceAgro',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF22C55E),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                TextButton(
                  onPressed: () => _launchUrl('mailto:ikechukwu@traceagro.com'),
                  child: const Text(
                    'Contact',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Hero Section
  Widget _buildHeroSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isMobile ? 600 : 700),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A0F1A), Color(0xFF1A2332), Color(0xFF0A0F1A)],
        ),
      ),
      child: Stack(
        children: [
          // Animated background grid (wipe-through effect)
          ...List.generate(20, (index) {
            return Positioned(
              left: (index % 5) * (screenWidth / 5),
              top: (index ~/ 5) * 150.0,
              child:
                  Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF22C55E).withOpacity(0.05),
                            width: 1,
                          ),
                        ),
                      )
                      .animate(onPlay: (controller) => controller.repeat())
                      .fadeIn(
                        duration: 2000.ms,
                        delay: Duration(milliseconds: index * 100),
                      )
                      .then()
                      .shimmer(duration: 3000.ms, delay: 1000.ms),
            );
          }),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 80,
              vertical: isMobile ? 60 : 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo/Brand
                Text(
                      'TraceAgro',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF22C55E),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: -0.2, end: 0),

                const SizedBox(height: 60),

                // Main Headline
                Text(
                      'Nigeria\'s ISA 2025-Compliant\nAgri-Export Platform',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 36 : 64,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        color: Colors.white,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 200.ms)
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 24),

                // Subheadline
                Container(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child:
                      Text(
                            'Solar-powered processing + blockchain traceability → 30–50% less post-harvest loss, premium export pricing, smallholder financing.',
                            style: GoogleFonts.inter(
                              fontSize: isMobile ? 16 : 20,
                              height: 1.6,
                              color: Colors.white70,
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 400.ms)
                          .slideY(begin: 0.3, end: 0),
                ),

                const SizedBox(height: 48),

                // CTA Buttons (Glowing!)
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildGlowingButton(
                          'Investor / Grant Enquiry',
                          () => _launchUrl(
                            'mailto:ikechukwu@traceagro.com?subject=Investor Enquiry',
                          ),
                          isPrimary: true,
                        )
                        .animate()
                        .fadeIn(duration: 800.ms, delay: 600.ms)
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1, 1),
                        ),

                    _buildGlowingButton(
                          'Become a Buyer / Partner',
                          () => _launchUrl(
                            'mailto:ikechukwu@traceagro.com?subject=Buyer Partnership',
                          ),
                          isPrimary: false,
                        )
                        .animate()
                        .fadeIn(duration: 800.ms, delay: 700.ms)
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1, 1),
                        ),

                    _buildGlowingButton(
                          'Join as Farmer / Aggregator',
                          () => _launchUrl(
                            'mailto:ikechukwu@traceagro.com?subject=Farmer Registration',
                          ),
                          isPrimary: false,
                        )
                        .animate()
                        .fadeIn(duration: 800.ms, delay: 800.ms)
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1, 1),
                        ),
                  ],
                ),

                const SizedBox(height: 60),

                // Social Links (Email & LinkedIn)
                Row(
                  children: [
                    _buildSocialButton(
                      'LinkedIn',
                      Icons.person,
                      () => _launchUrl(
                        'https://linkedin.com/in/ikechukwu-o-4242ba31',
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildSocialButton(
                      'Email',
                      Icons.email,
                      () => _launchUrl('mailto:ikechukwu@traceagro.com'),
                    ),
                  ],
                ).animate().fadeIn(duration: 800.ms, delay: 900.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Glowing Button Widget
  Widget _buildGlowingButton(
    String text,
    VoidCallback onPressed, {
    required bool isPrimary,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child:
            AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    gradient: isPrimary
                        ? const LinearGradient(
                            colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                          )
                        : null,
                    color: isPrimary ? null : Colors.transparent,
                    border: Border.all(
                      color: const Color(0xFF22C55E),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF22C55E).withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 2000.ms, delay: 1000.ms),
      ),
    );
  }

  // Social Button Widget
  Widget _buildSocialButton(
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2332),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFF22C55E).withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: const Color(0xFF22C55E)),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Stats Section
  Widget _buildStatsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: const Color(0xFF0A0F1A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('1000+', 'Farmers'),
          _buildStatItem('500+', 'Products'),
          _buildStatItem('50+', 'Countries'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF22C55E),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 18, color: Colors.white70),
        ),
      ],
    );
  }

  // What We Do Section
  Widget _buildWhatWeDoSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: const Color(0xFF1A2332),
      child: Column(
        children: [
          Text(
            'What We Do',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildServiceCard(
                Icons.agriculture,
                'Farm Management',
                'Optimize your farm operations',
              ),
              _buildServiceCard(
                Icons.analytics,
                'Data Analytics',
                'Make informed decisions',
              ),
              _buildServiceCard(
                Icons.eco,
                'Sustainability',
                'Eco-friendly practices',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(IconData icon, String title, String description) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF22C55E).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF22C55E).withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: const Color(0xFF22C55E)),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Why TraceAgro Section
  Widget _buildWhyTraceAgroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: const Color(0xFF0A0F1A),
      child: Column(
        children: [
          Text(
            'Why TraceAgro?',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'We provide cutting-edge solutions for modern agriculture',
            style: GoogleFonts.inter(fontSize: 18, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Trust Section
  Widget _buildTrustSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: const Color(0xFF1A2332),
      child: Column(
        children: [
          Text(
            'Trusted by Thousands',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Join our growing community of successful farmers',
            style: GoogleFonts.inter(fontSize: 18, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // CTA Section
  Widget _buildCTASection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Ready to Transform Your Farm?',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _launchUrl('mailto:ikechukwu@traceagro.com'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
            ),
            child: Text(
              'Contact Us',
              style: GoogleFonts.inter(
                fontSize: 18,
                color: const Color(0xFF22C55E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Footer
  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      color: const Color(0xFF0A0F1A),
      child: Column(
        children: [
          Text(
            '© 2024 TraceAgro. All rights reserved.',
            style: GoogleFonts.inter(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () =>
                    _launchUrl('https://linkedin.com/in/ikechukwu-o-4242ba31'),
                child: Text(
                  'LinkedIn',
                  style: GoogleFonts.inter(color: Colors.white70),
                ),
              ),
              TextButton(
                onPressed: () => _launchUrl('mailto:ikechukwu@traceagro.com'),
                child: Text(
                  'Email',
                  style: GoogleFonts.inter(color: Colors.white70),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
