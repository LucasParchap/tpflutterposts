import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shared/blocs/post_bloc.dart';
import 'shared/services/posts_repository/posts_repository.dart';
import 'shared/services/local_posts_data_source/fake_posts_data_source.dart';
import 'screens/posts_screen.dart';
import 'screens/post_detail_screen.dart';
import 'shared/models/Post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostRepository(
        postsDataSource: FakePostsDataSource(),
      ),
      child: BlocProvider(
        create: (context) => PostBloc(
          postRepository: context.read<PostRepository>(),
        )..add(const GetAllPosts()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Posts App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (context) => PostsScreen(),
          },
          onGenerateRoute: (routeSettings) {
            Widget screen = const Scaffold(
              body: Center(
                child: Text('Page not found!'),
              ),
            );
            final arguments = routeSettings.arguments;
            switch (routeSettings.name) {
              case '/postDetail':
                if (arguments is Post) {
                  screen = PostDetailScreen(post: arguments);
                }
                break;
            }
            return MaterialPageRoute(builder: (context) => screen);
          },
        ),
      ),
    );
  }
}
