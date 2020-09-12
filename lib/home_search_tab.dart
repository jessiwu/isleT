import 'package:flutter/material.dart';

class HomeSearchTab extends StatefulWidget {
  @override
  _HomeSearchTabState createState() => _HomeSearchTabState();
}

class _HomeSearchTabState extends State<HomeSearchTab> {
  FocusNode myFocus;

  _navigateToSearchPage() {
    Navigator.pushNamed(context, '/searchPage');
  }

  @override
  void initState() {
    super.initState();

    myFocus = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myFocus.unfocus();

    return SafeArea(
      top: true,
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildLowerLayer(),
            _buildMiddleSearchBar(),
            _buildUpperLayer(),
          ],
        ),
      ),
    );
  }

  _buildMiddleSearchBar() {
    return Positioned(
      top: 220,
      width: 300,
      height: 60,
      child: TextField(
        focusNode: myFocus,
        enableInteractiveSelection: false,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            fillColor: Colors.white,
            filled: true,
            hintText: 'search your professor'),
        onTap: _navigateToSearchPage,
      ),
    );
  }

  _buildLowerLayer() {
    return Column(
      children: <Widget>[
        Image.asset(
          'images/island.jpg',
          width: 600,
          height: 240,
          fit: BoxFit.fill,
        ),
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
