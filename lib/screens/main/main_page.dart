import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/models/task.dart';
import 'package:jobmoim/providers/task_provider.dart';
import 'package:jobmoim/widget/common/bm_switch.dart';
import 'package:jobmoim/widget/common/bottom_nav_bar.dart';

final selectedTaskTypeProvider =
    StateProvider<TaskType>((ref) => TaskType.cleaning);
final selectedDurationProvider = StateProvider<int>((ref) => 30);

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  static const List<int> durations = [0, 15, 30, 45, 60, 90, 120];

  bool isTaskEditable(String status) {
    return status == 'not_started';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskProviderProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: tasksAsync.when(
                skipLoadingOnReload: true,
                skipLoadingOnRefresh: true,
                data: (tasks) => ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<TaskType>(
                              value: task.taskType,
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                border: OutlineInputBorder(),
                              ),
                              items: TaskType.values.map((type) {
                                return DropdownMenuItem(
                                  value: type,
                                  child: Text(type.label),
                                );
                              }).toList(),
                              onChanged: isTaskEditable(task.status)
                                  ? (value) {
                                      if (value != null) {
                                        ref
                                            .read(taskProviderProvider.notifier)
                                            .updateTaskStatus(
                                              taskId: task.id,
                                              taskType: value.name,
                                              status: 'not_started',
                                              duration: task.duration,
                                            );
                                      }
                                    }
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<int>(
                              value: durations.contains(task.duration)
                                  ? task.duration
                                  : 0,
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                border: OutlineInputBorder(),
                              ),
                              items: durations.map((duration) {
                                return DropdownMenuItem(
                                  value: duration,
                                  child:
                                      Text(duration == 0 ? '미정' : '$duration분'),
                                );
                              }).toList(),
                              onChanged: isTaskEditable(task.status)
                                  ? (value) {
                                      if (value != null) {
                                        ref
                                            .read(taskProviderProvider.notifier)
                                            .updateTaskStatus(
                                              taskId: task.id,
                                              duration: value,
                                              status: 'not_started',
                                              taskType: task.taskType.name,
                                            );
                                      }
                                    }
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 40,
                            child: BMSwitch(
                              disabled: task.status != 'not_started',
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 60,
                            height: 32,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                textStyle: const TextStyle(fontSize: 12),
                                backgroundColor: task.status == 'completed'
                                    ? Colors.grey
                                    : null,
                              ),
                              onPressed: task.status == 'completed'
                                  ? null
                                  : () {
                                      ref
                                          .read(taskProviderProvider.notifier)
                                          .updateTaskStatus(
                                            taskId: task.id,
                                            status: task.status == 'not_started'
                                                ? 'in_progress'
                                                : 'completed',
                                            taskType: task.taskType.name,
                                            duration: task.duration,
                                          );
                                    },
                              child: Text(
                                task.status == 'not_started'
                                    ? '시작'
                                    : task.status == 'in_progress'
                                        ? '완료'
                                        : '완료됨',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(taskProviderProvider.notifier).createTask(
                taskType: TaskType.cleaning.name,
                duration: 30,
              );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
