String mobileValidate(v) {
  if (v.isEmpty)
    return "رقم الجوال لا يمكن أن يكون فارغاً";
  else if (v.length < 10)
    return "رقم الجوال يجب ألا يقل عن 10 أرقام";
  else if (int.tryParse(v) == null)
    return "رقم الجوال يجب ألا يحتوي على رموز أو أحرف";
  else
    return null;
}

String experienceValidate(v) {
  if (v.isEmpty)
    return "عدد سنوات الخبرة لا يمكن أن يكون فارغاً";
  else if (int.tryParse(v) == null)
    return "عدد السنوات يجب ألا يحتوي على أحرف أو رموز";
  else if (int.parse(v) > 100)
    return "عدد سنوات الخبرة يجب ألا يتعدى ال 100 عام";
  else
    return null;
}

String ageValidate(v) {
  if (v.isEmpty)
    return "العمر لا يمكن أن يكون فارغاً";
  else if (int.tryParse(v) == null)
    return "العمر يجب ألا يحتوي على أحرف أو رموز";
  else if (int.parse(v) > 100)
    return "العمر يجب ألا يتعدى ال 100 عام";
  else
    return null;
}

String hitDetailsValidate(v) {
  if (v == null || v.isEmpty)
    return "تفاصيل الإصابة مطلوبة";
  else
    return null;
}

String messageValidate(v) {
  if (v.isEmpty)
    return "الرسالة لا يمكن أن تكون فارغة";
  else
    return null;
}

String workValidate(v) {
  if (v.isEmpty)
    return "قطاع العمل لا يمكن أن يكون فارغاً";
  else
    return null;
}

String emptyValidate(v) {
  if (v.isEmpty)
    return "ًهذا الحقل لا يمكن أن يكون فارغاً";
  else
    return null;
}

String titleValidate(v) {
  if (v.isEmpty)
    return "ًالعنوان لا يمكن أن يكون فارغاً";
  else
    return null;
}

String priceValidate(v) {
  if (v.isEmpty)
    return "ًالسعر لا يمكن أن يكون فارغاً";
  else if (double.tryParse(v) == null)
    return "السعر يجب ألا يحتوي على أي رمز";
  else
    return null;
}

String noteValidate(v) {
  if (v.isEmpty)
    return "ًالوصف لا يمكن أن يكون فارغاً";
  else
    return null;
}

String detailsValidate(v) {
  if (v.isEmpty)
    return "ًالتفاصيل لا يمكن أن تكون فارغة";
  else if (v.length < 25)
    return "تفاصيل الإعلان يجب ألا تقل عن 25 حرف";
  else
    return null;
}

String occuValidate(v) {
  if (v.isEmpty)
    return "الوظيفة لا يمكن أن تكون فارغة";
  else
    return null;
}

String nameValidate(v) {
  if (v.isEmpty)
    return "الاسم لا يمكن أن يكون فارغاً";
// else {
//   List co=v.toString().split(" ");
//     if(co.last==""||co.length<4)
//       return "من فضلك أدخل اسمك الرباعي";
  else
    return null;

  // }
}

String civilValidate(v) {
  if (v.isEmpty)
    return "رقم الهوية لا يمكن أن يكون فارغاً";
  else if (int.tryParse(v) == null)
    return "رقم الهوية يجب ألا يحتوي على رموز أو أحرف";
  else
    return null;
}

String qulificationValidate(v) {
  if (v.isEmpty)
    return "المؤهل الدراسي لا يمكن أن يكون فارغاً";
  else
    return null;
}

String codeValidate(v) {
  if (v.isEmpty)
    return "كود التفعيل لا يمكن أن يكون فارغاً";
  else if (v.length < 4)
    return "كود التفعيل يتكون من 4 أرقام";
  else
    return null;
}

String specializationValidate(v) {
  if (v.isEmpty)
    return "التخصص لا يمكن أن يكون فارغاً";
  else
    return null;
}

String emailValidate(v) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(v) || v.isEmpty)
    return "من فضلك أدخل بريد إلكتروني صحيح";
  else
    return null;
}

String passwordValidate(v) {
  if (v.isEmpty)
    return "كلمة المرور لا يمكن أن تكون فارغة";
  else if (v.length < 6)
    return "كلمة المرور يجب ألا تقل عن 8 أحرف";
  else
    return null;
}
