import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:islet/logInDialog.dart';

import 'model/review.dart';

class ReviewPage extends StatefulWidget {
  final String professorName;

  ReviewPage({this.professorName});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  static String _prof = '';
  bool isCommentPressed;
  @override
  void initState() {
    super.initState();
    isCommentPressed = false;
  }

  _navigateToLogInOrSignUpPage() {
    Navigator.pushNamed(context, '/logInOrSignUpPage');
  }

  _dismissLogInDialog() {
    Navigator.pop(context);
  }

  Widget _logInDialog(BuildContext context) {
    return AlertDialog(
      title: Text('請先登入'),
      content: Text('登入後才能評論喔'),
      actions: <Widget>[
        FlatButton(
            key: Key('登入'),
            onPressed: _navigateToLogInOrSignUpPage(),
            child: Text('登入')),
        FlatButton(
            key: Key('稍後再說'),
            onPressed: _dismissLogInDialog(),
            child: Text('稍後再說')),
      ],
    );
  }

  Future<void> onPr() async {
    await showDialog(context: context, builder: _logInDialog);
  }

  onCommentButtonPress() {
    showDialog(context: context, builder: _logInDialog);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _prof = widget.professorName;
    if (isCommentPressed) onPr();
    return Scaffold(
        appBar: AppBar(),
        body: _buildBody(),
        floatingActionButton: Container(
          child: FloatingActionButton.extended(
            label: Text('評論'),
            icon: Icon(Icons.add),
            backgroundColor: Colors.pinkAccent,
            // pressed FAB: error
            onPressed: onCommentButtonPress,
          ),
        ));
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('schools')
          .doc('national central univ')
          .collection('professors')
          .doc(_prof)
          .collection('reviews')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        // if (!snapshot.hasData) return LinearProgressIndicator();
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return LinearProgressIndicator();
          default:
            return _buildListView(context, snapshot.data.docs);
        }
      },
    );
  }
}

// _buildCommentButton(BuildContext context) {
//   _navigateToLogInOrSignUpPage() {
//     Navigator.pushNamed(context, '/logInOrSignUpPage');
//   }

//   _dismissLogInDialog() {
//     Navigator.pop(context);
//   }

//   Widget _logInDialog(BuildContext context) {
//     return AlertDialog(
//       title: Text('請先登入'),
//       content: Text('登入後才能評論喔'),
//       actions: <Widget>[
//         FlatButton(
//             key: Key('登入'),
//             onPressed: _navigateToLogInOrSignUpPage(),
//             child: Text('登入')),
//         FlatButton(
//             key: Key('稍後再說'),
//             onPressed: _dismissLogInDialog(),
//             child: Text('稍後再說')),
//       ],
//     );
//   }

//   return Container(
//       child: FlatButton(
//     child: TextField(
//       decoration: InputDecoration(hintText: '留下評論'),
//     ),
//     onPressed: () {
//       print('onPressss');
//       showDialog(context: context, builder: _logInDialog);
//     },
//   ));
// }

Widget _buildListView(BuildContext context, List<DocumentSnapshot> snapshots) {
  return Center(
    child: ListView.separated(
      itemCount: snapshots.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == snapshots.length) {
          // return _buildCommentButton(context);
        } else {
          return _buildMyListItem(context, snapshots[index]);
        }
      },
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
    style: TextStyle(fontWeight: FontWeight.w400),
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
    onPressed: () =>
        review.reference.updateData({'thumbsUp': FieldValue.increment(1)}),
  ));

  Widget _iconButtonThumbDown = ButtonTheme(
      child: IconButton(
    color: Colors.black,
    icon: Icon(Icons.thumb_down),
    splashColor: Colors.red,
    onPressed: () =>
        review.reference.updateData({'thumbsDown': FieldValue.increment(1)}),
  ));

  Widget _buildBotton = Row(
    children: <Widget>[
      _iconButtonThumbUp,
      Text(
        review.thumbsUp.toString(),
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: (review.thumbsUp > 5) ? Colors.green : Colors.black),
      ),
      _iconButtonThumbDown,
      Text(review.thumbsDown.toString(),
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: (review.thumbsDown > 5) ? Colors.red : Colors.black)),
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
    margin: EdgeInsets.all(4.0),
    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
    child: Card(
      child: _buildReviewCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 1.0,
    ),
  );
}

// () {
// Add a new piece of review on your professor
// var ref = Firestore.instance
//     .collection('schools')
//     .document('national central univ')
//     .collection('professors')
//     .document(_prof)
//     .collection('reviews');

// var newdata = {
//   'courseName': '資料科學導論',
//   'reviewText':
//       '中央資工找教授 陳弘軒教授人很nice很好溝通,尊重學生想做的研究方向,建議可以跟他聊聊看實驗室風氣的話建議直接去跟學長姐聊聊看最清楚',
//   'courseDifficulty': 3.0,
//   'professorRating': 5.0,
//   'gradeReceived': 98.0,
//   'forCredit': true,
//   'wouldTakeAgain': true,
//   'attendance': true,
//   'thumbsUp':0,
//   'thumbsDown':0,
// };
// ref.add(newdata);
// print('add new comment on professor:$_prof');

// final FirebaseAuth _auth = FirebaseAuth.instance;
// var cur = _auth.currentUser();
// if (cur == null) {
//   // check if user log in or not
//   // if user has Logged in
//   // user can comment
// }

// else {
// if not,
// show LogIn AlertDiglog
// showDialog<void>(
//     context: context,
//     builder: _logInDialog,
//     barrierDismissible: false);
// }
// },
