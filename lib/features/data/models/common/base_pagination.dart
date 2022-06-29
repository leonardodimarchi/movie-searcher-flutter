 class BasePagination<T> {
  int page;
  List<T> list;

  BasePagination({ this.page = 1, this.list = const [] });
}