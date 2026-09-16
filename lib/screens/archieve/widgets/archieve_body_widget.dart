import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/model/archieve/archieve_db.dart';
import 'package:todo/utils/theme_extension.dart';

class ArchieveBodyWidget extends StatelessWidget {
  const ArchieveBodyWidget({super.key, required this.archieveModel});
  final ArchieveModel archieveModel;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: context.cardColor,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            CupertinoIcons.archivebox,
            color: context.accentColor,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                archieveModel.text,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                '${archieveModel.category} · ${DateFormat.yMMMd().format(archieveModel.deadlineDateTime)}',
                style: TextStyle(
                  fontSize: 12,
                  color: context.secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
