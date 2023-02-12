import 'dart:developer';

import 'package:cupid/provider/confession_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfessionScreeen extends StatefulWidget {
  const ConfessionScreeen({super.key});

  @override
  State<ConfessionScreeen> createState() => _ConfessionScreeenState();
}

class _ConfessionScreeenState extends State<ConfessionScreeen> {
  @override
  void initState() {
    log('message');
    Future.microtask(() {
      Provider.of<ConfessionProvider>(context, listen: false)
          .getAllConfession();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confession"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ConfessionProvider>(
          builder: (context, snapshot, _) => Column(
            children: [
              snapshot.isLoading || snapshot.getConfessionData == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.getConfessionData!.results.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(snapshot
                                    .getConfessionData!.results[index].message
                                    .toString()),
                                subtitle: Text(snapshot
                                    .getConfessionData!.results[index].nickname
                                    .toString()),
                              ),
                            );
                          })),
              Row(
                children: [
                  // ignore: prefer_const_constructors
                  Expanded(
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confession',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        log('message');
                      },
                      child: const Icon(Icons.send)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
