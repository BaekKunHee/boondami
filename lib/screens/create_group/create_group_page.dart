import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobmoim/providers/group_provider.dart';
import 'package:jobmoim/widgets/common/bm_button.dart';

class CreateGroupPage extends ConsumerWidget {
  const CreateGroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('채널 만들기'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '최대 10명이 참여하는 그룹채널을 만들어요!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // 채널 이름 입력 필드
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '채널 이름',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: groupNameController,
                      decoration: const InputDecoration(
                        hintText: '무작위',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 80, // 버튼 너비 고정
                    child: BMButton(
                      onPressed: () async {
                        if (groupNameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('채널 이름을 입력해주세요')),
                          );
                          return;
                        }

                        try {
                          await ref
                              .read(groupProviderProvider.notifier)
                              .createGroup(name: groupNameController.text);
                          if (context.mounted) {
                            context.pop();
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('채널 생성 실패: $e')),
                            );
                          }
                        }
                      },
                      text: '생성',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                '* 가사파트너(그룹멤버)는 채널을 먼저 생성한 후 초대해요.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              // 이미지
              const SizedBox(height: 32),
              Center(
                child: Image.asset(
                  'assets/images/create_channel.png',
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.group_add,
                      size: 100,
                      color: Colors.grey,
                    );
                  },
                ),
              ),

              // 뒤로가기 버튼
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue.shade50,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '뒤로',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
