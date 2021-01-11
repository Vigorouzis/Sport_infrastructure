import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemBuilder: (context, index) => Container(
                child: ListTile(
                  leading: Text('$index'),
                  title: Column(
                    children: [
                      Text('List text'),
                    ],
                  ),
                ),
              )),
    );
  }
}
