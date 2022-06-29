import 'package:movie_searcher_flutter/features/data/models/common/base_pagination.dart';
import 'package:movie_searcher_flutter/features/domain/entities/movie_entity.dart';

class MoviePagination extends BasePagination<MovieEntity> {
    MoviePagination({ int page = 1, List<MovieEntity> list = const [] }) : super(page: page, list: list);
}