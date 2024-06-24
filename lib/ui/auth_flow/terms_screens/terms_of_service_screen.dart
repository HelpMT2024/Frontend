import 'package:flutter/material.dart';
import 'package:help_my_truck/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/main_navigation_bar.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
        title: l10n?.terms_and_conditions,
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
            style: styles.bodyMedium?.copyWith(
                color: ColorConstants.onSurfaceWhite), // базовый стиль текста
            children: const <TextSpan>[
              TextSpan(
                text:
                    'These Terms and Conditions ("Terms") govern your use of the Help My Truck mobile application (the "App") provided by Aliakraft Solutions LLC ("Aliakraft Solutions," "we," "us," or "our"). By downloading, accessing, or using the App, you agree to be bound by these Terms. If you do not agree to these Terms, you may not use the App.\n\n',
              ),
              TextSpan(
                text: 'License and Use: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Aliakraft Solutions grants you a limited, non-exclusive, non-transferable, revocable license to download, install, and use the App solely for your personal, non-commercial purposes. You may not modify, distribute, reproduce, or reverse-engineer the App.\n\n',
              ),
              TextSpan(
                text: 'User Accounts: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'In order to access certain features of the App, you may be required to create a user account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.\n\n',
              ),
              TextSpan(
                text: 'Content: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'The App may contain text, graphics, videos, and other content provided by Aliakraft Solutions or third parties. You agree not to use, copy, reproduce, modify, or distribute any content from the App without prior written consent.\n\n',
              ),
              TextSpan(
                text: 'Privacy: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Your use of the App is subject to our Privacy Policy, which governs the collection, use, and disclosure of your personal information. By using the App, you consent to the terms of our Privacy Policy.\n\n',
              ),
              TextSpan(
                text: 'Exclusions: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'The following exclusions outline specific scenarios where We and App shall not be held liable:\n\n',
              ),
              TextSpan(
                text: '''
• Bodily Injury or Property Damage: Aliakraft Solutions is not liable for any injuries to persons or damage to vehicles or property arising from the use of the App.
• Contractual Liability or Obligations: We are not responsible for obligations or liabilities beyond the ordinary standard of skill and care in providing vehicle-related services.
• Employment-Related Practices: Any claims related to employment practices, harassment, or discrimination fall outside our liability scope.
• Insolvency, Administration, or Receivership: Aliakraft Solutions bears no responsibility for claims arising from insolvency, administration, or receivership.
• Deliberate or Reckless Breach of Duty: We are not liable for any damages resulting from deliberate or reckless breaches of duty in relation to vehicle services.
• Mechanical, Electrical, or Systems Failures: Aliakraft Solutions is not liable for damages due to mechanical, electrical, or systems failures encountered during vehicle repairs or maintenance.
• Criminal, Dishonest, or Fraudulent Acts: We bear no responsibility for any losses resulting from criminal, dishonest, or fraudulent acts in relation to vehicle services.
• Breach of Licenses: Claims related to the breach of licenses concerning infringement or misappropriation in the context of vehicle repair or maintenance are excluded from our liability.
• Pollution or Environmental Hazards: Aliakraft Solutions is not liable for damages arising from pollution, environmental hazards, or related clean-up efforts resulting from vehicle-related activities.
• War, Terrorism, or Political Activities: Claims arising from war, terrorism, political activities, or related events in the context of vehicle services are not within our liability scope.
• Toxic or Non-toxic Claims: We bear no responsibility for claims related to the presence of toxic or non-toxic substances within the App or its use in the context of vehicle services.
• Liability under Contracts or Waivers: Any liabilities arising from contracts or waivers related to vehicle services are excluded from our liability.
• Intended Personal Injury or Property Damage: Claims related to intended personal injury or property damage during vehicle services are not covered by our liability.
• Financial Loss: Aliakraft Solutions is not liable for fines, penalties, taxes, or other uninsurable financial losses incurred during vehicle services.
• Libel or Slander: Claims related to libel or slander, including those related to advertising or broadcasting in the context of vehicle services, are excluded from our liability.
• Fungus, Moulds, or Spores: We bear no responsibility for liabilities related to fungus, moulds, spores, or related issues encountered during vehicle services.
• Nuclear or Radioactive Incidents: Claims arising from nuclear or radioactive incidents during vehicle services are not within our liability scope.
• Professional Advice or Services: Aliakraft Solutions is not liable for damages resulting from professional advice or services provided in the context of vehicle repair or maintenance, except for medical advice provided by qualified medical personnel.
• Silica-Related Claims: Claims related to silica exposure during vehicle services are excluded from our liability.
• Terrorism-Related Incidents: We bear no responsibility for damages resulting from terrorism-related incidents encountered during vehicle services.
• Worker's Compensation: Any claims covered under worker's compensation legislation or similar laws in relation to vehicle services fall outside our liability scope.\n\n\n''',
              ),
              TextSpan(
                text: 'Limitation of Liability: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'In no event shall Aliakraft Solutions be liable for any direct, indirect, incidental, special, consequential, or punitive damages arising out of or in any way connected with your use of the App, whether based on contract, tort, strict liability, or otherwise, even if advised of the possibility of such damages.\n\n',
              ),
              TextSpan(
                text: 'Identification: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'You agree to indemnify, defend, and hold harmless Aliakraft Solutions and its officers, directors, employees, and agents from and against any and all claims, liabilities, damages, losses, costs, expenses, or fees (including reasonable attorneys\' fees) arising out of or in any way related to your use of the App or violation of these Terms.\n\n',
              ),
              TextSpan(
                text: 'Governing Law: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'These Terms shall be governed by and construed in accordance with the laws of the State of [Insert State], without regard to its conflicts of law principles. Any dispute arising out of or relating to these Terms shall be exclusively resolved in the state or federal courts located in Summit County, Ohio, USA.\n\n',
              ),
              TextSpan(
                text: 'Changes to Terms: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'Aliakraft Solutions reserves the right to update or modify these Terms at any time without prior notice. Any changes will be effective immediately upon posting the revised Terms on the App. Your continued use of the App following the posting of changes constitutes your acceptance of such changes.\n\n',
              ),
              TextSpan(
                text: 'Contact Us: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    'If you have any questions about these Terms, please contact us at support@aliakraftsolutions.com.\n\n',
              ),
              TextSpan(
                text:
                    'By using the Help My Truck App, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
