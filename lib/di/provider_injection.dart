import 'package:get/get.dart';

import './locator.dart';
import '../providers/providers.dart';

void initProviders() {
  //notes Provider
  ProductsProvider productsProvider = Get.put(ProductsProvider());
  locator.registerLazySingleton(() => productsProvider);
}
