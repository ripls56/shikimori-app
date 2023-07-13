part of 'anime_details.dart';

class StudioModel extends Studio {
  const StudioModel({
    required id,
    required name,
    required filteredName,
    required real,
    required image,
  }) : super(
            id: id,
            name: name,
            filteredName: filteredName,
            real: real,
            image: image,);

  factory StudioModel.fromJson(Map<String, dynamic> json) => StudioModel(
        id: json['id'],
        name: json['name'],
        filteredName: json['filtered_name'],
        real: json['real'],
        image: json['image'],
      );

  @override
  List<Object?> get props => throw UnimplementedError();
}
