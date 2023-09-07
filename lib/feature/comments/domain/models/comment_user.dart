import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/image/domain/model/image.dart';

///Comment user entity
class CommentUser extends Equatable {
  ///Constructor
  const CommentUser(
    this.id,
    this.nickname,
    this.avatar,
    this.image,
    this.lastOnlineAt,
    this.url,
  );

  final int? id;
  final String? nickname;
  final String? avatar;
  final Image? image;
  final String? lastOnlineAt;
  final String? url;

  @override
  List<Object?> get props => [id, nickname, avatar, image, lastOnlineAt, url];
}
