import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/models/member.dart';
import 'package:jobmoim/models/task.dart';
import 'package:jobmoim/providers/task_provider.dart';

class DailyTaskView extends ConsumerWidget {
  final String groupId;
  final Member? selectedMember;

  const DailyTaskView({
    super.key,
    required this.groupId,
    this.selectedMember,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = selectedMember == null
        ? ref.watch(groupTasksProvider(groupId))
        : ref.watch(memberTasksProvider(
            (groupId: groupId, memberId: selectedMember!.id)));
    print(tasksAsync);

    return tasksAsync.when(
      data: (tasks) {
        return ListView.builder(
          itemCount: 24,
          itemBuilder: (context, hour) {
            final tasksAtHour = tasks.where((task) {
              return task.taskAssignments
                  .any((assignment) => assignment.startTime.hour == hour);
            }).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          '${hour.toString().padLeft(2, '0')}:00',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
                if (tasksAtHour.isNotEmpty)
                  ...tasksAtHour.map((task) => TaskBlock(task: task)),
              ],
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class TaskBlock extends StatelessWidget {
  final Task task;

  const TaskBlock({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(84, 4, 16, 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_formatTime(task.taskAssignments.first.startTime)} ~ ${_formatTime(task.taskAssignments.first.endTime)}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    task.taskAssignments.first.profiles.profileUrl ?? ''),
                radius: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
