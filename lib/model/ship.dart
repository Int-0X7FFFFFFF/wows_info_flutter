// ignore_for_file: non_constant_identifier_names

class Ship {
  late int id;
  late int tier;
  late String type;
  late bool is_special;
  late bool is_premium;
  late String nation;
  late String name;
  late String imgLink;
  String getRomanTier() {
    var romanList = [
      "0",
      "I",
      "II",
      "III",
      "IV",
      "V",
      "VI",
      "VII",
      "VIII",
      "IX",
      "X",
      "★"
    ];
    try {
      return romanList[tier];
    } catch (e) {
      return "Unknow";
    }
  }

  int getShipID() {
    return id;
  }

  String getType() {
    return type;
  }

  String getName() {
    return name;
  }

  String getNation() {
    return nation;
  }

  bool getSpecial() {
    return is_special;
  }

  bool getPremium() {
    return is_premium;
  }

  String getImgLing() {
    return imgLink;
  }

  Ship(this.id, this.tier, this.type, this.name, this.nation, this.imgLink,
      this.is_special, this.is_premium);
}
