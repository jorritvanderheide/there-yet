import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:there_yet/l10n/app_localizations.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late final Future<PackageInfo> _packageInfo = PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.aboutTitle)),
      body: FutureBuilder<PackageInfo>(
        future: _packageInfo,
        builder: (context, snapshot) {
          final version = snapshot.data?.version ?? '';

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 32),
              Center(
                child: ClipOval(
                  child: SizedBox(
                    width: 96,
                    height: 96,
                    child: Image.asset('assets/icon.png'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.locationAlarmDefault,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.appTagline,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.version),
                subtitle: Text(version),
              ),
              ListTile(
                leading: const Icon(Icons.gavel),
                title: Text(l10n.license),
                subtitle: Text(l10n.licenseValue),
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: Text(l10n.mapData),
                subtitle: Text(l10n.mapDataValue),
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: Text(l10n.geocoding),
                subtitle: Text(l10n.geocodingValue),
              ),
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: () => showLicensePage(
                  context: context,
                  applicationName: l10n.locationAlarmDefault,
                  applicationVersion: version,
                ),
                child: Text(l10n.openSourceLicenses),
              ),
            ],
          );
        },
      ),
    );
  }
}
