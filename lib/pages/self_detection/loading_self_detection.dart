import 'package:flutter/material.dart';
import 'package:bumilku_app/theme/theme.dart';
import '../../../l10n/app_localizations.dart';

class LoadingSelfDetectionPage extends StatelessWidget {
  const LoadingSelfDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
            ),
            const SizedBox(height: 20),
            Text(
              t.selfDetectionLoading,
              style: blackTextStyle.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
