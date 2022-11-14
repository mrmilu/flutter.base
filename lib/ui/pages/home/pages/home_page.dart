import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  final Widget child;

  const HomePage({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // ref.watch(notificationsProvider);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: widget.child),
        CupertinoTabBar(
          currentIndex: _calculateSelectedIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.list_bullet)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled)),
          ],
          onTap: _onItemTapped,
        )
      ],
    );
  }

  int get _calculateSelectedIndex {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    switch (location) {
      case "/home":
        return 0;
      case "/profile":
        return 1;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
        break;
      case 1:
        GoRouter.of(context).go('/profile');
        break;
    }
  }
}
