import 'dart:convert';
import 'package:supabase/supabase.dart';

void main() async {
  final client = SupabaseClient('https://jiunybaumkzovjxzxpkn.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImppdW55YmF1bWt6b3ZqeHp4cGtuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEwNzc2MDcsImV4cCI6MjA5NjY1MzYwN30.C6Y-kfARx0c8yhWOIZAk0GP5XWGrfMhkEpl2gn8N3tc');
  try {
    // try to fetch appointments using auth if possible, or just fetch appointments table
    final res = await client.from('appointments').select().limit(5);
    print('Appointments count: ${res.length}');
    for (var r in res) {
      print(r);
    }
  } catch (e) {
    print('Error: $e');
  }
}
