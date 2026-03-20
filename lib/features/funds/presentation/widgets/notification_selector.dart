import 'package:btg_funds_app/features/transaction/domain/entities/transaction_entity.dart';
import 'package:flutter/material.dart';

/// A segmented control for choosing a notification method.
///
/// Provides a simple UI for selecting how the user wants to be notified.
class NotificationSelector extends StatelessWidget {
  /// Creates a [NotificationSelector] with the given [selected] and [onChanged].
  const NotificationSelector({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  /// Currently selected [NotificationMethod] shown in the control.
  final NotificationMethod selected;

  /// Callback invoked when the user selects a different [NotificationMethod].
  final ValueChanged<NotificationMethod> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Notificación:',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(width: 12),
        SegmentedButton<NotificationMethod>(
          segments: const [
            ButtonSegment(
              value: NotificationMethod.email,
              icon: Icon(Icons.email_outlined, size: 16),
              label: Text('Email'),
            ),
            ButtonSegment(
              value: NotificationMethod.sms,
              icon: Icon(Icons.sms_outlined, size: 16),
              label: Text('SMS'),
            ),
          ],
          selected: {selected},
          onSelectionChanged: (value) => onChanged(value.first),
          style: const ButtonStyle(
            visualDensity: VisualDensity.compact,
          ),
        ),
      ],
    );
  }
}
