import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/providers/task_provider.dart';
import 'package:jobmoim/widget/common/bm_switch.dart';
import 'package:jobmoim/widget/common/bottom_nav_bar.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

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
                            child: Text(task.taskType),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: Text('${task.duration} 분'),
                          ),
                          const SizedBox(width: 8),
                          const SizedBox(
                            width: 40,
                            child: BMSwitch(),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 60,
                            height: 32,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                textStyle: const TextStyle(fontSize: 12),
                              ),
                              onPressed: () {
                                ref
                                    .read(taskProviderProvider.notifier)
                                    .updateTaskStatus(
                                      taskId: task.id,
                                      status: task.status == 'not_started'
                                          ? 'in_progress'
                                          : 'completed',
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
                taskType: 'cleaning',
                duration: 60,
              );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
