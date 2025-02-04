import 'package:flutter/material.dart';
import 'package:jobmoim/widget/common/bm_switch.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 각 행의 상태를 관리하는 리스트
  final List<bool> _isCompleted = List.generate(3, (_) => false);
  final List<bool> _isStarted = List.generate(3, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      child: ListView.builder(
        itemCount: 3, // 3개의 행을 만듭니다
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // 첫 번째 셀렉트박스
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    hint: const Text('업무'),
                    items: const [
                      DropdownMenuItem(
                        value: '1',
                        child: Text('설거지'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('빨래'),
                      ),
                      DropdownMenuItem(
                        value: '3',
                        child: Text('청소'),
                      ),
                    ],
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                // 두 번째 셀렉트박스
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    hint: const Text('시간'),
                    items: const [
                      DropdownMenuItem(
                        value: '1',
                        child: Text('00:00'),
                      ),
                      DropdownMenuItem(
                        value: '2',
                        child: Text('01:00'),
                      ),
                      DropdownMenuItem(
                        value: '3',
                        child: Text('02:00'),
                      ),
                    ],
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                // 토글 스위치
                const BMSwitch(),
                const SizedBox(width: 8),
                // 버튼
                SizedBox(
                  width: 80,
                  child: ElevatedButton(
                    onPressed: _isCompleted[index]
                        ? null
                        : () {
                            setState(() {
                              if (_isStarted[index]) {
                                _isCompleted[index] = true;
                              }
                              _isStarted[index] = true;
                            });
                          },
                    child: Text(_isStarted[index] && !_isCompleted[index]
                        ? '완료하기'
                        : '시작'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
