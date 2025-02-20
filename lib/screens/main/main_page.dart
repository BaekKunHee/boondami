import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/enums/view_mode.dart';
import 'package:jobmoim/models/group.dart';
import 'package:jobmoim/models/member.dart';
import 'package:jobmoim/providers/group_provider.dart';
import 'package:jobmoim/screens/main/widgets/add_task_button.dart';
import 'package:jobmoim/screens/main/widgets/add_task_modal.dart';
import 'package:jobmoim/screens/main/widgets/daily_task_view.dart';
import 'package:jobmoim/widgets/common/bm_dropdown.dart';
import 'package:jobmoim/widgets/common/bm_image.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  Member? selectedMember;
  ViewMode viewMode = ViewMode.daily;
  String? groupId;

  // 전체 선택을 위한 특별한 Member 객체 생성
  final allMember = const Member(
    id: 'all',
    nickname: '전체',
    role: 'all',
  );

  @override
  Widget build(BuildContext context) {
    final groupsAsync = ref.watch(groupProviderProvider);

    if (groupId == null) {
      groupsAsync.whenData((groups) {
        if (groups.isNotEmpty) {
          setState(() {
            groupId = groups.first.id;
          });
        }
      });
    }

    final membersAsync = ref.watch(groupMembersProvider(groupId ?? ''));

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                groupsAsync.when(
                  data: (groups) {
                    final currentGroup = groups.firstWhere(
                      (g) => g.id == groupId,
                      orElse: () =>
                          const Group(id: '', name: '없음', createdAt: null),
                    );
                    return BMPopupMenuButton<Group>(
                      value: currentGroup,
                      items: groups,
                      onChanged: (group) {
                        if (group != null) {
                          setState(() {
                            groupId = group.id;
                          });
                        }
                      },
                      getLabel: (group) => group.name,
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => Text('Error: $error'),
                ),
                const SizedBox(width: 16),
                membersAsync.when(
                  data: (members) => BMPopupMenuButton<Member?>(
                    value: selectedMember ?? allMember,
                    items: [allMember, ...members],
                    hint: '전체',
                    getLabel: (member) => member?.nickname ?? '전체',
                    onChanged: (Member? newValue) {
                      setState(() {
                        selectedMember =
                            newValue?.id == 'all' ? null : newValue;
                      });
                    },
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => Text('Error: $error'),
                ),
                const SizedBox(width: 32),
                const BMImage(
                  imageUrl: 'lib/assets/images/chart.svg',
                  imageType: ImageType.svg,
                ),
                const SizedBox(width: 16),
                const BMImage(
                  imageUrl: 'lib/assets/images/bell.svg',
                  imageType: ImageType.svg,
                ),
                const SizedBox(width: 16),
                const BMImage(
                  imageUrl: 'lib/assets/images/setting.svg',
                  imageType: ImageType.svg,
                ),
              ],
            ),
          ),
          Expanded(
            child: viewMode == ViewMode.daily
                ? DailyTaskView(
                    groupId: groupId ?? '',
                    selectedMember: selectedMember,
                  )
                : Center(
                    child: Text(
                      '월간 뷰',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: AddTaskButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => AddTaskModal(groupId: groupId ?? ''),
          );
        },
      ),
    );
  }
}
