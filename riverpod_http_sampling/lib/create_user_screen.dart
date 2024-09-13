import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_http_sampling/api_provider.dart';

class CreateUserScreen extends ConsumerWidget {

  final _nameController = TextEditingController();
  final _jobController = TextEditingController();

  CreateUserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Create User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _jobController,
              decoration: InputDecoration(labelText: "Job"),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async {
              final name = _nameController.text;
              final job = _jobController.text;
              await ref.read(createUserProvider.notifier).createUser(name, job);
            }, child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}