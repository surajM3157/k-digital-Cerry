import 'package:get/get.dart';
import 'package:piwotapp/pages/auth/forgot_password_page.dart';
import 'package:piwotapp/pages/auth/login_page.dart';
import 'package:piwotapp/pages/auth/otp_page.dart';
import 'package:piwotapp/pages/auth/reset_password_page.dart';
import 'package:piwotapp/pages/chat_page.dart';
import 'package:piwotapp/pages/event_details_page.dart';
import 'package:piwotapp/pages/home/home_page.dart';
import 'package:piwotapp/pages/live_session_page.dart';
import 'package:piwotapp/pages/notification_page.dart';
import 'package:piwotapp/pages/profile/change_password_page.dart';
import 'package:piwotapp/pages/profile/contact_us_page.dart';
import 'package:piwotapp/pages/profile/edit_profile_page.dart';
import 'package:piwotapp/pages/profile/feedback_page.dart';
import 'package:piwotapp/pages/profile/profile_page.dart';
import 'package:piwotapp/pages/profile/ticket_page.dart';
import 'package:piwotapp/pages/survey/survey_page.dart';
import 'package:piwotapp/pages/survey/thank_you_page.dart';
import 'package:piwotapp/route/route_names.dart';

import '../pages/session_details_page.dart';

final getPages = [
  GetPage(name: Routes.login, page: () => LoginPage()),
  GetPage(name: Routes.forgotPassword, page: () => ForgotPasswordPage()),
  GetPage(name: Routes.resetPassword, page: () => ResetPasswordPage()),
  GetPage(name: Routes.otp, page: () => OtpPage()),
  GetPage(name: Routes.home, page: () => HomePage()),
  GetPage(name: Routes.eventDetails, page: () => EventDetailsPage()),
  GetPage(name: Routes.liveSession, page: () => LiveSessionPage()),
  GetPage(name: Routes.sessionDetails, page: () => SessionDetailsPage()),
  GetPage(name: Routes.profile, page: () => ProfilePage()),
  GetPage(name: Routes.editProfile, page: () => EditProfilPage()),
  GetPage(name: Routes.changePassword, page: () => ChangePasswordPage()),
  GetPage(name: Routes.ticket, page: () => TicketPage()),
  GetPage(name: Routes.survey, page: () => SurveyPage()),
  GetPage(name: Routes.thankYou, page: () => ThankYouPage()),
  GetPage(name: Routes.notification, page: () => NotificationPage()),
  GetPage(name: Routes.feedback, page: () => FeedbackPage()),
  GetPage(name: Routes.contactUs, page: () => ContactUsPage()),
  GetPage(name: Routes.chat, page: () => ChatPage()),
];