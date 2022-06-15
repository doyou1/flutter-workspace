class WeatherVO {
  int id;
  String description;
  double windSpeed;
  String country;
  String stateName;
  double temp;
  int condition;

  WeatherVO(this.id, this.description, this.windSpeed, this.country, this.stateName, this.temp, this.condition);

  @override
  String toString() {
    return "id: $id, description: $description, windSpeed: $windSpeed, country: $country, stateName: $stateName temp: $temp";
  }
}