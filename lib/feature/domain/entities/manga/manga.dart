import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/domain/entities/manga/image.dart';

class Manga extends Equatable {
  const Manga({
    required this.id,
    required this.name,
    required this.russian,
    required this.image,
    required this.url,
    required this.kind,
    required this.score,
    required this.status,
    required this.volumes,
    required this.chapters,
    required this.airedOn,
    required this.releasedOn,
  });

  final int? id;
  final String? name;
  final String? russian;
  final Image? image;
  final String? url;
  final String? kind;
  final String? score;
  final String? status;
  final int? volumes;
  final int? chapters;
  final DateTime? airedOn;
  final dynamic releasedOn;

  @override
  List<Object?> get props => [];
}
