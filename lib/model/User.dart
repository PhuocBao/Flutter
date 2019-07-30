class User {
  String avatarUrl;
  String firstName;
  String fullName;
  int id;
  String kind;
  String lastModified;
  String lastName;
  String permalink;
  String permalinkUrl;
  String uri;
  String urn;
  String username;
  bool verified;
  String city;
  String countryCode;

  User(
      {this.avatarUrl,
      this.firstName,
      this.fullName,
      this.id,
      this.kind,
      this.lastModified,
      this.lastName,
      this.permalink,
      this.permalinkUrl,
      this.uri,
      this.urn,
      this.username,
      this.verified,
      this.city,
      this.countryCode});

  User.fromJson(Map<String, dynamic> json) {
    avatarUrl = json['avatar_url'];
    firstName = json['first_name'];
    fullName = json['full_name'];
    id = json['id'];
    kind = json['kind'];
    lastModified = json['last_modified'];
    lastName = json['last_name'];
    permalink = json['permalink'];
    permalinkUrl = json['permalink_url'];
    uri = json['uri'];
    urn = json['urn'];
    username = json['username'];
    verified = json['verified'];
    city = json['city'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar_url'] = this.avatarUrl;
    data['first_name'] = this.firstName;
    data['full_name'] = this.fullName;
    data['id'] = this.id;
    data['kind'] = this.kind;
    data['last_modified'] = this.lastModified;
    data['last_name'] = this.lastName;
    data['permalink'] = this.permalink;
    data['permalink_url'] = this.permalinkUrl;
    data['uri'] = this.uri;
    data['urn'] = this.urn;
    data['username'] = this.username;
    data['verified'] = this.verified;
    data['city'] = this.city;
    data['country_code'] = this.countryCode;
    return data;
  }
}
