import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/providers/task_provider.dart';

class TaskPage extends ConsumerWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskProviderProvider);

    return Scaffold(
      body: tasksAsync.when(
        data: (tasks) => ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return ListTile(
              title: Text(task.taskType.label),
              subtitle: Text('Status: ${task.status}'),
              trailing: Text('Duration: ${task.duration}'),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 새 task 생성 로직
          ref.read(taskProviderProvider.notifier).createTask(
                taskType: 'cleaning',
                duration: 60,
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
