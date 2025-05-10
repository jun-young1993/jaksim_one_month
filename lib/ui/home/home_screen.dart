import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jaksim_one_month/ui/home/screens/goal_detail_screen.dart';
import 'package:jaksim_one_month/ui/home/widgets/add_goal_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _goals = [
    {
      'title': '매일 10분 책읽기',
      'progress': 0.4,
      'daysLeft': 15,
      'participants': 5,
      'isGroup': true,
    },
    {
      'title': '매일 운동 20분',
      'progress': 0.6,
      'daysLeft': 20,
      'participants': 8,
      'isGroup': true,
    },
  ];

  void _addGoal() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const AddGoalDialog(),
    );

    if (result != null) {
      setState(() {
        _goals.add({
          'title': result['title'],
          'progress': 0.0,
          'daysLeft': result['duration'],
          'participants': result['isGroup'] ? 1 : 0,
          'isGroup': result['isGroup'],
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 상단 앱바
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/logo.svg',
                        height: 32,
                        width: 32,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '작심한달',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          // TODO: 그룹 검색
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: _addGoal,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 탭 바
            Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildTab('참여중인 목표', 0),
                  _buildTab('추천 목표', 1),
                  _buildTab('인기 목표', 2),
                ],
              ),
            ),

            // 목표 리스트
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  final goal = _goals[index];
                  return _buildGoalCard(
                    title: goal['title'],
                    progress: goal['progress'],
                    daysLeft: goal['daysLeft'],
                    participants: goal['participants'],
                    isGroup: goal['isGroup'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoalCard({
    required String title,
    required double progress,
    required int daysLeft,
    required int participants,
    required bool isGroup,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isGroup) ...[
                        const SizedBox(height: 4),
                        Text(
                          '$participants명 참여중',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  'D-$daysLeft',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(progress * 100).toInt()}% 완료',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                Row(
                  children: [
                    if (isGroup)
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          // TODO: 좋아요 기능
                        },
                      ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoalDetailScreen(
                              title: title,
                              progress: progress,
                              daysLeft: daysLeft,
                            ),
                          ),
                        );
                      },
                      child: const Text('상세보기'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
