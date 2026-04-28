import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:there_yet/l10n/app_localizations.dart';
import 'package:there_yet/shared/providers/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _store = String.fromEnvironment(
    'STORE',
    defaultValue: 'playstore',
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final amoled = ref.watch(amoledBlackProvider);
    final materialYou = ref.watch(materialYouProvider);
    final isDark =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _SectionHeader(label: l10n.appearance),
          _ThemeListTile(
            themeMode: themeMode,
            onChanged: (mode) {
              ref.read(themeModeProvider.notifier).set(mode);
            },
          ),
          SwitchListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            title: Text(l10n.materialYou),
            subtitle: Text(l10n.materialYouSubtitle),
            value: materialYou,
            onChanged: (value) {
              ref.read(materialYouProvider.notifier).set(value);
            },
          ),
          SwitchListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            title: Text(l10n.trueBlack),
            subtitle: Text(l10n.trueBlackSubtitle),
            value: amoled,
            onChanged: isDark
                ? (value) {
                    ref.read(amoledBlackProvider.notifier).set(value);
                  }
                : null,
          ),
          _SectionHeader(label: l10n.support),
          if (_store == 'playstore')
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: const Icon(Icons.star_outline),
              title: Text(l10n.rateApp),
              subtitle: Text(l10n.rateAppSubtitle),
              onTap: () => launchUrl(
                Uri.parse(
                  'https://play.google.com/store/apps/details?id=nl.bw20.there_yet',
                ),
                mode: LaunchMode.externalApplication,
              ),
            ),
          if (_store == 'fdroid')
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: const Icon(Icons.favorite_outline),
              title: Text(l10n.donate),
              subtitle: Text(l10n.donateSubtitle),
              onTap: () => launchUrl(
                Uri.parse('https://liberapay.com/BW20'),
                mode: LaunchMode.externalApplication,
              ),
            ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: const Icon(Icons.mail_outline),
            title: Text(l10n.sendFeedback),
            subtitle: Text(l10n.sendFeedbackSubtitle),
            onTap: _launchFeedback,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: const Icon(Icons.help_outline),
            title: Text(l10n.help),
            subtitle: Text(l10n.helpSubtitle),
            onTap: () => launchUrl(
              Uri.parse('https://codeberg.org/BW20/there-yet'),
              mode: LaunchMode.externalApplication,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchFeedback() async {
    final info = await PackageInfo.fromPlatform();
    final subject = Uri.encodeComponent(
      'There Yet feedback (v${info.version})',
    );
    await launchUrl(
      Uri.parse('mailto:jorrit@bw20.nl?subject=$subject'),
      mode: LaunchMode.externalApplication,
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _ThemeListTile extends StatelessWidget {
  const _ThemeListTile({required this.themeMode, required this.onChanged});

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    String themeLabel(ThemeMode mode) => switch (mode) {
      ThemeMode.system => l10n.themeSystem,
      ThemeMode.light => l10n.themeLight,
      ThemeMode.dark => l10n.themeDark,
    };

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(l10n.theme),
      subtitle: Text(themeLabel(themeMode)),
      onTap: () async {
        final result = await showDialog<ThemeMode>(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text(l10n.theme),
            children: [
              RadioGroup<ThemeMode>(
                groupValue: themeMode,
                onChanged: (value) => Navigator.pop(context, value),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final mode in ThemeMode.values)
                      RadioListTile<ThemeMode>(
                        value: mode,
                        title: Text(themeLabel(mode)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
        if (result != null) onChanged(result);
      },
    );
  }
}
