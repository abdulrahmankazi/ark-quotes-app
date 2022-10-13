import 'package:get/get.dart';

class EditQuoteController extends GetxController {
  var fullQuotesList = [];
  var text = 'a';

  @override
  void onInit() {
    super.onInit();

    fullQuotesList = Get.arguments;
    print(fullQuotesList.toString());
  }
}
