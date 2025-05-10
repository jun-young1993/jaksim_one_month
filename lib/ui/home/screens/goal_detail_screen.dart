import 'package:flutter/material.dart';

class GoalDetailScreen extends StatefulWidget {
  final String title;
  final double progress;
  final int daysLeft;
  final bool isGroup;
  final int participants;

  const GoalDetailScreen({
    super.key,
    required this.title,
    required this.progress,
    required this.daysLeft,
    this.isGroup = false,
    this.participants = 0,
  });

  @override
  State<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen> {
  // 임시 데이터
  final List<Map<String, dynamic>> _participants = [
    {'name': '김철수', 'progress': 0.8, 'rank': 1},
    {'name': '이영희', 'progress': 0.75, 'rank': 2},
    {'name': '박지민', 'progress': 0.6, 'rank': 3},
    {'name': '최수진', 'progress': 0.4, 'rank': 4},
    {'name': '정민수', 'progress': 0.3, 'rank': 5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 상단 앱바
          SliverAppBar(
            title: Text(widget.title),
            floating: true,
            snap: true,
            actions: [
              if (widget.isGroup)
                IconButton(
                  icon: const Icon(Icons.people),
                  onPressed: () {
                    // TODO: 참여자 목록 보기
                  },
                ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // TODO: 목표 수정 기능
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // TODO: 목표 삭제 기능
                },
              ),
            ],
          ),
          // 본문 내용
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 진행 상황 카드
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '진행 상황',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (widget.isGroup)
                                Text(
                                  '${widget.participants}명 참여중',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'D-${widget.daysLeft}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${(widget.progress * 100).toInt()}% 완료',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: widget.progress,
                              backgroundColor: Colors.grey[200],
                              minHeight: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 참여자 진행률 카드
                  if (widget.isGroup)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '참여자 진행률',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // TODO: 전체 순위 보기
                                  },
                                  child: const Text('전체 순위'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _participants.length,
                              itemBuilder: (context, index) {
                                final participant = _participants[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: index < 3
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Colors.grey[300],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${participant['rank']}',
                                            style: TextStyle(
                                              color: index < 3
                                                  ? Colors.white
                                                  : Colors.grey[700],
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              participant['name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              child: LinearProgressIndicator(
                                                value: participant['progress'],
                                                backgroundColor:
                                                    Colors.grey[200],
                                                minHeight: 4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        '${(participant['progress'] * 100).toInt()}%',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  // 달력 뷰
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '체크 기록',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // TODO: 달력 위젯 구현
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(child: Text('달력이 들어갈 자리')),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 통계 카드
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '통계',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem('연속 달성', '5일'),
                              _buildStatItem('전체 달성', '15일'),
                              _buildStatItem(
                                '달성률',
                                '${(widget.progress * 100).toInt()}%',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.isGroup) ...[
                    const SizedBox(height: 16),
                    // 그룹 피드 카드
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '그룹 피드',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // TODO: 그룹 피드 구현
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(child: Text('그룹 피드가 들어갈 자리')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  // 하단 여백
                  const SizedBox(height: 80), // FAB를 위한 여백
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: 오늘의 목표 체크 기능
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }
}
