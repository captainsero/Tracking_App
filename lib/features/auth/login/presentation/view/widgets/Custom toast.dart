import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Kept the same name used across the codebase so existing call sites
/// (`type: ToastificationType.success`) keep working without any change.
enum ToastificationType { success, error, warning, info }

/// Lightweight, dependency-free toast. Shows a small banner near the top of
/// the screen using an [OverlayEntry] and auto-dismisses after [duration].
///
/// Usage stays exactly like before:
/// ```dart
/// CustomToast(
///   context: context,
///   header: S.of(context).error,
///   description: S.of(context).errorMessageGeneric,
///   type: ToastificationType.error,
/// ).showToast();
/// ```
class CustomToast {
  CustomToast({
    required this.context,
    required this.header,
    this.description,
    required this.type,
    this.duration = const Duration(seconds: 3),
  });

  final BuildContext context;
  final String header;
  final String? description;
  final ToastificationType type;
  final Duration duration;

  static OverlayEntry? _activeEntry;

  void showToast() {
    // Only one toast at a time — drop whatever is currently showing.
    _activeEntry?.remove();
    _activeEntry = null;

    final overlayState = Overlay.of(context);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _ToastBanner(
        header: header,
        description: description,
        type: type,
        duration: duration,
        onDismissed: () {
          entry.remove();
          if (_activeEntry == entry) {
            _activeEntry = null;
          }
        },
      ),
    );

    _activeEntry = entry;
    overlayState.insert(entry);
  }
}

class _ToastBanner extends StatefulWidget {
  const _ToastBanner({
    required this.header,
    required this.description,
    required this.type,
    required this.duration,
    required this.onDismissed,
  });

  final String header;
  final String? description;
  final ToastificationType type;
  final Duration duration;
  final VoidCallback onDismissed;

  @override
  State<_ToastBanner> createState() => _ToastBannerState();
}

class _ToastBannerState extends State<_ToastBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offset;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    _offset = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _timer = Timer(widget.duration, _dismiss);
  }

  Future<void> _dismiss() async {
    _timer?.cancel();
    if (!mounted) return;
    await _controller.reverse();
    widget.onDismissed();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Color get _color {
    switch (widget.type) {
      case ToastificationType.success:
        return const Color(0xFF2E7D32);
      case ToastificationType.error:
        return const Color(0xFFC62828);
      case ToastificationType.warning:
        return const Color(0xFFF9A825);
      case ToastificationType.info:
        return const Color(0xFF1565C0);
    }
  }

  IconData get _icon {
    switch (widget.type) {
      case ToastificationType.success:
        return Icons.check_circle;
      case ToastificationType.error:
        return Icons.error;
      case ToastificationType.warning:
        return Icons.warning_amber_rounded;
      case ToastificationType.info:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 12.h,
      left: 16.w,
      right: 16.w,
      child: SlideTransition(
        position: _offset,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: _dismiss,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(_icon, color: Colors.white),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.header,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.sp,
                          ),
                        ),
                        if (widget.description != null &&
                            widget.description!.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Text(
                            widget.description!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}