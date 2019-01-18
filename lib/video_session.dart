class VideoSession {
  int id;
  String videoName;
  int videoLength;
  String systemTime;
  int currentPosition;
  bool isPlaying;

  VideoSession(
      {this.id,
      this.videoName,
      this.videoLength,
      this.systemTime,
      this.currentPosition,
      this.isPlaying});

  VideoSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoName = json['video_name'];
    videoLength = json['video_length'];
    systemTime = json['time_stamp'];
    currentPosition = json['current_position'];
    isPlaying = json['is_playing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video_name'] = this.videoName;
    data['video_length'] = this.videoLength;
    data['time_stamp'] = this.systemTime;
    data['current_position'] = this.currentPosition;
    data['is_playing'] = this.isPlaying;
    return data;
  }
}
