import 'package:btg_funds_app/features/transaction/domain/entities/transaction_entity.dart';
import 'package:flutter/material.dart';

/// A segmented control for choosing a notification method.
///
/// Provides a simple UI for selecting how the user wants to be notified.
class NotificationSelector extends StatefulWidget {
  /// Creates a [NotificationSelector] with an optional initial [initialMethod].
  const NotificationSelector({
    this.initialMethod = NotificationMethod.email,
    super.key,
  });

  /// Initial [NotificationMethod] shown in the control.
  final NotificationMethod initialMethod;

  @override
  State<NotificationSelector> createState() => NotificationSelectorState();
}

/// State for [NotificationSelector].
class NotificationSelectorState extends State<NotificationSelector> {
  late NotificationMethod _selectedMethod;

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.initialMethod;
  }

  /// Returns the currently selected notification method.
  NotificationMethod get selectedMethod => _selectedMethod;

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
          selected: {_selectedMethod},
          onSelectionChanged: (value) {
            setState(() => _selectedMethod = value.first);
          },
          style: const ButtonStyle(
            visualDensity: VisualDensity.compact,
          ),
        ),
      ],
    );
  }
}
