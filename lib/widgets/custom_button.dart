import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final Color? shadowColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final BorderSide? side;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 4,
    this.shadowColor,
    this.borderRadius = 8,
    this.padding,
    this.hoverColor,
    this.splashColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.side,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? theme.colorScheme.primary,
        foregroundColor: foregroundColor ?? theme.colorScheme.onPrimary,
        elevation: elevation,
        shadowColor: shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: side ?? BorderSide.none,
        ),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        disabledBackgroundColor:
            disabledBackgroundColor ?? Colors.grey.shade400,
        disabledForegroundColor:
            disabledForegroundColor ?? Colors.grey.shade800,
        surfaceTintColor: Colors.transparent,
      ).copyWith(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((
          Set<MaterialState> states,
        ) {
          if (states.contains(MaterialState.hovered)) {
            return hoverColor ??
                backgroundColor?.withOpacity(0.8) ??
                theme.colorScheme.primary.withOpacity(0.8);
          }
          if (states.contains(MaterialState.pressed)) {
            return splashColor ??
                foregroundColor?.withOpacity(0.2) ??
                theme.colorScheme.onPrimary.withOpacity(0.2);
          }
          return null;
        }),
      ),
      child: child,
    );
  }
}
