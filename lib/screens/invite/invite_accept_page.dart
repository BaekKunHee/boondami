import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jobmoim/providers/group_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InviteAcceptPage extends ConsumerStatefulWidget {
  final String inviteId;

  const InviteAcceptPage({super.key, required this.inviteId});

  @override
  ConsumerState<InviteAcceptPage> createState() => _InviteAcceptPageState();
}

class _InviteAcceptPageState extends ConsumerState<InviteAcceptPage> {
  bool _isLoading = true;
  String? _error;
  Map<String, dynamic>? _inviteData;

  @override
  void initState() {
    super.initState();
    _checkInvite();
  }

  Future<void> _checkInvite() async {
    try {
      final supabase = Supabase.instance.client;

      // 1. 초대 정보 확인
      final response = await supabase
          .from('group_invitations')
          .select('*, groups(name)')
          .eq('id', widget.inviteId)
          .single();

      if (response['status'] != 'pending') {
        setState(() {
          _error = '이미 처리된 초대입니다.';
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _inviteData = response;
        _isLoading = false;
      });

      // 2. 로그인 상태 확인
      final user = supabase.auth.currentUser;
      if (user == null) {
        // 비로그인 상태면 로그인/회원가입 페이지로 이동
        if (context.mounted) {
          context.go('/login', extra: {'inviteId': widget.inviteId});
        }
      } else if (user.email == response['invitee_email']) {
        // 이메일이 일치하면 자동으로 수락
        await _acceptInvite();
      } else {
        setState(() {
          _error = '초대된 이메일과 현재 로그인된 계정이 다릅니다.';
        });
      }
    } catch (e) {
      setState(() {
        _error = '초대 정보를 불러오는데 실패했습니다.';
        _isLoading = false;
      });
    }
  }

  Future<void> _acceptInvite() async {
    setState(() => _isLoading = true);
    try {
      await ref
          .read(groupProviderProvider.notifier)
          .acceptInvite(widget.inviteId);
      if (context.mounted) {
        context.go('/main');
      }
    } catch (e) {
      setState(() {
        _error = '초대 수락에 실패했습니다.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_error!, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go('/main'),
                  child: const Text('홈으로 이동'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_inviteData!['groups']['name']} 그룹에\n초대되었습니다',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _acceptInvite,
                child: const Text('수락하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
