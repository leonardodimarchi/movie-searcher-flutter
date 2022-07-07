import 'package:dartz/dartz.dart';
import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';

import '../../../core/errors/failures.dart';

abstract class GenreRepository {
  Future<Either<Failure, List<GenreEntity>>> getGenres();
}