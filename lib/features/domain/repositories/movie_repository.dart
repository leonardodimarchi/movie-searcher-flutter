import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_searcher_flutter/core/errors/failures.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_detail_entity.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getMovies(int page);
  Future<Either<Failure, MovieDetailEntity>> getMovie(int id);
  Future<Either<Failure, List<MovieEntity>>> searchMovies(SearchMovieParams params);
}

class SearchMovieParams extends Equatable {
  final String searchText;
  final int page;

  const SearchMovieParams({
    this.searchText = '',
    this.page = 0,
  });

  @override
  List<Object> get props => [searchText, page];
}
