import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        title: l10n?.privacy_policy,
        bgColor: ColorConstants.surfacePrimaryDark,
      ),
      backgroundColor: ColorConstants.surfacePrimaryDark,
      body: _body(styles),
    );
  }

  Widget _body(TextTheme styles) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: RichText(
          text: TextSpan(
            style: styles.bodyMedium
                ?.copyWith(color: ColorConstants.onSurfaceWhite),
            children: const <TextSpan>[
              TextSpan(
                text:
                    'At Aliakraft Solutions LLC ("Aliakraft Solutions," "we," "us," or "our"), we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy outlines how we collect, use, disclose, and protect the information you provide to us when using the Help My Truck mobile application (the "App").\n\n',
              ),
              TextSpan(
                text: '  • Information We Collect\n\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Personal Information: When you create an account or use certain features of the App, we may collect personal information such as your name, email address, phone number, and other contact details.\n\nUsage Information: We may collect information about your use of the App, including log data, device information, IP address, and browsing history.\n\nLocation Information: With your consent, we may collect precise location data from your device to provide location-based services.\n\n',
              ),
              TextSpan(
                text: '  • How We Use Your Information\n\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Providing Services: We use your information to operate, maintain, and improve the functionality of the App, including providing customer support and personalized content.\n\nCommunications: We may use your contact information to send you important updates, notifications, and promotional messages about the App and our services.\n\nAnalytics: We may use analytics tools to analyze usage patterns, track trends, and gather demographic information to improve the App\'s performance and user experience.\n\n',
              ),
              TextSpan(
                text: '  • Information Sharing and Disclosure\n\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Service Providers: We may share your information with third-party service providers who assist us in operating the App, processing payments, or providing other services on our behalf.\n\nLegal Compliance: We may disclose your information when required by law or in response to valid legal requests, such as subpoenas or court orders.\n\n',
              ),
              TextSpan(
                text: '  • Data Security\n\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'We implement industry-standard security measures to protect your information from unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.\n\n',
              ),
              TextSpan(
                text: '  • Children\'s Privacy\n\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'The App is not intended for use by children under the age of 13. We do not knowingly collect personal information from children under 13. If you believe we have inadvertently collected information from a child under 13, please contact us immediately.\n\n',
              ),
              TextSpan(
                text: '  • Changes to this Privacy Policy\n\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'We reserve the right to update or modify this Privacy Policy at any time. Any changes will be effective immediately upon posting the revised Privacy Policy on the App. Your continued use of the App following the posting of changes constitutes your acceptance of such changes.\n\n',
              ),
              TextSpan(
                text: 'Contact Us\n\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'If you have any questions or concerns about this Privacy Policy or our privacy practices, please contact us at support@aliakraftsolutions.com.\n\n',
              ),
              TextSpan(
                text:
                    'By using the Help My Truck App, you acknowledge that you have read, understood, and agree to the terms of this Privacy Policy.\n',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
