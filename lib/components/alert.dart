import 'package:awesome_dialog/awesome_dialog.dart';

void showAlert(context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.rightSlide,
    title: 'ແຈ້ງເຕືອນ',
    desc: 'ທ່ານໝັ້ນໃຈບໍ່ວ່າຈະຊຳລະເງິນ!',
    btnCancelOnPress: () {},
    btnOkOnPress: () {},
  )..show();
}
