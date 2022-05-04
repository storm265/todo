abstract class Repository<T> {
  Future<void> save(T model);
  void delete(int index);
  void getDatabase();
}
