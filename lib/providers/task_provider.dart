import 'package:flutter/material.dart';
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

    try {
      final response = await supabase
          .from('tasks')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      if (response.isEmpty) {
        debugPrint('No tasks found for user: ${user.id}');
        return [];
      }

      debugPrint('Response: $response'); // 디버깅용

      List<Task> taskList = [];

      for (var json in response) {
        try {
          // 🔹 created_at이 올바른 형식인지 체크 후 변환
          if (json['created_at'] != null && json['created_at'] is String) {
            try {
              json['created_at'] =
                  DateTime.parse(json['created_at']).toIso8601String();
            } catch (e) {
              debugPrint('Invalid date format: ${json['created_at']}');
              json['created_at'] = null; // 기본값 설정
            }
          }

          // 🔹 JSON 변환 성공한 데이터만 리스트에 추가
          taskList.add(Task.fromJson(json));
        } catch (e) {
          debugPrint('Error parsing task JSON: $e, Data: $json');
        }
      }

      return taskList;
    } catch (e, stacktrace) {
      debugPrint('Error fetching tasks: $e\nStacktrace: $stacktrace');
      throw Exception('Failed to fetch tasks');
    }
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

    final task = Task(
      id: 'd',
      taskType: TaskType.values.byName(taskType),
      status: 'not_started',
      duration: duration,
      createdAt: DateTime.now(), // 현재 시간 사용
    );

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
    required String taskType,
    required int duration,
  }) async {
    final supabase = Supabase.instance.client;

    await supabase.from('tasks').update({
      'status': status,
      'task_type': taskType,
      'duration': duration,
    }).eq('id', taskId);

    refreshTasks();
  }
}
