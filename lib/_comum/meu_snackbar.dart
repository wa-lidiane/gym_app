import 'package:flutter/material.dart';

mostrarSnackBar({
  required BuildContext context,
  required String texto,
  bool isErro = true,
}) {
  SnackBar snackBar = SnackBar(
    content: Text(texto),
    backgroundColor: (isErro) ? Colors.red : Colors.green,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(16)),
    ),
    duration: Duration(seconds: 4),
    action: SnackBarAction(
      label: 'OK',
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
