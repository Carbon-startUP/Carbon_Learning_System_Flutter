import 'package:flutter/material.dart';
import 'package:pasos/features/ai_chat/presentation/pages/ai_chat_page.dart';
import 'package:pasos/features/auth/presentation/pages/login_page.dart';
import 'package:pasos/features/auth/presentation/pages/splash_page.dart';
import 'package:pasos/features/home/presentation/pages/home_page.dart';
import 'package:pasos/features/ai_chat/presentation/pages/chat_history_page.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String aiChat = '/ai-chat';
  static const String chatHistory = '/chat-history';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
