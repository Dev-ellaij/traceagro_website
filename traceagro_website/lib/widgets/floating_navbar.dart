import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: unused_element
Widget _buildFloatingNavbar(BuildContext context) {
  return Positioned(
    top: 20,
    left: 20,
    right: 20,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2332).withOpacity(0.95),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: const Color(0xFF22C55E).withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF22C55E).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TraceAgro',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF22C55E),
            ),
          ),
          Row(
            children: [
              _buildNavButton('Investors', () {}),
              const SizedBox(width: 16),
              _buildNavButton('Buyers', () {}),
              const SizedBox(width: 16),
              _buildNavButton('Contact', () {}),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.5, end: 0),
  );
}

Widget _buildNavButton(String text, VoidCallback onPressed) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(color: Colors.white70, fontSize: 14),
    ),
  );
}
