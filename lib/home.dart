// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'home_search_tab.dart';
import 'home_user_tab.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // FocusNode myFocus;
  int _currentIndex = 0;
  final List<Widget> _children = [HomeSearchTab(), UserTab()];

  _bottonNaviBarController(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    // myFocus = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    // myFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // myFocus.unfocus();
    return Scaffold(
        appBar: AppBar(),
        body: _children[_currentIndex],
        // body: SafeArea(
        //   top: true,
        //   child: Container(
        //     child: Stack(
        //       alignment: Alignment.center,
        //       children: <Widget>[
        //         _buildLowerLayer(),
        //         _buildMiddleSearchBar(),
        //         _buildUpperLayer(),
        //       ],
        //     ),
        //   ),
        // ),
        // This trailing comma makes auto-formatting nicer for build methods.
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _bottonNaviBarController,
          items: [
            BottomNavigationBarItem(
              title: Text('search'),
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              title: Text('user'),
              icon: Icon(Icons.account_circle),
            )
          ],
        ));
  }

  _navigateToSearchPage() {
    Navigator.pushNamed(context, '/searchPage');
  }

  _buildMiddleSearchBar() {
    return Positioned(
      top: 220,
      width: 300,
      height: 60,
      child: Material(
        child: TextField(
          // focusNode: myFocus,
          enableInteractiveSelection: false,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              fillColor: Colors.white,
              filled: true,
              hintText: '搜尋'),
          onTap: _navigateToSearchPage,
        ),
      ),
    );
  }

  _buildLowerLayer() {
    return Column(
      children: <Widget>[
        Image.asset(
          'images/lake.jpg',
          width: 600,
          height: 240,
          fit: BoxFit.fill,
        ),
        Text('second column'),
      ],
    );
  }

  _buildUpperLayer() {
    return Positioned(
        top: 10,
        left: 10,
        child: Text(
          '找教授?',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ));
  }
}
