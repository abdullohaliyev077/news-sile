import 'package:flutter/material.dart';
import 'package:newssile/screens/book_screen.dart';
import 'package:newssile/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int myIndex = 0;
  List<Widget> WidgetList =  [
    HomeScreen(),
    BookScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 60,
            child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Theme.of(context).colorScheme.background,
                selectedItemColor: Color.fromARGB(255, 114, 2, 250),
                unselectedItemColor: Color.fromARGB(255, 180, 127, 254),
                currentIndex: myIndex,
                onTap: (index) {
                  setState(() {
                    myIndex = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white),
                        child: Icon(
                          Icons.home,
                          size: 20,
                        ),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white),
                        child: Icon(
                          Icons.book,
                          size: 20,
                        ),
                      ),
                      label: ''),
                ]),
          ),
        ),
      ),
      body: Center(
        child: WidgetList[myIndex],
      ),
    );
  }
}
