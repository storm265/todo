import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:todo/utils/theme_extension.dart';

class CustomSnackbarWidget {
  static OverlayEntry? _entry;
  static Timer? _timer;

  static void show(BuildContext context, String message) {
    _timer?.cancel();
    _entry?.remove();
    final background = context.cardColor;
    final foreground = CupertinoTheme.of(context).textTheme.textStyle.color;
    final accent = context.accentColor;
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        left: 20,
        right: 20,
        bottom:
            MediaQuery.viewInsetsOf(context).bottom +
            MediaQuery.paddingOf(context).bottom +
            20,
        child: IgnorePointer(
          child: Semantics(
            liveRegion: true,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accent.withValues(alpha: 0.25)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 20,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.exclamationmark_circle,
                    color: accent,
                    size: 23,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 14,
                        height: 1.4,
                        color: foreground,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    _entry = entry;
    Overlay.of(context, rootOverlay: true).insert(entry);
    _timer = Timer(const Duration(seconds: 4), () {
      entry.remove();
      if (identical(_entry, entry)) _entry = null;
    });
  }
}
