import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onChangeAspectRatio;
  final VoidCallback onFlipImage;
  final VoidCallback onToggleFlash;
  final VoidCallback onToggleLock;
  final bool isFlashOn;
  final bool isLocked;

  const ControlButtons({
    super.key,
    required this.onBackPressed,
    required this.onChangeAspectRatio,
    required this.onFlipImage,
    required this.onToggleFlash,
    required this.onToggleLock,
    required this.isFlashOn,
    required this.isLocked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _IconButton(icon: Icons.arrow_back, onPressed: onBackPressed),
        const SizedBox(width: 8),
        _IconButton(
          icon: Icons.photo_size_select_actual,
          onPressed: onChangeAspectRatio,
        ),
        const SizedBox(width: 8),
        _IconButton(icon: Icons.flip, onPressed: onFlipImage),
        const SizedBox(width: 8),
        _IconButton(
          icon: isFlashOn ? Icons.flash_on : Icons.flash_off,
          onPressed: onToggleFlash,
        ),
        const SizedBox(width: 8),
        _IconButton(
          icon: isLocked ? Icons.lock : Icons.lock_open,
          onPressed: onToggleLock,
        ),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _IconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onPressed,
    );
  }
}
