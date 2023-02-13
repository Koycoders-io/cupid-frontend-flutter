import 'package:cupid/Screens/chat_screen.dart';
import 'package:cupid/provider/confession_provider.dart';
import 'package:cupid/utils/color_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ParkListScreen extends StatefulWidget {
  const ParkListScreen({super.key});

  @override
  State<ParkListScreen> createState() => _ParkListScreenState();
}

class _ParkListScreenState extends State<ParkListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass.primaryColor,
      body: Consumer<ConfessionProvider>(
        builder: (context, value, child) => Padding(
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
                // ignore: prefer_const_constructors
                Text(
                  "Where are you from?",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 35,
                ),

                InkWell(
                  onTap: () {
                    value.setOrgName = 'sahya';
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ChatScreen();
                    }));
                  },
                  child: Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/sahya.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      "Sahya",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 100,
                          fontWeight: FontWeight.w400),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    value.setOrgName = 'ul-cyberpark';
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ChatScreen();
                    }));
                  },
                  child: Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/ulpark.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      "UL",
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 100,
                          fontWeight: FontWeight.w400),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    value.setOrgName = 'business-park';
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ChatScreen();
                    }));
                  },
                  child: Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/businesspark.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      "Business\nPark",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.w400),
                    )),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
