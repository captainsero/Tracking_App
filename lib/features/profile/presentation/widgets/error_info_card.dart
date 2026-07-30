// ── Error Info Card ───────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

class ErrorInfoCard extends StatelessWidget {
  final VoidCallback onRetry;

  const ErrorInfoCard({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.wifi_off_rounded, size: 40, color: Colors.pink),
          const SizedBox(height: 12),
          Text(
            'Something went wrong. Please try again.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.5,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE91E8C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: const StadiumBorder(),
                elevation: 3,
                shadowColor: const Color(0xFFE91E8C).withOpacity(0.35),
              ),
              child: const Text(
                'Retry',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
