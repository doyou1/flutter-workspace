import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_http_sampling/api_provider.dart';
import 'package:riverpod_http_sampling/create_user_screen.dart';

void main() {
  runApp(const ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserListScreen(),
    );
  }
}

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
      ),
      body: userList.when(
          data: (users) {
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (ctx, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                  );
                });
          },
          error: (error, stack) => Text(error.toString()),
          loading: () => const Center(child: CircularProgressIndicator())),
          floatingActionButton: FloatingActionButton(onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateUserScreen())
            );
          }, child: const Icon(Icons.add),),
    );
  }
}
