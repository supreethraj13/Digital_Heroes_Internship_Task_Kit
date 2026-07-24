import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({this.isOffline = false, super.key});

  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (isOffline) ...[
            const SizedBox(height: 14),
            const Text('Waiting for internet connection...'),
          ],
        ],
      ),
    );
  }
}
