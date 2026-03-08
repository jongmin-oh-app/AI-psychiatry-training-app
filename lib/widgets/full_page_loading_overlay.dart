import 'package:flutter/material.dart';
import 'package:psychiatry_training/l10n/app_localizations.dart';
import '../core/constants/colors.dart';

class FullPageLoadingOverlay extends StatelessWidget {
  final String? message;
  final String? subtitle;

  const FullPageLoadingOverlay({
    super.key,
    this.message,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  message ?? l10n.loadingOverlayMessage,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  l10n.pleaseWait,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.hintText,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
