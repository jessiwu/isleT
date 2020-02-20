import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  String _searchName = '';
  _showSuggestions() {
    if (_searchController.text != '') {
      _searchName = _searchController.text;
    }
    setState(() {
      build(context);
    });
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
    return Center(
      child: ListView.builder(
        itemCount: snapshots.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildSuggestionItem(context, snapshots[index]),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: (_searchName == '')
              ? Center(
                  child: ClipRect(child: Icon(Icons.search)),
                )
              : StreamBuilder<QuerySnapshot>(
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
                  }),
        ),
        // Divider(),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, semanticLabel: 'menu'),
          onPressed: () {
            print('Menu button');
          },
        ),
        title: Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          height: 40.0,
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: '搜尋',
                border: OutlineInputBorder()
                // border: InputBorder.none,
                // contentPadding: EdgeInsets.all(8.0),
                ),
            textAlignVertical: TextAlignVertical.bottom,
            controller: _searchController,
          ),
        ));
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
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}
