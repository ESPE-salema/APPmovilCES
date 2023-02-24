validateString(String value) {
  String patttern = r'(^[a-zA-Z0-9À-ÿ\u00f1\u00d1]+(\s*[a-z0-9A-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA0-9-ZÀ-ÿ\u00f1\u00d1]+$)';
  RegExp regExp = RegExp(patttern);
  if (value.isEmpty) {
    return "Ingrese alguna letra para continuar";
  } else if (!regExp.hasMatch(value)) {
    return 'Por favor solo ingrese letras';
  } else if (value.length < 5) {
    return "Debe ingresar al menos 5 caracteres";
  }
  return null;
}

String? validateInteger(String? age) {
  String patttern = r'(^[0-9]*$)'; //comprobar si funciona
  RegExp regExp = RegExp(patttern);
  if (!regExp.hasMatch(age!)) {
    return "El precio requiere caracteres numéricos para continuar";
  } else if (age.isNotEmpty && age.length <= 3) {
    return null;
  } else {
    return "Precio no valido";
  }
}
