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
    final tasksAsync = ref.watch(groupTasksProvider(groupId));

    return tasksAsync.when(
      data: (tasks) {
        // selectedMember가 null이면 모든 태스크를 보여주고,
        // 아니면 선택된 멤버의 태스크만 필터링
        final filteredTasks = selectedMember == null
            ? tasks
            : tasks
                .where((task) => task.taskAssignments.any((assignment) =>
                    assignment.profiles.id == selectedMember?.id))
                .toList();

        return ListView.builder(
          itemCount: 24,
          itemBuilder: (context, hour) {
            final tasksAtHour = filteredTasks.where((task) {
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
    final assignments = task.taskAssignments;

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
                    Row(
                      children: [
                        Text(
                          task.taskCategories?.name ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            task.taskAssignments.first.taskStatus ==
                                    'not_started'
                                ? '대기중'
                                : task.taskAssignments.first.taskStatus ==
                                        'in_progress'
                                    ? '진행중'
                                    : '완료',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_formatTime(assignments.first.startTime)} ~ ${_formatTime(assignments.first.endTime)}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // 프로필 이미지 스택
              SizedBox(
                width: assignments.length > 1 ? 52 : 32,
                height: 32,
                child: Stack(
                  children: [
                    if (assignments.isNotEmpty)
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            assignments[0].profiles.profileUrl ?? '',
                          ),
                          radius: 16,
                        ),
                      ),
                    if (assignments.length > 1)
                      Positioned(
                        right: 20,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            assignments[1].profiles.profileUrl ?? '',
                          ),
                          radius: 16,
                        ),
                      ),
                    if (assignments.length > 2)
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          radius: 16,
                          child: Text(
                            '+${assignments.length - 2}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
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
