import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/models/group.dart';
import 'package:jobmoim/models/member.dart';
import 'package:jobmoim/providers/group_provider.dart';

class GroupDetailPage extends ConsumerStatefulWidget {
  final String groupId;

  const GroupDetailPage({super.key, required this.groupId});

  @override
  ConsumerState<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends ConsumerState<GroupDetailPage> {
  Member? selectedMember;
  ViewMode viewMode = ViewMode.daily;

  @override
  Widget build(BuildContext context) {
    final groupsAsync = ref.watch(groupProviderProvider);
    final membersAsync = ref.watch(groupMembersProvider(widget.groupId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('그룹 상세'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: groupsAsync.when(
                    data: (groups) {
                      final currentGroup = groups.firstWhere(
                        (g) => g.id == widget.groupId,
                        orElse: () =>
                            const Group(id: '', name: '없음', createdAt: null),
                      );
                      return Text(
                        currentGroup.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: membersAsync.when(
                    data: (members) => DropdownButton<Member?>(
                      value: selectedMember,
                      hint: const Text('전체 멤버'),
                      items: [
                        const DropdownMenuItem<Member?>(
                          value: null,
                          child: Text('전체'),
                        ),
                        ...members.map((member) => DropdownMenuItem<Member>(
                              value: member,
                              child: Text(member.nickname),
                            )),
                      ],
                      onChanged: (Member? newValue) {
                        setState(() {
                          selectedMember = newValue;
                        });
                      },
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                  ),
                ),
                const SizedBox(width: 16),
                ToggleButtons(
                  isSelected: [
                    viewMode == ViewMode.daily,
                    viewMode == ViewMode.monthly,
                  ],
                  onPressed: (int index) {
                    setState(() {
                      viewMode = index == 0 ? ViewMode.daily : ViewMode.monthly;
                    });
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('일'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('월'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                viewMode == ViewMode.daily ? '일간 뷰' : '월간 뷰',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ViewMode {
  daily,
  monthly,
}
