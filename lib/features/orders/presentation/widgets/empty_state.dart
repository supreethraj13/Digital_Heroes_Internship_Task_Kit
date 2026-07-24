import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: const [
        SizedBox(height: 180),
        Icon(Icons.inbox_outlined, size: 56, color: Colors.grey),
        SizedBox(height: 12),
        Center(
          child: Text(
            'No orders yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(height: 6),
        Center(child: Text('Pull down to check again.')),
      ],
    );
  }
}
