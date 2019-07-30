import 'Transcodings.dart';

class PublisherMetadata {
  int id;
  String urn;
  String artist;
  bool containsMusic;
  String publisher;
  String isrc;
  String writerComposer;
  String releaseTitle;

  PublisherMetadata(
      {this.id,
      this.urn,
      this.artist,
      this.containsMusic,
      this.publisher,
      this.isrc,
      this.writerComposer,
      this.releaseTitle});

  PublisherMetadata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urn = json['urn'];
    artist = json['artist'];
    containsMusic = json['contains_music'];
    publisher = json['publisher'];
    isrc = json['isrc'];
    writerComposer = json['writer_composer'];
    releaseTitle = json['release_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['urn'] = this.urn;
    data['artist'] = this.artist;
    data['contains_music'] = this.containsMusic;
    data['publisher'] = this.publisher;
    data['isrc'] = this.isrc;
    data['writer_composer'] = this.writerComposer;
    data['release_title'] = this.releaseTitle;
    return data;
  }
}

class Media {
  List<Transcodings> transcodings;

  Media({this.transcodings});

  Media.fromJson(Map<String, dynamic> json) {
    if (json['transcodings'] != null) {
      transcodings = new List<Transcodings>();
      json['transcodings'].forEach((v) {
        transcodings.add(new Transcodings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transcodings != null) {
      data['transcodings'] = this.transcodings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
