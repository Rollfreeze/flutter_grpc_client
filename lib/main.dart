// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/network/client.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final grpcCleint = GrpcClient.create();
  String answer = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => grpcCleint.greetServer(cleintName: 'Cleint').then(
                      (value) => setState(() => answer = value),
                    ),
                child: Text('Say Hello to Server'),
              ),
              const SizedBox(height: 10),
              Text('Current answer is: $answer'),
            ],
          ),
        ),
      ),
    );
  }
}
