class PropertyFilterM {
  int? countryId;
  String? country;
  int? stateId;
  String? state;
  String? city;
  int? cityId;

  PropertyFilterM({
    this.countryId,
    this.country,
    this.stateId,
    this.state,
    this.city,
    this.cityId,
  });

  PropertyFilterM.fromJson(Map<String, dynamic> json) {
    countryId = json['type_id'];
    country = json['country'];
    stateId = json['stateId'];
    state = json['state'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    cityId = json['cityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type_id'] = countryId;
    data['country'] = country;
    data['stateId'] = stateId;
    data['state'] = state;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['cityId'] = cityId;

    return data;
  }
}
