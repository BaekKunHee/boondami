import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobmoim/providers/group_provider.dart';
import 'package:jobmoim/widget/common/bottom_nav_bar.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // TODO: 메뉴 기능 구현
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로필 섹션
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 24),

              // 앱 공유하기 섹션
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.link, size: 32, color: Colors.blue.shade700),
                        const SizedBox(width: 12),
                        const Text(
                          '앱 공유하기',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '함께할 파트너 및 지인들과\n앱 다운로드 링크를 공유해 보세요!',
                      style: TextStyle(
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 그룹 리스트 섹션
              const Text(
                '나의 그룹',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Consumer(
                builder: (context, ref, child) {
                  final groupsAsync = ref.watch(groupProviderProvider);

                  return groupsAsync.when(
                    data: (groups) {
                      if (groups.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('참여 중인 그룹이 없습니다'),
                          ),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: groups.length,
                        itemBuilder: (context, index) {
                          final group = groups[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              onTap: () {
                                context.push('/group/${group.id}');
                              },
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                child: const Icon(Icons.group),
                              ),
                              title: Text(group.name),
                              subtitle: Text(
                                  '${group.memberCount}명의 멤버 · ${group.createdAt.toString().split(' ')[0]}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {
                                  // TODO: 그룹 공유 기능 구현
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stack) => Center(
                      child: Text('Error: $error'),
                    ),
                  );
                },
              ),

              // 액션 버튼들
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      context,
                      '채널 만들기',
                      Icons.group_add,
                      () {
                        context.push('/create-group');
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionButton(
                      context,
                      'TBD',
                      Icons.person_add,
                      () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 28),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
