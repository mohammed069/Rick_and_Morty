class Character {
  late int charId;
  late String charName;
  late String charStatus;
  late String charSpecies;
  late String charType;
  late String charGender;
  late Map<String, dynamic> charOrigin;
  late Map<String, dynamic> charLocation;
  late String charImage;
  late List<String> charEpisode;
  late String charUrl;
  late String charCreated;
  late String charLocationName;
  late String charLocationUrl;
  late String charOriginName;
  late String charOriginUrl;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['id'];
    charName = json['name'];
    charStatus = json['status'];
    charSpecies = json['species'];
    charType = json['type'];
    charGender = json['gender'];
    charOrigin = Map<String, dynamic>.from(json['origin']);
    charLocation = Map<String, dynamic>.from(json['location']);
    charImage = json['image'];
    charEpisode = List<String>.from(json['episode']);
    charUrl = json['url'];
    charCreated = json['created'];
    charLocationName = json['location']['name'];
    charLocationUrl = json['location']['url'];
    charOriginName = json['origin']['name'];
    charOriginUrl = json['origin']['url'];
  }
}
