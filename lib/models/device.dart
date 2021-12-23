class Device {
  String? wilaya;
  String? commune;
  String? idUser;
  String? model;
  String? brand;
  String? color;
  String? state;

  Device({
    this.wilaya = '',
    this.commune = '',
    this.idUser = '',
    this.model = '',
    this.brand = '',
    this.color = '',
    this.state = '',
  });

  Device.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'].toString();
    wilaya = json['wilaya'].toString();
    commune = json['commune'].toString();
    model = json['model'].toString();
    brand = json['brand'].toString();
    color = json['color'].toString();
    state = json['state'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_user'] = idUser;
    data['wilaya'] = wilaya;
    data['commune'] = commune;
    data['model'] = model;
    data['brand'] = brand;
    data['color'] = color;
    data['state'] = state;
    return data;
  }


}
