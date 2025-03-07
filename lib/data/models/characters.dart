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

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['id'];
    charName = json['name'];
    charStatus = json['status'];
    charSpecies = json['species'];
    charType = json['type'];
    charGender = json['gender'];
    charOrigin = json['origin'];
    charLocation = json['location'];
    charImage = json['image'];
    charEpisode = json['episode'];
    charUrl = json['url'];
    charCreated = json['created'];
  }
}
