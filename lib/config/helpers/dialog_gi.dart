import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogGI {
  static void showAlertDialog(BuildContext context, {
    required String title,
    required String content,
    bool isDismissible = true,
    Color barrierColor = Colors.black54,
    String textActionOk = "Aceptar",
    String textActionCancel = "Cancelar",
    VoidCallback? actionOk,
    VoidCallback? actionCancel,
    ButtonStyleButton? btnOk,
    ButtonStyleButton? btnCancel,
    bool hasCancelBtn = true,
  }){
    dismissDialog()=> context.pop();
    actionOk ??= dismissDialog;
    actionCancel ??= dismissDialog;
    btnOk ??= FilledButton(onPressed: actionOk,
      child: Text(textActionOk));
    btnCancel ??= TextButton(onPressed: actionCancel,
      child: Text(textActionCancel));
    showDialog(
      context: context,
      barrierColor: barrierColor,
      barrierDismissible: isDismissible,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          if(hasCancelBtn) btnCancel!,
          btnOk!
        ],
    ));
  }
}