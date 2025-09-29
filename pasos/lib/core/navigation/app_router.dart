import 'package:flutter/material.dart';
import 'package:pasos/features/advertisements/presentation/pages/advertisements_page.dart';
import 'package:pasos/features/ai_chat/presentation/pages/ai_chat_page.dart';
import 'package:pasos/features/auth/presentation/pages/login_page.dart';
import 'package:pasos/features/auth/presentation/pages/splash_page.dart';
import 'package:pasos/features/curricula/data/models/curriculum_model.dart';
import 'package:pasos/features/curricula/presentation/pages/curricula_page.dart';
import 'package:pasos/features/curricula/presentation/pages/curriculum_details_page.dart';
import 'package:pasos/features/entertainment/presentation/pages/entertainment_category_page.dart';
import 'package:pasos/features/entertainment/presentation/pages/entertainment_page.dart';
import 'package:pasos/features/entertainment/presentation/pages/video_player_page.dart';
import 'package:pasos/features/exams/presentation/pages/exam_results_page.dart';
import 'package:pasos/features/home/presentation/pages/home_page.dart';
import 'package:pasos/features/ai_chat/presentation/pages/chat_history_page.dart';
import 'package:pasos/features/profile/presentation/pages/create_profile_page.dart';
import 'package:pasos/features/profile/presentation/pages/profile_page.dart';
import 'package:pasos/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:pasos/features/costs/presentation/pages/costs_page.dart';
import 'package:pasos/features/schedule/presentation/pages/request_meeting_page.dart';
import 'package:pasos/features/schedule/presentation/pages/schedule_page.dart';
import 'package:pasos/features/schedule/presentation/pages/teacher_meetings_page.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String aiChat = '/ai-chat';
  static const String chatHistory = '/chat-history';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String createProfile = '/create-profile';
  static const String costs = '/costs';
  static const String advertisements = '/advertisements';
  static const String entertainment = '/entertainment';
  static const String entertainmentCategory = '/entertainment-category';
  static const String videoPlayer = '/video-player';
  static const String schedule = '/schedule';
  static const String teacherMeetings = '/teacher-meetings';
  static const String requestMeeting = '/request-meeting';
  static const String curricula = '/curricula';
  static const String curriculumDetails = '/curriculum-details';
  static const String examResults = '/exam-results';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case videoPlayer:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildPageRoute(
          VideoPlayerPage(
            videoUrl: args['videoUrl'],
            videoTitle: args['videoTitle'],
          ),
        );
      case entertainmentCategory:
        final args = settings.arguments as Map<String, dynamic>;
        return _buildPageRoute(
          EntertainmentCategoryPage(
            categoryTitle: args['categoryTitle'],
            videos: args['videos'],
          ),
        );
      case entertainment:
        return _buildPageRoute(const EntertainmentPage());
      case costs:
        return _buildPageRoute(const CostsPage());
      case profile:
        return _buildPageRoute(const ProfilePage());
      case editProfile:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildPageRoute(
          EditProfilePage(
            profile: args?['profile'],
            isChild: args?['isChild'] ?? false,
          ),
        );
      case schedule:
        return _buildPageRoute(const SchedulePage());
      case teacherMeetings:
        return _buildPageRoute(const TeacherMeetingsPage());
      case requestMeeting:
        final teacherId = settings.arguments as String?;
        return _buildPageRoute(RequestMeetingPage(teacherId: teacherId));
      case chatHistory:
        return _buildPageRoute(const ChatHistoryPage());
      case aiChat:
        return _buildPageRoute(const AiChatPage());
      case home:
        return _buildPageRoute(const HomePage());
      case login:
        return _buildPageRoute(const LoginPage());
      case splash:
        return _buildPageRoute(const SplashPage());
      case createProfile:
        return _buildPageRoute(const CreateProfilePage());
      case advertisements:
        return _buildPageRoute(const AdvertisementsPage());
      case curricula:
        return _buildPageRoute(const CurriculaPage());
      case examResults:
        return _buildPageRoute(const ExamResultsPage());
      case curriculumDetails:
        final curriculum = settings.arguments as CurriculumModel;
        return _buildPageRoute(CurriculumDetailsPage(curriculum: curriculum));

      default:
        return _buildPageRoute(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  static PageRouteBuilder _buildPageRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
