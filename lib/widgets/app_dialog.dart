import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String? message;
  final String? buttonText;
  final VoidCallback? onPressed;
  final String? imagePath;
  final bool showCloseButton;
  final Widget? customContent;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final double? imageHeight;

  const AppDialog({
    super.key,
    required this.title,
    this.message,
    this.buttonText,
    this.onPressed,
    this.imagePath,
    this.showCloseButton = true,
    this.customContent,
    this.buttonColor,
    this.buttonTextColor,
    this.imageHeight,
  }) : assert(message == null || customContent == null,
  'Cannot provide both message and customContent');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image at the top (if provided)
                if (imagePath != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: imagePath!.startsWith('http')
                        ? Image.network(
                      imagePath!,
                      height: imageHeight ?? 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      imagePath!,
                      height: imageHeight ?? 130,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (message != null || customContent != null)
                        const SizedBox(height: 12),
                      if (message != null)
                        Text(
                          message!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      if (customContent != null) customContent!,
                      if (buttonText != null) const SizedBox(height: 20),
                      if (buttonText != null)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onPressed ?? () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
                              foregroundColor: buttonTextColor ?? Colors.white,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              buttonText!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            // Close button in top-right corner
            if (showCloseButton)
              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
