import 'package:supabase/supabase.dart';
void main() async {
  final client = SupabaseClient('https://jiunybaumkzovjxzxpkn.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImppdW55YmF1bWt6b3ZqeHp4cGtuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODEwNzc2MDcsImV4cCI6MjA5NjY1MzYwN30.C6Y-kfARx0c8yhWOIZAk0GP5XWGrfMhkEpl2gn8N3tc');
  final res = await client.rpc('get_foreign_keys'); 
  // No wait, I don't have this RPC. 
  // Just query the `clinics` table to see what doctor_id looks like.
  final clinics = await client.from('clinics').select('doctor_id').limit(1);
  print('Clinic doctor_id: ${clinics}');
  
  final docs = await client.from('doctor_verifications').select('id, user_id').limit(1);
  print('Doctor Verifications: ${docs}');
}
