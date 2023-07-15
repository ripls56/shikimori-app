import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/image/domain/model/image.dart';

///Seyu model
class CharacterSeyu extends Equatable {
  ///Constructor
  const CharacterSeyu({
    required this.id,
    required this.name,
    required this.russian,
    required this.image,
    required this.url,
  });

  ///Seyu id
  final int id;

  ///Seyu name
  final String name;

  ///Seyu russian name
  final String russian;

  ///Seyu image
  final Image image;

  ///Seyu url
  final String url;

  @override
  List<Object?> get props => [];
}
