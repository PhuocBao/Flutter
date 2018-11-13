class Movie {
  final String mImg, mName, mVideo, mPopularity, mLanguage, mBackdrop, mAdult, mOverview, mRelease;
  final int mID, voteCount;
  final double voteAvrg;


  Movie({this.mID, this.mImg, this.mName, this.mVideo, this.mPopularity,
      this.mLanguage, this.mBackdrop, this.mAdult, this.mOverview,
      this.mRelease, this.voteCount, this.voteAvrg});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      mID: json['id'],
      mImg: json['poster_path'],
      mName: json['original_title'],
    );
  }
}
