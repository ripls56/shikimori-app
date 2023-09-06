import 'package:equatable/equatable.dart';
import 'package:shikimoriapp/feature/comments/domain/models/comment_user.dart';

///Comment entity
class Comment extends Equatable {
  ///Constructor
  const Comment(
    this.id,
    this.userId,
    this.commentableId,
    this.commentableType,
    this.body,
    this.htmlBody,
    this.createdAt,
    this.updatedAt,
    this.isOfftopic,
    this.isSummary,
    this.canBeEdited,
    this.user,
  );

  final int? id;
  final int? userId;
  final int? commentableId;
  final String? commentableType;
  final String? body;
  final String? htmlBody;
  final String? createdAt;
  final String? updatedAt;
  final bool? isOfftopic;
  final bool? isSummary;
  final bool? canBeEdited;
  final CommentUser? user;

  @override
  List<Object?> get props => [
        id,
        userId,
        commentableId,
        commentableType,
        body,
        htmlBody,
        createdAt,
        updatedAt,
        isOfftopic,
        isSummary,
        canBeEdited,
        user,
      ];
}
