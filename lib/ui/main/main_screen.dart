import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_common/widgets/error_view.dart';
import 'package:jaksim_one_month/state/home/home_bloc.dart';
import 'package:jaksim_one_month/state/home/home_event.dart';
import 'package:jaksim_one_month/state/home/home_selector.dart';
import 'package:jaksim_one_month/ui/home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final int _currentIndex = 0;
  late final List<Widget> _screens;
  HomeBloc get homeBloc => context.read<HomeBloc>();

  @override
  void initState() {
    super.initState();
    _screens = [const HomeScreen(), const Text('설정')];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        child: ExceptionSelector(
          (exception) {
            if (exception == null) {
              return IndexedStack(index: _currentIndex, children: _screens);
            }
            return ErrorView(
                error: exception,
                onRetry: () {
                  homeBloc.add(const HomeEvent.clearError());
                });
          },
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Theme.of(context).colorScheme.primary,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: AppConstants.home,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: AppConstants.settings,
      //     ),
      //   ],
      // ),
    );
  }
}
