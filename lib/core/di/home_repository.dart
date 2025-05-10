abstract class HomeRepository {
  Future<void> getHomeData();
}

class HomeDefaultRepository extends HomeRepository {
  @override
  Future<void> getHomeData() async {}
}
