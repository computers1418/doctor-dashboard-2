import 'package:doctor_dashboard/widgets/confirm_sheet.dart';
import 'package:doctor_dashboard/widgets/phone_confirm_sheet.dart';
import 'package:doctor_dashboard/widgets/success_sheet.dart';
import 'package:flutter/material.dart';

class AppViewModel {
  late TextEditingController numberController;
  late TextEditingController emailController;

  late TextEditingController pNameController;
  late TextEditingController dNameController;
  late TextEditingController dateTimeController;
  late TextEditingController locationController;

  AppViewModel() {
    numberController = TextEditingController();
    emailController = TextEditingController();

    pNameController = TextEditingController();
    dNameController = TextEditingController();
    dateTimeController = TextEditingController();
    locationController = TextEditingController();
  }

  showConfirmSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (_) {
          return ConfirmSheet(
            onOk: () {
              showSuccessSheet(context);
            },
          );
        });
  }

  phoneConfirmSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (_) {
          return PhoneConfirmSheet(
            onOk: () {
              showSuccessSheet(context);
            },
          );
        });
  }

  showSuccessSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return const SuccessSheet();
        });
  }
}
