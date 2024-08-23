import 'package:flutter/material.dart';
import 'package:navicode/screens/map_screen.dart';
import 'package:navicode/widgets/search_field.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});

  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late double _width; // 가로 길이 저장할 변수
  int _currentIndex = 1; // bottom navigation bar index
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width; // 시작시 화면 가로길이 저장
    return GestureDetector(
      onTap: () => _focusNode.unfocus(), // 다른 곳을 터치할 시 검색창에서 빠져나오기.
      child: Scaffold(
        // 화면 구조 설정
        backgroundColor: const Color.fromRGBO(253, 203, 157, 1),
        appBar: AppBar(
          // 상단 바
          backgroundColor: const Color.fromRGBO(253, 203, 157, 1),
          title: Text(widget.title),
        ),
        drawer: Drawer(
          // 왼쪽 팝업 화면
          child: ListView(
            children: const [
              DrawerHeader(child: Text("s")),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Hello, User'),
                  Text(
                    "네비코드를",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "검색하세요",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SearchField(focusNode: _focusNode),
                  Align(
                    // 정렬 widget
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => {}, // 클릭 시 작동할 함수 지금은 아무것도 없음.
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(23, 20, 51, 1),
                        ),
                      ),
                      child: const Text(
                        "검색",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              // 가능한 모든 크기 차지
              child: Container(
                // 여러 가지 설정을 할 수 있는 단순 box
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                width: _width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "내비코드 검색 기록",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    // Text("2"),
                    Expanded(
                      // 전체 크기 차지
                      child: ListView(
                        // 아래 특정 위젯들을 받을 위젯 column과 비슷함.
                        children: const [
                          ListTile(
                            leading: CircleAvatar(child: Icon(Icons.abc)),
                            title: Text("053#56"),
                            subtitle: Text("3일 전 검색 2024.08.03"),
                            trailing: Icon(Icons.arrow_right),
                          ),
                          ListTile(
                            leading: CircleAvatar(child: Icon(Icons.park)),
                            title: Text("부산 시민공원 분수대"),
                            subtitle: Text("3일 전 검색 2024.08.03"),
                            trailing: Icon(Icons.arrow_right),
                          ),
                          ListTile(
                            leading: CircleAvatar(child: Icon(Icons.abc)),
                            title: Text("053#56"),
                            subtitle: Text("3일 전 검색 2024.08.03"),
                            trailing: Icon(Icons.arrow_right),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          // 하단 바

          currentIndex: _currentIndex,
          onTap: (selectedIndex) => setState(() {
            _currentIndex = selectedIndex;
            if (_currentIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapScreen(),
                ),
              );
            }
          }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.note), label: "Code"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Login"),
          ],
        ),
      ),
    );
  }
}
