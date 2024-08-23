class PropertyModelM {
  int? typeId;
  int? purpose;
  String? url;
  String? card;
  String? country;
  String? state;
  String? city;
  String? location;
  int? area;
  String? title;
  int? areaUnit;
  int? price;
  int? bedroom;
  int? bathroom;
  int? condition;
  String? businessPhone;

  PropertyModelM(
      {this.typeId,
      this.purpose,
      this.url,
      this.card,
      this.country,
      this.state,
      this.city,
      this.location,
      this.area,
      this.title,
      this.areaUnit,
      this.price,
      this.bedroom,
      this.bathroom,
      this.condition,
      this.businessPhone});

  PropertyModelM.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    purpose = json['purpose'];
    url = json['url'];
    card = json['card'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    location = json['location'];
    area = json['area'];
    title = json['title'];
    areaUnit = json['area_unit'];
    price = json['price'];
    bedroom = json['bedroom'];
    bathroom = json['bathroom'];
    condition = json['condition'];
    businessPhone = json['business_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = typeId;
    data['purpose'] = purpose;
    data['url'] = url;
    data['card'] = card;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['location'] = location;
    data['area'] = area;
    data['title'] = title;
    data['area_unit'] = areaUnit;
    data['price'] = price;
    data['bedroom'] = bedroom;
    data['bathroom'] = bathroom;
    data['condition'] = condition;
    data['business_phone'] = businessPhone;
    return data;
  }
}
