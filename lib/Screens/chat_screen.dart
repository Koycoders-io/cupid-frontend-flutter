import 'dart:developer';

import 'package:cupid/Screens/create_message.dart';
import 'package:cupid/provider/confession_provider.dart';
import 'package:cupid/utils/color_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    log('message');
    Future.microtask(() {
      ConfessionProvider confessionProvider =
          Provider.of<ConfessionProvider>(context, listen: false);
      confessionProvider.getAllConfession();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent &&
            confessionProvider.getConfessionData!.next != 'null') {
          confessionProvider
              .getPaginated(confessionProvider.getConfessionData!.next);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorClass.primaryColorDark,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CreateMessage();
          }));
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: ColorClass.primaryColor,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: ColorClass.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'M',
                          style: TextStyle(
                              color: ColorClass.primaryColorDark,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: ColorClass.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'F',
                          style: TextStyle(
                              color: ColorClass.primaryColorDark,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: ColorClass.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'A',
                          style: TextStyle(
                              color: ColorClass.primaryColorDark,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: CupertinoSearchTextField(
                      placeholder: 'Search',
                      suffixIcon: Icon(
                        Icons.search,
                        color: ColorClass.primaryColorDark,
                      ),
                      backgroundColor: ColorClass.whiteColor,
                      placeholderStyle: TextStyle(
                          color: ColorClass.primaryColorDark,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
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
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Confessions',
                      style: TextStyle(
                          color: ColorClass.blackColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Consumer<ConfessionProvider>(
                  builder: (context, snapshot, _) => snapshot.isLoading ||
                          snapshot.getConfessionData == null
                      ? const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              controller: _scrollController,
                              // physics: const BouncingScrollPhysics(),
                              itemCount:
                                  snapshot.getConfessionData!.results.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 08.0),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    width: double.infinity,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: ColorClass.whiteColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "||   ${snapshot.getConfessionData!.results[index].nickname.toString()}",
                                              style: const TextStyle(
                                                  color: ColorClass
                                                      .primaryColorDark,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.ios_share_outlined,
                                                    color: ColorClass
                                                        .purpleColorLight)),
                                          ],
                                        ),
                                        const Divider(
                                          color: ColorClass.purpleColorLight,
                                          thickness: 1,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                snapshot.getConfessionData!
                                                    .results[index].message
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: ColorClass
                                                        .purpleColorLight,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                              }))),
              if (context.read<ConfessionProvider>().isPaginationLoading)
                Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )
            ],
          )),
    );
  }
}
