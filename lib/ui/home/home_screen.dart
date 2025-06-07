import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common/models/goal/dto/create_goal_dto.dart';
import 'package:flutter_common/models/goal/goal.dart';
import 'package:flutter_common/models/user/user.dart';
import 'package:flutter_common/state/goal/goal_bloc.dart';
import 'package:flutter_common/state/goal/goal_event.dart';
import 'package:flutter_common/state/goal/goal_selector.dart';
import 'package:flutter_common/widgets/ui/goal/goal_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jaksim_one_month/core/constants/app_constants.dart';
import 'package:jaksim_one_month/route.dart';
import 'package:jaksim_one_month/state/home/home_bloc.dart';
import 'package:jaksim_one_month/state/home/home_event.dart';
import 'package:jaksim_one_month/state/home/home_selector.dart';
import 'package:jaksim_one_month/ui/home/widgets/add_goal_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc get homeBloc => context.read<HomeBloc>();
  GoalBloc get goalBloc => context.read<GoalBloc>();
  int _selectedIndex = 0;
  User? _user;
  void _addGoal() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const AddGoalDialog(),
    );

    if (result != null) {
      final createGoalDto = CreateGoalDto(
          title: result['title'],
          description: result['title'],
          startDate: result['startDate'],
          endDate: result['startDate'].add(Duration(days: result['duration'])),
          userId: _user?.id ?? '');

      goalBloc.add(GoalEvent.createGoal(createGoalDto));
    }
  }

  @override
  void initState() {
    super.initState();
    homeBloc.add(const HomeEvent.initialize());
    goalBloc.add(const GoalEvent.initialize());
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
                        AppConstants.appName,
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
                      UserSelector((user) {
                        _user = user;
                        if (user == null) {
                          return const SizedBox.shrink();
                        }
                        return IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: _addGoal,
                        );
                      }),
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
              child: GoalsSelector((goals) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    return GoalCard(
                      goal: goal,
                      onLike: () {},
                      onDetail: () {
                        AppNavigator.push<Goal>(Routes.goalDetail, goal);
                      },
                    );
                  },
                );
              }),
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
}
