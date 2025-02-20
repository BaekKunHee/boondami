import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/providers/group_provider.dart';
import 'package:jobmoim/providers/task_provider.dart';

class AddTaskModal extends ConsumerStatefulWidget {
  final String groupId;

  const AddTaskModal({
    super.key,
    required this.groupId,
  });

  @override
  ConsumerState<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends ConsumerState<AddTaskModal> {
  String? selectedTask;
  final List<String> selectedMembers = [];
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(const Duration(minutes: 30));

  @override
  Widget build(BuildContext context) {
    final membersAsync = ref.watch(groupMembersProvider(widget.groupId));
    final taskCategoriesAsync =
        ref.watch(taskCategoriesProvider(widget.groupId));

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Task Type Dropdown
          DropdownButtonFormField<String>(
            value: selectedTask,
            decoration: const InputDecoration(
              labelText: '태스크 종류',
              border: OutlineInputBorder(),
            ),
            items: taskCategoriesAsync.when(
              data: (categories) => categories
                  .map((type) => DropdownMenuItem(
                        value: type['id'],
                        child: Text(type['name'] ?? ''),
                      ))
                  .toList(),
              loading: () => [],
              error: (error, stack) => [],
            ),
            onChanged: (value) {
              setState(() {
                selectedTask = value;
              });
            },
          ),
          const SizedBox(height: 16),

          // Members Selection
          membersAsync.when(
            data: (members) => Wrap(
              spacing: 8,
              children: members.map((member) {
                final isSelected = selectedMembers.contains(member.id);
                return FilterChip(
                  label: Text(member.nickname),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedMembers.add(member.id);
                      } else {
                        selectedMembers.remove(member.id);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
          ),
          const SizedBox(height: 16),

          // Start Time
          ListTile(
            title: const Text('시작 시간'),
            subtitle: Text(
              '${startTime.year}-${startTime.month}-${startTime.day} ${startTime.hour}:${startTime.minute}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.access_time),
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(startTime),
                );
                if (time != null) {
                  setState(() {
                    startTime = DateTime(
                      startTime.year,
                      startTime.month,
                      startTime.day,
                      time.hour,
                      time.minute,
                    );
                  });
                }
              },
            ),
          ),

          // End Time
          ListTile(
            title: const Text('종료 시간'),
            subtitle: Text(
              '${endTime.year}-${endTime.month}-${endTime.day} ${endTime.hour}:${endTime.minute}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.access_time),
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(endTime),
                );
                if (time != null) {
                  setState(() {
                    endTime = DateTime(
                      endTime.year,
                      endTime.month,
                      endTime.day,
                      time.hour,
                      time.minute,
                    );
                  });
                }
              },
            ),
          ),

          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('취소'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: selectedTask != null && selectedMembers.isNotEmpty
                      ? () async {
                          final params = TaskCreateParams(
                            groupId: widget.groupId,
                            categoryId: selectedTask!,
                            title: '새로운 태스크',
                            description: '새로운 태스크 설명',
                            memberIds: selectedMembers,
                            startTime: startTime,
                            endTime: endTime,
                          );

                          try {
                            await ref.read(taskAddProvider(params).future);
                            if (!mounted) return;

                            // 성공 메시지 표시
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('태스크가 등록되었습니다')),
                            );

                            // 태스크 목록 새로고침
                            ref.refresh(groupTasksProvider(widget.groupId));

                            Navigator.pop(context);
                          } catch (e) {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('등록 실패: $e')),
                            );
                          }
                        }
                      : null,
                  child: const Text('등록'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
