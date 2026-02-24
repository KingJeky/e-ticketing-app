import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/bloc/auth_bloc.dart';
import 'package:ui/bloc/auth_event.dart';
import 'package:ui/bloc/auth_state.dart';
import 'package:ui/bloc/ticket/ticket_bloc.dart';
import 'package:ui/bloc/ticket/ticket_event.dart';
import 'package:ui/bloc/ticket/ticket_state.dart';
import 'package:ui/screens/dashboard/widgets/event_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TicketBloc>().add(const LoadTickets());
  }

  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/login', (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(const LogoutRequested());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Cari Tiket',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  context.read<TicketBloc>().add(SearchTickets(value));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<TicketBloc, TicketState>(
                builder: (context, state) {
                  if (state is TicketLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TicketError) {
                    return Center(child: Text(state.message));
                  } else if (state is TicketLoaded) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.tickets.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/ticket-detail',
                              arguments: state.tickets[index],
                            );
                          },
                          child: EventCard(ticket: state.tickets[index]),
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No tickets available'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
