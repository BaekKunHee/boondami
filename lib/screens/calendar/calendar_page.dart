import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/models/task.dart';
import 'package:jobmoim/providers/task_provider.dart';
import 'package:jobmoim/widget/common/bottom_nav_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskProviderProvider);
    final today = DateTime.now();
    final selectedDay = ValueNotifier<DateTime>(today);

    return Scaffold(
      appBar: AppBar(
        title: const Text('일정'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ValueListenableBuilder<DateTime>(
            valueListenable: selectedDay,
            builder: (context, value, _) {
              return TableCalendar(
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2025, 12, 31),
                focusedDay: value,
                selectedDayPredicate: (day) => isSameDay(value, day),
                onDaySelected: (selectedDay_, focusedDay) {
                  selectedDay.value = selectedDay_;
                },
                calendarFormat: CalendarFormat.month,
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                eventLoader: (day) {
                  return tasksAsync.when(
                    data: (tasks) {
                      return tasks
                          .where((task) => isSameDay(task.createdAt, day))
                          .toList();
                    },
                    loading: () => [],
                    error: (_, __) => [],
                  );
                },
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: tasksAsync.when(
                data: (tasks) {
                  return ValueListenableBuilder<DateTime>(
                    valueListenable: selectedDay,
                    builder: (context, selectedDate, _) {
                      final dayTasks = tasks
                          .where(
                              (task) => isSameDay(task.createdAt, selectedDate))
                          .toList();

                      if (dayTasks.isEmpty) {
                        return const Center(
                          child: Text('이 날의 일정이 없습니다'),
                        );
                      }

                      return ListView.builder(
                        itemCount: dayTasks.length,
                        itemBuilder: (context, index) {
                          final task = dayTasks[index];
                          return Card(
                            child: ListTile(
                              leading: Icon(
                                task.taskType == TaskType.cleaning
                                    ? Icons.cleaning_services
                                    : Icons.local_laundry_service,
                              ),
                              title: Text(task.taskType.label),
                              subtitle: Text('${task.duration}분'),
                              trailing: _getStatusChip(task.status),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _getStatusChip(String status) {
    Color chipColor;
    String label;

    switch (status) {
      case 'not_started':
        chipColor = Colors.grey;
        label = '시작 전';
        break;
      case 'in_progress':
        chipColor = Colors.blue;
        label = '진행 중';
        break;
      case 'completed':
        chipColor = Colors.green;
        label = '완료';
        break;
      default:
        chipColor = Colors.grey;
        label = '알 수 없음';
    }

    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: chipColor,
    );
  }
}
