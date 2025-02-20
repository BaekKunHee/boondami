import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

final mainProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  try {
    final user = supabase.auth.currentUser;
    print(user?.id);
    if (user == null) return null;

    final response =
        await supabase.from('profiles').select().eq('id', user.id).single();

    print(response);

    return response;
  } catch (e) {
    throw Exception('멤버 정보를 불러오는데 실패했습니다: $e');
  }
});
