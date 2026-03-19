import 'package:flutter/material.dart';

class SoundPicker extends StatelessWidget {
  const SoundPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.volume_up),
      title: const Text('Sound'),
      subtitle: const Text('Default alarm'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: implement sound selection
      },
    );
  }
}
