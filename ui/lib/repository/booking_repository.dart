import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/booking.dart';
import 'database_helper.dart';

class BookingRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int> insertBooking(Booking booking) async {
    final db = await _dbHelper.database;
    return await db.insert(
      DatabaseHelper
          .tableBookings, // ✅ fix: sekarang bisa diakses karena sudah public
      booking.toMap(),
    );
  }
}
