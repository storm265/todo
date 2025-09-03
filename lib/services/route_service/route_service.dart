import 'package:auto_route/auto_route.dart';
import 'package:todo/services/route_service/route_service.gr.dart';

@AutoRouterConfig()
class RouteService extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: InitialRoute.page, initial: true),
        AutoRoute(page: TaskListRoute.page),
        AutoRoute(page: CategoryRoute.page),
        AutoRoute(page: AddTaskRoute.page),
        AutoRoute(page: EditTaskRoute.page),
        AutoRoute(page: AddCategoryRoute.page),
        AutoRoute(page: ArchieveRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: PickGradientRoute.page),
      ];
}
