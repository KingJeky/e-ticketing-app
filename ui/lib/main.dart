import 'package:flutter/material.dart';
import 'package:ui/bloc/auth_bloc.dart';
import 'package:ui/bloc/auth_event.dart';
import 'package:ui/bloc/auth_state.dart';
import 'package:ui/screens/auth/login_screen.dart';
import 'package:ui/screens/auth/register_screen.dart';
import 'package:ui/screens/dashboard/dashboard_screen.dart';
import 'package:ui/screens/dashboard/ticket_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ui/bloc/ticket/ticket_bloc.dart';
import 'package:ui/repository/ticket_repository.dart';

void main() {
  runApp(const EticketingApp());
}

class EticketingApp extends StatelessWidget {
  const EticketingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(const CheckAuthStatus()),
        ),
        BlocProvider(
          create: (context) => TicketBloc(ticketRepository: TicketRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-ticketing App',
        home: const AuthWrapper(),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/ticket-detail': (context) => const TicketDetailScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return const DashboardScreen();
        } else if (state is AuthUnauthenticated) {
          return const LoginScreen();
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
