import 'package:flutter/cupertino.dart';
import 'package:todo/utils/theme_extension.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.description,
    this.icon = CupertinoIcons.checkmark_seal,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 48),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Icon(icon, color: context.accentColor, size: 36),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(color: context.secondaryTextColor, height: 1.5),
        ),
      ],
    ),
  );
}
