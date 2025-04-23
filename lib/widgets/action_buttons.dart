import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onCapture;
  final VoidCallback onConvert;
  final VoidCallback onRecord;
  final bool isRecording;

  const ActionButtons({
    super.key,
    required this.onCapture,
    required this.onConvert,
    required this.onRecord,
    required this.isRecording,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ActionButton(
          icon: Icons.camera_alt,
          label: 'Capture',
          onPressed: onCapture,
        ),
        _ActionButton(
          icon: Icons.autorenew,
          label: 'Convert',
          onPressed: onConvert,
        ),
        _ActionButton(
          icon: isRecording ? Icons.stop : Icons.videocam,
          label: isRecording ? 'Stop' : 'Record',
          onPressed: onRecord,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
