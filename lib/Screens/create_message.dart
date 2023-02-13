import 'package:cupid/provider/confession_provider.dart';
import 'package:cupid/utils/color_class.dart';
import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CreateMessage extends StatefulWidget {
  const CreateMessage({super.key});

  @override
  State<CreateMessage> createState() => _CreateMessageState();
}

class _CreateMessageState extends State<CreateMessage> {
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.primaryColor,
      body: Consumer<ConfessionProvider>(
        builder: (context, snapshot, child) => Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        "Spill it...",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: ColorClass.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: nicknameController,
                        decoration: const InputDecoration(
                            hintText: "LoveBug, Angel, mermaid, etc.",
                            label: Text('Nickname'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                color: ColorClass.primaryColorDark,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Text('Your Gender',
                              style: TextStyle(
                                  color: ColorClass.primaryColorDark,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(
                            width: 10,
                          ),
                          Text('||',
                              style: TextStyle(
                                  color: ColorClass.greyColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              snapshot.setGenderId = 1;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              // width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: snapshot.selectedGenderId == 1
                                      ? ColorClass.greyColor
                                      : ColorClass.primaryColorDark,
                                ),
                                color: snapshot.selectedGenderId == 1
                                    ? ColorClass.whiteColor
                                    : ColorClass.primaryColorDark,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.female,
                                      color: snapshot.selectedGenderId == 1
                                          ? ColorClass.primaryColorDark
                                          : ColorClass.whiteColor,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "F",
                                      style: TextStyle(
                                          color: snapshot.selectedGenderId == 1
                                              ? ColorClass.primaryColorDark
                                              : ColorClass.whiteColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              snapshot.setGenderId = 0;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              // width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: snapshot.selectedGenderId == 0
                                      ? ColorClass.greyColor
                                      : ColorClass.primaryColorDark,
                                ),
                                color: snapshot.selectedGenderId == 0
                                    ? ColorClass.whiteColor
                                    : ColorClass.primaryColorDark,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.male,
                                      color: snapshot.selectedGenderId == 0
                                          ? ColorClass.primaryColorDark
                                          : ColorClass.whiteColor,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "M",
                                      style: TextStyle(
                                          color: snapshot.selectedGenderId == 0
                                              ? ColorClass.primaryColorDark
                                              : ColorClass.whiteColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              snapshot.setGenderId = 2;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              // width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: snapshot.selectedGenderId == 2
                                      ? ColorClass.greyColor
                                      : ColorClass.primaryColorDark,
                                ),
                                color: snapshot.selectedGenderId == 2
                                    ? ColorClass.whiteColor
                                    : ColorClass.primaryColorDark,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.transgender,
                                      color: snapshot.selectedGenderId == 2
                                          ? ColorClass.primaryColorDark
                                          : ColorClass.whiteColor,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "O",
                                      style: TextStyle(
                                          color: snapshot.selectedGenderId == 2
                                              ? ColorClass.primaryColorDark
                                              : ColorClass.whiteColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: messageController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                            hintText:
                                "Are you a magician? Because whenever I look at you, everyone else disappears.",
                            label: Text('Your confession'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                color: ColorClass.primaryColorDark,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(child: Container()),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 0),
                                backgroundColor: ColorClass.greyColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: const Icon(Icons.close),
                              label: const Text('cancel'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (messageController.text.isEmpty) {
                                  FloatingSnackBar(
                                      message: 'Enter a message',
                                      context: context);
                                } else if (nicknameController.text.isEmpty) {
                                  FloatingSnackBar(
                                      message: 'Enter a nickname',
                                      context: context);
                                } else {
                                  _showDialog(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 0),
                                backgroundColor: ColorClass.primaryColorDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: const Icon(Icons.send),
                              label: const Text('Send'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      builder: (context) => CupertinoAlertDialog(
        title: Column(
          children: const <Widget>[
            // Text("ഒകെ ഡാ."),
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ],
        ),
        content: const Text("ഇപ്പൊ ശെരി ആക്കി തരാം 🥳"),
        actions: <Widget>[
          Consumer<ConfessionProvider>(
            builder: (context, snapshot, child) => CupertinoDialogAction(
              child: const Text("വേഗം ആവട്ടെ 😌"),
              onPressed: () {
                snapshot.retriveUser(
                    context: context,
                    message: messageController.text,
                    nickname: nicknameController.text);
              },
            ),
          ),
        ],
      ),
      context: context,
    );
  }
}
