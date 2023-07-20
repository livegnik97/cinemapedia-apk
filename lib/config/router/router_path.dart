

class RouterPath {
  static const String HOME_PAGE_PATH = '/home/:page';
  static const String HOME_PAGE = '/home/0';
  static const String CATEGORY_PAGE = '/home/1';
  static const String FAVORITE_PAGE = '/home/2';

  static const String MOVIE_PAGE_PATH = 'movie/:id';
  static String MOVIE_PAGE(id) => '/home/0/movie/${id.toString()}';
}