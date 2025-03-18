import 'package:flutter/material.dart';

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Duration duration = const Duration(seconds: 2),
    SnackBarType type = SnackBarType.info,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final ThemeData theme = Theme.of(context);

    // Define colors based on type
    final Map<SnackBarType, SnackBarStyle> styles = {
      SnackBarType.success: SnackBarStyle(
        backgroundColor: Colors.green.shade800,
        iconData: Icons.check_circle_outline,
        borderColor: Colors.green.shade600,
      ),
      SnackBarType.error: SnackBarStyle(
        backgroundColor: Colors.red.shade800,
        iconData: Icons.error_outline,
        borderColor: Colors.red.shade600,
      ),
      SnackBarType.warning: SnackBarStyle(
        backgroundColor: Colors.orange.shade800,
        iconData: Icons.warning_amber_outlined,
        borderColor: Colors.orange.shade600,
      ),
      SnackBarType.info: SnackBarStyle(
        backgroundColor: Colors.blue.shade800,
        iconData: Icons.info_outline,
        borderColor: Colors.blue.shade600,
      ),
    };

    final SnackBarStyle style = styles[type]!;

    // Use a custom content wrapper with animations
    final SnackBar snackBar = SnackBar(
      content: _AnimatedSnackBarContent(
        message: message,
        style: style,
        theme: theme,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed != null
            ? () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                onActionPressed();
              }
            : null,
      ),
      backgroundColor: Colors.transparent, // Make the SnackBar transparent
      duration: duration,
      behavior: SnackBarBehavior.floating,
      elevation: 0, // Remove default elevation
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.zero, // Remove default padding
      dismissDirection: DismissDirection.horizontal,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

// Animated SnackBar Content
class _AnimatedSnackBarContent extends StatefulWidget {
  final String message;
  final SnackBarStyle style;
  final ThemeData theme;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  const _AnimatedSnackBarContent({
    required this.message,
    required this.style,
    required this.theme,
    this.actionLabel,
    this.onActionPressed,
  });

  @override
  State<_AnimatedSnackBarContent> createState() => _AnimatedSnackBarContentState();
}

class _AnimatedSnackBarContentState extends State<_AnimatedSnackBarContent> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _iconRotationAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    // Slide animation
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    // Opacity animation
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    // Scale animation
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Icon rotation animation
    _iconRotationAnimation = Tween<double>(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
      ),
    );

    // Icon scale animation
    _iconScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 1.2), weight: 40),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 60),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    // Pulse animation for border
    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.05), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.05, end: 1.0), weight: 50),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Text animation
    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.style.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.style.borderColor,
                    width: 1.5 * _pulseAnimation.value,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.style.backgroundColor.withValues(alpha: 0.4),
                      blurRadius: 12 * _pulseAnimation.value,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Transform.scale(
                      scale: _iconScaleAnimation.value,
                      child: Transform.rotate(
                        angle: _iconRotationAnimation.value * 3.14,
                        child: Icon(
                          widget.style.iconData,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildAnimatedText(),
                    ),
                    if (widget.actionLabel != null && widget.onActionPressed != null) ...[
                      const SizedBox(width: 8),
                      _buildAnimatedButton(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedText() {
    // Instead of animating each character individually, animate the entire text
    // with a simple slide-up and fade-in effect
    return AnimatedBuilder(
      animation: _textAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _textAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _textAnimation.value)),
            child: Text(
              widget.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: widget.theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedButton() {
    final buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
      ),
    );

    return AnimatedBuilder(
      animation: buttonAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: buttonAnimation.value,
          child: TextButton(
            onPressed: widget.onActionPressed,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: widget.style.borderColor.withValues(alpha: 0.3),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              widget.actionLabel!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Style model for SnackBar types
class SnackBarStyle {
  final Color backgroundColor;
  final IconData iconData;
  final Color borderColor;

  SnackBarStyle({
    required this.backgroundColor,
    required this.iconData,
    required this.borderColor,
  });
}

// Enum for different SnackBar types
enum SnackBarType { success, error, warning, info }
