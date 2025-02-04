import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/task.dart';

part 'task_provider.g.dart';

@riverpod
class TaskProvider extends _$TaskProvider {
  @override
  Future<List<Task>> build() async {
    return _fetchTasks();
  }

  Future<List<Task>> _fetchTasks() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    final response = await supabase
        .from('tasks')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);
    print(response);

    return response.map((json) => Task.fromJson(json)).toList();
  }

  Future<void> refreshTasks() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchTasks());
  }

  // Task 생성 메서드
  Future<void> createTask({
    required String taskType,
    required int duration,
  }) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in');
    }

    await supabase.from('tasks').insert({
      'user_id': user.id,
      'task_type': taskType,
      'duration': duration,
      'status': 'not_started',
    });

    refreshTasks();
  }

  // Task 상태 업데이트 메서드
  Future<void> updateTaskStatus({
    required String taskId,
    required String status,
  }) async {
    final supabase = Supabase.instance.client;

    await supabase.from('tasks').update({'status': status}).eq('id', taskId);

    refreshTasks();
  }
}
