import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildItem(context, Icons.question_answer_outlined, 'FAQs', const _FAQScreen()),
          _buildItem(context, Icons.chat_bubble_outline, 'Contact Us', const _ContactUsScreen()),
          _buildItem(context, Icons.privacy_tip_outlined, 'Privacy Policy', const _PrivacyPolicyScreen()),
          _buildItem(context, Icons.description_outlined, 'Terms of Service', const _TermsScreen()),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, IconData icon, String title, Widget targetScreen) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
          ),
          child: ListTile(
            leading: Icon(icon, color: AppColors.accentBlue),
            title: Text(title, style: AppTextStyles.labelMd),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => targetScreen));
            },
          ),
        ),
      ),
    );
  }
}

class _FAQScreen extends StatelessWidget {
  const _FAQScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQs')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFaqItem('How do I book an appointment?', 'You can book an appointment by going to the Home screen, searching for a nearby clinic, and tapping the Book Appointment button.'),
          _buildFaqItem('Can I cancel my appointment?', 'Yes, you can cancel your appointment from the Schedule screen up to 24 hours before the scheduled time.'),
          _buildFaqItem('What payment methods are supported?', 'We currently support Card Payments and Hand to Hand (Cash) payments at the clinic.'),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: AppTextStyles.headingSm),
          const SizedBox(height: 8),
          Text(answer, style: AppTextStyles.bodySm),
        ],
      ),
    );
  }
}

class _ContactUsScreen extends StatelessWidget {
  const _ContactUsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Get in Touch', style: AppTextStyles.headingLg),
            const SizedBox(height: 16),
            Text('Email: support@dentalclinicapp.com', style: AppTextStyles.bodyMd),
            const SizedBox(height: 8),
            Text('Phone: +1 800 123 4567', style: AppTextStyles.bodyMd),
            const SizedBox(height: 32),
            Text('Our support team is available 24/7 to assist you with any questions or concerns regarding your dental appointments.', style: AppTextStyles.bodySm),
          ],
        ),
      ),
    );
  }
}

class _PrivacyPolicyScreen extends StatelessWidget {
  const _PrivacyPolicyScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Privacy Policy\n\n'
          'Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our dental clinic application.\n\n'
          'Information We Collect:\n'
          '- Personal details (Name, Phone, Email) for booking purposes.\n'
          '- Location data to show nearby clinics.\n\n'
          'How We Use Information:\n'
          '- To facilitate appointment bookings with dental clinics.\n'
          '- To send you notifications regarding your schedule.\n\n'
          'We do not share your personal information with third parties except as necessary to provide our services.',
          style: AppTextStyles.bodySm,
        ),
      ),
    );
  }
}

class _TermsScreen extends StatelessWidget {
  const _TermsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Terms of Service\n\n'
          'Welcome to the Dental Clinic Booking App. By using our application, you agree to these terms.\n\n'
          '1. Booking:\nAppointments are subject to clinic availability. You are responsible for arriving on time.\n\n'
          '2. Cancellations:\nPlease cancel appointments at least 24 hours in advance. Repeated no-shows may result in account suspension.\n\n'
          '3. Medical Advice:\nThis app is a booking platform and does not provide direct medical advice. Always consult a qualified dentist for medical concerns.\n\n'
          '4. Modifications:\nWe reserve the right to modify these terms at any time. Continued use of the app constitutes acceptance of the new terms.',
          style: AppTextStyles.bodySm,
        ),
      ),
    );
  }
}
