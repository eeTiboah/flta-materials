import 'package:flutter/material.dart';
import '../components/components.dart';
import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
// 1
  final mockService = MockFooderlichService();

  final ScrollController _controller = ScrollController();

  void _onScrollEvent() {
    final extentAfter = _controller.position.extentAfter;
    if (extentAfter == 0) {
      print('I am at the bottom');
    }
    print("Extent after: $extentAfter");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(_onScrollEvent);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.removeListener(_onScrollEvent);
  }

  @override
  Widget build(BuildContext context) {
// 2
// TODO: Add TodayRecipeListView FutureBuilder
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final recipes = snapshot.data?.todayRecipes ?? [];
          final friendPosts = snapshot.data?.friendPosts ?? [];
          return ListView(
            controller: _controller,
            children: [
              TodayRecipeListView(recipes: recipes),
              const SizedBox(
                height: 16,
              ),
              FriendPostListView(friendPosts: friendPosts)
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
