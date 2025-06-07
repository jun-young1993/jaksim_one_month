import 'package:flutter/material.dart';
import 'package:flutter_common/models/goal/dto/create_goal_progress_dto.dart';
import 'package:flutter_common/models/goal/goal.dart';
import 'package:flutter_common/state/goal/goal_bloc.dart';
import 'package:flutter_common/state/goal/goal_event.dart';
import 'package:flutter_common/widgets/ui/goal/goal_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jaksim_one_month/state/home/home_selector.dart';
import 'package:intl/intl.dart';

class GoalDetailScreen extends StatefulWidget {
  final Goal goal;

  const GoalDetailScreen({
    super.key,
    required this.goal,
  });

  @override
  State<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen> {
  GoalBloc get goalBloc => context.read<GoalBloc>();
  void _showGoalCheckDialog({
    required Function(DateTime date, String title, String description) onCheck,
  }) {
    final now = DateTime.now();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 날짜 표시
              Text(
                DateFormat('yyyy년 MM월 dd일').format(now),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),

              // 제목 입력 필드
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: '제목',
                  hintText: '오늘의 목표 제목을 입력해주세요',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.title),
                ),
              ),
              const SizedBox(height: 16),

              // 설명 입력 필드
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: '설명',
                  hintText: '오늘의 목표 달성에 대한 설명을 입력해주세요',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // 목표 달성 확인 메시지
              const Text(
                '오늘의 목표를 달성하셨나요?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),

              // 인증 이미지/동영상 업로드 섹션
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: const Column(
                  children: [
                    Text(
                      '인증하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 버튼들
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      '취소',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('제목을 입력해주세요'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      Navigator.pop(context);
                      onCheck(now, titleController.text,
                          descriptionController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      '달성 완료',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.grey.shade700),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoalDetail(goal: widget.goal),
        floatingActionButton: UserSelector((user) {
          if (user == null) {
            return const SizedBox.shrink();
          }
          final userId = user.id;
          final goalUser = widget.goal.goalUsers
              ?.firstWhere((element) => element.userId == userId);
          if (goalUser == null) {
            return const SizedBox.shrink();
          }

          final hasProgressToday = goalUser.hasProgressToday;
          if (hasProgressToday) {
            return const SizedBox.shrink();
          }

          // final bool isProgress = goalUser.goalProgresses
          //     .any((element) => element.date.isSameDate(DateTime.now()));
          return FloatingActionButton(
            onPressed: () =>
                _showGoalCheckDialog(onCheck: (date, title, description) {
              goalBloc.add(GoalEvent.addGoalProgress(CreateGoalProgressDto(
                goalId: goalUser.goalId,
                goalUserId: goalUser.id,
                date: date,
                title: title,
                description: description,
                isCompleted: true,
              )));
            }),
            child: const Icon(Icons.check),
          );
        }));
  }
}
