import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:islet/app.dart';
import 'package:islet/theme/theme.dart';

import 'theme/colors.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchBarTextController = TextEditingController();
  String _userType = '';
  String _previousSearchWord = '';

  Widget _searchBar(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
        height: 60,
        width: width,
        decoration: BoxDecoration(
          color: kisleTPrimaryGreenLight,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 50.0, // softening the shadow
              spreadRadius: 15.0, // extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                100.0, // vertical, move down 10
              ),
            )
          ],
        ),
        alignment: Alignment(0.0, 0.6),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: '搜尋',
              // border: OutlineInputBorder(),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
            ),
            textAlignVertical: TextAlignVertical.center,
            controller: _searchBarTextController,
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(BuildContext context, DocumentSnapshot snapshot) {
    return ListTile(
      key: Key(snapshot.documentID),
      title: Text(snapshot.data['fullName']),
      subtitle: Text(snapshot.data['school']),
      onTap: () => print('haha'),
    );
  }

  Widget _buildSuggestionCard(BuildContext context, DocumentSnapshot snapshot) {
    return Container(
      height: 100.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 6.0),
      child: Card(
        // margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 6.0),
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: InkWell(
          radius: 500,
          splashColor: kisleTPrimaryGreen.withAlpha(80),
          onTap: () {
            print('Card tapped.');
          },
          child: ListTile(
            key: Key(snapshot.documentID),
            title: Text(snapshot.data['fullName']),
            subtitle: Text(snapshot.data['school']),
            // onTap: () => print('haha'),
            onTap: () => _navigateToReviewPage(snapshot.data['fullName']),
          ),
        ),
      ),
    );
  }

  _navigateToReviewPage(String professorName) {
    Navigator.pushNamed(context, '/reviewPage', arguments: professorName);
  }

  Widget _buildSuggestionList(
      BuildContext context, List<DocumentSnapshot> snapshots) {
    print(snapshots.length);
    return Container(
      // alignment: Alignment.topLeft,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: snapshots.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildSuggestionCard(context, snapshots[index]),
      ),
    );
  }

  Widget _searchResult(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Flexible(
        child: (_userType != '')
            ? StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collectionGroup('professors')
                    .where('lastName', isEqualTo: _userType)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return LinearProgressIndicator();
                    default:
                      return (snapshot.data.documents.length != 0)
                          ? _buildSuggestionList(
                              context, snapshot.data.documents)
                          : ListTile(title: Text('No result...'));
                  }
                })
            : SizedBox());
  }

  Widget _searchResultInDatabase(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    Stream<QuerySnapshot> _searchByLastName;
    if (_userType.length == 0) {
      // user type nothing OR has deleted his/her previous typed search word
      return Center();
    }
    if (_userType.length == 1) {
      // user type one search word
      _searchByLastName = Firestore.instance
          .collectionGroup('professors')
          .where('lastName', isEqualTo: _userType)
          .snapshots();
      return Flexible(
              child: StreamBuilder<QuerySnapshot>(
            stream: _searchByLastName,
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return LinearProgressIndicator();
                default:
                  return (snapshot.data.documents.length != 0)
                      ? _buildSuggestionList(context, snapshot.data.documents)
                      : ListTile(title: Text('No result...'));
              }
            }),
      );
    }

    // user type more than one words
    print('previous search word: $_previousSearchWord');
    return Flexible(
          child: StreamBuilder<QuerySnapshot>(
          // stream: _searchByLastName,
          stream: Firestore.instance
              .collectionGroup('professors')
              .where('lastName', isEqualTo: _previousSearchWord)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) print(snapshot.data.documents.length);
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return LinearProgressIndicator();
              default:
                List<DocumentSnapshot> filtered = [];
                if (snapshot.data.documents.length != 0) {
                  snapshot.data.documents.forEach((doc) {
                    if (doc.data['fullName'].toString().contains(_userType))
                      filtered.add(doc);
                  });
                }
                print('filtered: ${filtered.length}');
                return (filtered.length != 0)
                    ? _buildSuggestionList(context, filtered)
                    : _buildSuggestionList(context, snapshot.data.documents);
            }
          }),
    );
  }

  _showSearchSuggestions() {
    if (_userType != '') {
      _previousSearchWord = _userType[0];
    }
    _userType = _searchBarTextController.text;
    setState(() {
      build(context);
    });
  }

  @override
  void initState() {
    _searchBarTextController.addListener(_showSearchSuggestions);
    super.initState();
  }

  @override
  void dispose() {
    _searchBarTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _searchBar(context),
            // Divider(thickness: 1.0,),
            // _searchResult(context),
            _searchResultInDatabase(context),
          ],
        ),
      ),
    );
  }
}
