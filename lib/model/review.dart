import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String courseName;
  final String reviewText;
  final num courseDifficulty;
  final num professorRating;
  final num gradeReceived;
  final bool forCredit;
  final bool wouldTakeAgain;
  final bool attendance;
  final num thumbsUp;
  final num thumbsDown;

  final DocumentReference reference;
  final String docID;

  Review.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['courseName']!= null),
        assert(map['reviewText']!= null),
        assert(map['courseDifficulty']!= null),
        assert(map['professorRating']!= null),
        assert(map['gradeReceived']!= null),
        assert(map['forCredit']!= null),
        assert(map['wouldTakeAgain']!= null),
        assert(map['attendance']!= null),
        assert(map['thumbsUp']!= null),
        assert(map['thumbsDown']!= null),
        this.courseName = map['courseName'],
        this.reviewText = map['reviewText'],
        this.courseDifficulty = map['courseDifficulty'],
        this.professorRating = map['professorRating'],
        this.gradeReceived = map['gradeReceived'],
        this.forCredit = map['forCredit'],
        this.wouldTakeAgain = map['wouldTakeAgain'],
        this.attendance = map['attendance'],
        this.thumbsUp = map['thumbsUp'],
        this.thumbsDown = map['thumbsDown'],
        this.docID = reference.documentID;
  
  Review.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Review<$docID:$courseName>";

}