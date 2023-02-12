import 'dart:developer';

import 'package:cupid/provider/confession_provider.dart';
import 'package:cupid/utils/color_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
      backgroundColor: ColorClass.primaryColor,
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorClass.primaryColorDark,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/koco.svg',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Consumer<ConfessionProvider>(
                  builder: (context, snapshot, _) => snapshot.isLoading ||
                          snapshot.getConfessionData == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount:
                                  snapshot.getConfessionData!.results.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(snapshot.getConfessionData!
                                        .results[index].message
                                        .toString()),
                                    subtitle: Text(snapshot.getConfessionData!
                                        .results[index].nickname
                                        .toString()),
                                  ),
                                );
                              }))),
            ],
          )),
    );
  }
}
