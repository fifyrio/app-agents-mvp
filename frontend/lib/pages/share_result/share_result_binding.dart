import 'package:get/get.dart';
import 'share_result_controller.dart';

/// Share Result Binding
///
/// Manages dependency injection for the Share Result page.
/// Creates and registers the ShareResultController when the page is accessed.
class ShareResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareResultController>(
      () => ShareResultController(),
    );
  }
}
