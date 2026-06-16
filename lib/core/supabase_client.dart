import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider<SupabaseClient>(
  (ref) => Supabase.instance.client,
);

class SupabaseConfig {
  static const String url = 'https://jiunybaumkzovjxzxpkn.supabase.co';
  static const String anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImppdW55YmF1bWt6b3ZqeHp4cGtuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEwNzc2MDcsImV4cCI6MjA5NjY1MzYwN30.C6Y-kfARx0c8yhWOIZAk0GP5XWGrfMhkEpl2gn8N3tc';
}
