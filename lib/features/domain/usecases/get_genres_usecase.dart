
import 'package:dartz/dartz.dart';
import 'package:movie_searcher_flutter/features/domain/entities/genre_entity.dart';
import 'package:movie_searcher_flutter/features/domain/repositories/genre_repository.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecase/usecase.dart';

class GetGenresUsecase extends UseCase<List<GenreEntity>, NoParams> {
  final GenreRepository repository;

  GetGenresUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<GenreEntity>>> call(NoParams params) async {
    return await repository.getGenres();
  }
}