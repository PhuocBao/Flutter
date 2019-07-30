import 'PublisherMetadata.dart';
import 'User.dart';

class Tracks {
  String artworkUrl;
  bool commentable;
  int commentCount;
  String createdAt;
  String description;
  bool downloadable;
  int downloadCount;
  String downloadUrl;
  int duration;
  int fullDuration;
  String embeddableBy;
  String genre;
  bool hasDownloadsLeft;
  int id;
  String kind;
  String labelName;
  String lastModified;
  String license;
  int likesCount;
  String permalink;
  String permalinkUrl;
  int playbackCount;
  bool public;
  PublisherMetadata publisherMetadata;
  String purchaseTitle;
  String purchaseUrl;
  String releaseDate;
  int repostsCount;
  String secretToken;
  String sharing;
  String state;
  bool streamable;
  String tagList;
  String title;
  String uri;
  String urn;
  int userId;
  String visuals;
  String waveformUrl;
  String displayDate;
  Media media;
  String monetizationModel;
  String policy;
  User user;

  Tracks(
      {this.artworkUrl,
      this.commentable,
      this.commentCount,
      this.createdAt,
      this.description,
      this.downloadable,
      this.downloadCount,
      this.downloadUrl,
      this.duration,
      this.fullDuration,
      this.embeddableBy,
      this.genre,
      this.hasDownloadsLeft,
      this.id,
      this.kind,
      this.labelName,
      this.lastModified,
      this.license,
      this.likesCount,
      this.permalink,
      this.permalinkUrl,
      this.playbackCount,
      this.public,
      this.publisherMetadata,
      this.purchaseTitle,
      this.purchaseUrl,
      this.releaseDate,
      this.repostsCount,
      this.secretToken,
      this.sharing,
      this.state,
      this.streamable,
      this.tagList,
      this.title,
      this.uri,
      this.urn,
      this.userId,
      this.visuals,
      this.waveformUrl,
      this.displayDate,
      this.media,
      this.monetizationModel,
      this.policy,
      this.user});

  Tracks.fromJson(Map<String, dynamic> json) {
    artworkUrl = json['artwork_url'];
    commentable = json['commentable'];
    commentCount = json['comment_count'];
    createdAt = json['created_at'];
    description = json['description'];
    downloadable = json['downloadable'];
    downloadCount = json['download_count'];
    downloadUrl = json['download_url'];
    duration = json['duration'];
    fullDuration = json['full_duration'];
    embeddableBy = json['embeddable_by'];
    genre = json['genre'];
    hasDownloadsLeft = json['has_downloads_left'];
    id = json['id'];
    kind = json['kind'];
    labelName = json['label_name'];
    lastModified = json['last_modified'];
    license = json['license'];
    likesCount = json['likes_count'];
    permalink = json['permalink'];
    permalinkUrl = json['permalink_url'];
    playbackCount = json['playback_count'];
    public = json['public'];
    publisherMetadata = json['publisher_metadata'] != null
        ? new PublisherMetadata.fromJson(json['publisher_metadata'])
        : null;
    purchaseTitle = json['purchase_title'];
    purchaseUrl = json['purchase_url'];
    releaseDate = json['release_date'];
    repostsCount = json['reposts_count'];
    secretToken = json['secret_token'];
    sharing = json['sharing'];
    state = json['state'];
    streamable = json['streamable'];
    tagList = json['tag_list'];
    title = json['title'];
    uri = json['uri'];
    urn = json['urn'];
    userId = json['user_id'];
    visuals = json['visuals'];
    waveformUrl = json['waveform_url'];
    displayDate = json['display_date'];
    media = json['media'] != null ? new Media.fromJson(json['media']) : null;
    monetizationModel = json['monetization_model'];
    policy = json['policy'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artwork_url'] = this.artworkUrl;
    data['commentable'] = this.commentable;
    data['comment_count'] = this.commentCount;
    data['created_at'] = this.createdAt;
    data['description'] = this.description;
    data['downloadable'] = this.downloadable;
    data['download_count'] = this.downloadCount;
    data['download_url'] = this.downloadUrl;
    data['duration'] = this.duration;
    data['full_duration'] = this.fullDuration;
    data['embeddable_by'] = this.embeddableBy;
    data['genre'] = this.genre;
    data['has_downloads_left'] = this.hasDownloadsLeft;
    data['id'] = this.id;
    data['kind'] = this.kind;
    data['label_name'] = this.labelName;
    data['last_modified'] = this.lastModified;
    data['license'] = this.license;
    data['likes_count'] = this.likesCount;
    data['permalink'] = this.permalink;
    data['permalink_url'] = this.permalinkUrl;
    data['playback_count'] = this.playbackCount;
    data['public'] = this.public;
    if (this.publisherMetadata != null) {
      data['publisher_metadata'] = this.publisherMetadata.toJson();
    }
    data['purchase_title'] = this.purchaseTitle;
    data['purchase_url'] = this.purchaseUrl;
    data['release_date'] = this.releaseDate;
    data['reposts_count'] = this.repostsCount;
    data['secret_token'] = this.secretToken;
    data['sharing'] = this.sharing;
    data['state'] = this.state;
    data['streamable'] = this.streamable;
    data['tag_list'] = this.tagList;
    data['title'] = this.title;
    data['uri'] = this.uri;
    data['urn'] = this.urn;
    data['user_id'] = this.userId;
    data['visuals'] = this.visuals;
    data['waveform_url'] = this.waveformUrl;
    data['display_date'] = this.displayDate;
    if (this.media != null) {
      data['media'] = this.media.toJson();
    }
    data['monetization_model'] = this.monetizationModel;
    data['policy'] = this.policy;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
