class Location {
  final String street;
  final String city;
  final String state;
  final String zip;

  Location(this.street, this.city, this.state, this.zip);

  Location.fromJson(Map<String, dynamic> json)
      : street = json["street"],
        city = json["city"],
        state = json["state"],
        zip = json["zip"];
}
