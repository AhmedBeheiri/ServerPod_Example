import 'package:get_it/get_it.dart';
import 'package:testserverpod_flutter/features/Articles/di.dart';

import '../../features/home/di.dart';

final di = GetIt.instance;

void initDependencyInjection() {
  HomeDI(di);
  ArticlesDI(di);
}
