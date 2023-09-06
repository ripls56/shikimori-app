import 'package:dartz/dartz.dart';
import 'package:shikimoriapp/core/error/failure.dart';
import 'package:shikimoriapp/feature/comments/domain/models/comment.dart';

///Comment repository
abstract class CommentRepository {
  ///Get anime list with page
  Future<Either<Failure, List<Comment>>> getComments(
    int page, {
    String? order = 'ranked',
    int? limit = 50,
    int? score,
    String? season,
    String? status,
  });

  ///Search anime by name
  Future<Either<Failure, Comment>> getCommentById(int id);
}
