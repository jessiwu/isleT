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
  final _searchController = TextEditingController();
  String _searchName = '';

  Widget _searchBar(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only( bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
        height: 60,
        width: width,
        decoration: BoxDecoration(color: kisleTPrimaryGreenLight),
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
            controller: _searchController,
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

  Widget _buildSuggestionList(
      BuildContext context, List<DocumentSnapshot> snapshots) {
    print(snapshots.length);
    return Container(
      // alignment: Alignment.topLeft,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: snapshots.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildSuggestionItem(context, snapshots[index]),
      ),
    );
  }

  Widget _searchResult(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Flexible(
        child: (_searchName != '')
            ? StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collectionGroup('professors')
                    .where('lastName', isEqualTo: _searchName)
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

  _showSuggestions() {
    _searchName = _searchController.text;
    setState(() {
      build(context);
    });
  }

  @override
  void initState() {
    _searchController.addListener(_showSuggestions);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar( elevation: 0.0, ),
      body: Container(
        child: Column(
          children: <Widget>[
            _searchBar(context),
            Divider(
              thickness: 1.0,
            ),
            _searchResult(context),
          ],
        ),
      ),
    );
  }
}
