import 'package:my_music/model/Movie.dart';

class Results {
  var mPage, mTotalResult, mTotalPage;
  List<Movie> mResults = new List();

  Results({this.mPage, this.mTotalResult, this.mTotalPage, this.mResults});

  factory Results.parseJson(Map<String, dynamic> json) {
    return Results(
      mPage: json['page'],
      mTotalResult: json['total_result'],
      mTotalPage: json['total_page'],
      mResults: json['results'].cast<Movie>()
    );
  }
}