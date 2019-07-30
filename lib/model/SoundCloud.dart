import 'Tracks.dart';
import 'User.dart';

class SoundCloud {
  String artworkUrl;
  String createdAt;
  String description;
  int duration;
  String embeddableBy;
  String genre;
  int id;
  String kind;
  String labelName;
  String lastModified;
  String license;
  int likesCount;
  bool managedByFeeds;
  String permalink;
  String permalinkUrl;
  bool public;
  String purchaseTitle;
  String purchaseUrl;
  String releaseDate;
  int repostsCount;
  String secretToken;
  String sharing;
  String tagList;
  String title;
  String uri;
  int userId;
  String setType;
  bool isAlbum;
  String publishedAt;
  String displayDate;
  User user;
  List<Tracks> tracks;
  int trackCount;

  SoundCloud(
      {this.artworkUrl,
      this.createdAt,
      this.description,
      this.duration,
      this.embeddableBy,
      this.genre,
      this.id,
      this.kind,
      this.labelName,
      this.lastModified,
      this.license,
      this.likesCount,
      this.managedByFeeds,
      this.permalink,
      this.permalinkUrl,
      this.public,
      this.purchaseTitle,
      this.purchaseUrl,
      this.releaseDate,
      this.repostsCount,
      this.secretToken,
      this.sharing,
      this.tagList,
      this.title,
      this.uri,
      this.userId,
      this.setType,
      this.isAlbum,
      this.publishedAt,
      this.displayDate,
      this.user,
      this.tracks,
      this.trackCount});

  SoundCloud.fromJson(Map<String, dynamic> json) {
    artworkUrl = json['artwork_url'];
    createdAt = json['created_at'];
    description = json['description'];
    duration = json['duration'];
    embeddableBy = json['embeddable_by'];
    genre = json['genre'];
    id = json['id'];
    kind = json['kind'];
    labelName = json['label_name'];
    lastModified = json['last_modified'];
    license = json['license'];
    likesCount = json['likes_count'];
    managedByFeeds = json['managed_by_feeds'];
    permalink = json['permalink'];
    permalinkUrl = json['permalink_url'];
    public = json['public'];
    purchaseTitle = json['purchase_title'];
    purchaseUrl = json['purchase_url'];
    releaseDate = json['release_date'];
    repostsCount = json['reposts_count'];
    secretToken = json['secret_token'];
    sharing = json['sharing'];
    tagList = json['tag_list'];
    title = json['title'];
    uri = json['uri'];
    userId = json['user_id'];
    setType = json['set_type'];
    isAlbum = json['is_album'];
    publishedAt = json['published_at'];
    displayDate = json['display_date'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['tracks'] != null) {
      tracks = new List<Tracks>();
      json['tracks'].forEach((v) {
        tracks.add(new Tracks.fromJson(v));
      });
    }
    trackCount = json['track_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artwork_url'] = this.artworkUrl;
    data['created_at'] = this.createdAt;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['embeddable_by'] = this.embeddableBy;
    data['genre'] = this.genre;
    data['id'] = this.id;
    data['kind'] = this.kind;
    data['label_name'] = this.labelName;
    data['last_modified'] = this.lastModified;
    data['license'] = this.license;
    data['likes_count'] = this.likesCount;
    data['managed_by_feeds'] = this.managedByFeeds;
    data['permalink'] = this.permalink;
    data['permalink_url'] = this.permalinkUrl;
    data['public'] = this.public;
    data['purchase_title'] = this.purchaseTitle;
    data['purchase_url'] = this.purchaseUrl;
    data['release_date'] = this.releaseDate;
    data['reposts_count'] = this.repostsCount;
    data['secret_token'] = this.secretToken;
    data['sharing'] = this.sharing;
    data['tag_list'] = this.tagList;
    data['title'] = this.title;
    data['uri'] = this.uri;
    data['user_id'] = this.userId;
    data['set_type'] = this.setType;
    data['is_album'] = this.isAlbum;
    data['published_at'] = this.publishedAt;
    data['display_date'] = this.displayDate;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.tracks != null) {
      data['tracks'] = this.tracks.map((v) => v.toJson()).toList();
    }
    data['track_count'] = this.trackCount;
    return data;
  }
}
