import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/review.dart';


class KoLabHomePage extends StatefulWidget {
  final String professorName;

  KoLabHomePage({this.professorName});

  @override
  _KoLabHomePageState createState() => _KoLabHomePageState();
}

class _KoLabHomePageState extends State<KoLabHomePage> {
  static String _prof = '';
  @override
  Widget build(BuildContext context) {
    _prof = widget.professorName;
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context),
    );
  }

Widget _buildBody(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance
        .collection('schools')
        .document('national central univ')
        .collection('professors')
        .document( _prof )
        .collection('reviews')
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError) return Text('Error: ${snapshot.error}');
      // if (!snapshot.hasData) return LinearProgressIndicator();
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return LinearProgressIndicator();
        default:
          return _buildListView(context, snapshot.data.documents);
      }
    },
  );
}
}

Widget _buildListView(BuildContext context, List<DocumentSnapshot> snapshots) {
  return Center(
    child: ListView.separated(
      itemCount: snapshots.length,
      itemBuilder: (BuildContext context, int index) =>
          _buildMyListItem(context, snapshots[index]),
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 0.0,
      ),
    ),
  );
}

Widget _buildMyListItem(
    BuildContext context, DocumentSnapshot documentSnapshot) {
  final Review review = Review.fromSnapshot(documentSnapshot);

  Widget _buildQuality = Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(8.0),
        child: Text('評價'),
      ),
      Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.lightGreen,
        child: Text(review.professorRating.toString()),
      ),
    ],
  );

  Widget _buildDifficulty = Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(8.0),
        child: Text('難度'),
      ),
      Container(
        padding: EdgeInsets.all(8.0),
        color: Color(0xFFbcbcbc),
        child: Text(review.courseDifficulty.toString()),
      ),
    ],
  );

  Widget _buildRatingSection = Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildQuality,
          _buildDifficulty,
          SizedBox(),
        ],
      ));
  Widget _className = Container(
    margin: EdgeInsets.only(left: 4.0),
    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
    decoration: BoxDecoration(
      color: Color(0xFFfbc02d),
    ),
    child: Text(review.courseName),
  );

  Widget _dateWritten = Container(
    padding: EdgeInsets.all(4.0),
    decoration: BoxDecoration(),
    child: Text('Dec 15th, 2019'),
  );

  Widget _buildUpper = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      _className,
      _dateWritten,
    ],
  );

  Widget _userReviewOfProfessor = Text(
    review.reviewText,
    style: TextStyle(
        fontWeight: FontWeight.w400),
    softWrap: true,
    overflow: TextOverflow.clip,
  );

  Widget _buildMiddle = Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: _userReviewOfProfessor);

  Widget _iconButtonThumbUp = ButtonTheme(
      child: IconButton(
        color: Colors.black,
        icon: Icon(Icons.thumb_up),
        splashColor: Colors.green,
        onPressed: () => review.reference
            .updateData({'thumbsUp': FieldValue.increment(1)}),
      )
    );

  Widget _iconButtonThumbDown = ButtonTheme(
      child: IconButton(
        color: Colors.black,
        icon: Icon(Icons.thumb_down),
        splashColor: Colors.red,
        onPressed: () => review.reference
            .updateData({'thumbsDown': FieldValue.increment(1)}),
      )
    );

  Widget _buildBotton = Row(
    children: <Widget>[
      _iconButtonThumbUp,
      Text(review.thumbsUp.toString(), style: TextStyle(
        fontWeight: FontWeight.w500,
        color: (review.thumbsUp>5) ? Colors.green : Colors.black),),
      _iconButtonThumbDown,
      Text(review.thumbsDown.toString(),  style: TextStyle(
        fontWeight: FontWeight.w500,
        color: (review.thumbsDown>5) ? Colors.red : Colors.black)),
    ],
  );

  Widget _buildReviewDetailsSection = Flexible(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildUpper,
        _buildMiddle,
        _buildBotton,
      ],
    ),
  );

  Widget _buildReviewCard = Container(
    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
    decoration: BoxDecoration(
      color: Color(0xEEEEEEEE),
      // boxShadow: [BoxShadow()],
    ),
    child: Row(
      children: <Widget>[
        _buildRatingSection,
        _buildReviewDetailsSection,
      ],
    ),
  );

  return Container(
    height: 250,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: _buildReviewCard,
  );
}
