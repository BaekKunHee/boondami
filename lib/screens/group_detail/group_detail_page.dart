import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobmoim/providers/group_provider.dart';

class GroupDetailPage extends ConsumerWidget {
  final String groupId;

  const GroupDetailPage({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('그룹 관리'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              _showInviteDialog(context, ref);
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final groupsAsync = ref.watch(groupProviderProvider);

          return groupsAsync.when(
            data: (groups) {
              final group = groups.firstWhere((g) => g.id == groupId);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 그룹 정보
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              group.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('멤버: ${group.memberCount}명'),
                            Text(
                                '생성일: ${group.createdAt.toString().split(' ')[0]}'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 여기에 추가 기능 구현 가능
                    // - 멤버 목록
                    // - 그룹 설정
                    // - 작업 목록 등
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }

  void _showInviteDialog(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('멤버 초대'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('초대할 멤버의 이메일을 입력하세요'),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (emailController.text.isEmpty) {
                return;
              }
              try {
                await ref.read(groupProviderProvider.notifier).inviteMember(
                      groupId: groupId,
                      email: emailController.text,
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('초대를 보냈습니다')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('초대 실패: $e')),
                  );
                }
              }
            },
            child: const Text('초대'),
          ),
        ],
      ),
    );
  }
}
