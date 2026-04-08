import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ricj_and_morti/core/theme/app_colors.dart';
import 'package:ricj_and_morti/core/theme/app_text_styles.dart';

class AppToaster {
  static OverlayEntry? _currentEntry;
  static Timer? _timer;

  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
  }) {
    // Убираем старое уведомление, если оно есть
    _timer?.cancel();
    _currentEntry?.remove();

    final overlay = Overlay.of(context);

    _currentEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).padding.top + 20, // Парит сверху экрана
          left: 20,
          right: 20,
          child: _ToastWidget(
            key: UniqueKey(),
            message: message,
            isError: isError,
            onDismiss: () {
              _currentEntry?.remove();
              _currentEntry = null;
            },
          ),
        );
      },
    );

    overlay.insert(_currentEntry!);

    // Автоматически убираем через 3 секунды
    _timer = Timer(const Duration(seconds: 3), () {
      _currentEntry?.remove();
      _currentEntry = null;
    });
  }
}

// Виджет самого уведомления с анимацией появления
class _ToastWidget extends StatefulWidget {
  final String message;
  final bool isError;
  final VoidCallback onDismiss;

  const _ToastWidget({
    super.key,
    required this.message,
    required this.isError,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward().then((_){
      Future.delayed(const Duration(seconds: 2), (){
        if (mounted) {
          _controller.reverse().then((_){
            widget.onDismiss();
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: widget.isError
                  ? Colors.redAccent.withValues(alpha: 0.9)
                  : AppColors.surface.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  widget.isError ? Icons.error_outline : Icons.bookmark,
                  color: widget.isError ? Colors.white : AppColors.primary,
                  size: 28,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.message,
                    style: AppTextStyles.label.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
