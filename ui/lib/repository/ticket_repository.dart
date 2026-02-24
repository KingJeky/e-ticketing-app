import '../models/ticket.dart';

class TicketRepository {
  final List<Ticket> _mockTickets = [
    Ticket(
      id: '1',
      title: 'Avatar Fire And Ash',
      description: 'Trilogy of Avatar',
      price: 45000,
      imageUrl:
          'https://images.unsplash.com/photo-1516981692733-48343a8f9388?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      date: DateTime.now(),
    ),
    Ticket(
      id: '2',
      title: 'Avatar Tulkun',
      description: 'Trilogy of Avatar',
      price: 45000,
      imageUrl:
          'https://images.unsplash.com/photo-1516981692733-48343a8f9388?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      date: DateTime.now(),
    ),
  ];

  Future<List<Ticket>> getTickets() async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockTickets;
  }

  Future<Ticket> getTicketById(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      return _mockTickets.firstWhere((ticket) => ticket.id == id);
    } catch (e) {
      throw Exception('Ticket not found');
    }
  }

  Future<List<Ticket>> searchTickets(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockTickets
        .where(
          (ticket) => ticket.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
