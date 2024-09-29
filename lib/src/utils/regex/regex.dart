RegExp emailRegEx = RegExp(
  r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}",
);

RegExp passLowCaRegEx = RegExp(
  r'[a-z]',
);

RegExp passUpCaRegEx = RegExp(
  r'[A-Z]',
);

RegExp passSpeCarRegEx = RegExp(
  r'[!@#\$%^&*(),.?":{}|<>]',
);

RegExp passwordRegEx = RegExp(
  r'^(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{12,}$',
);
RegExp phoneRegEx = RegExp(
  r'^\+?(\d{1,3})?[-. ]?\(?\d{1,3}\)?[-. ]?\d{3}[-. ]?\d{4}$',
);

RegExp fourDigitRegEx = RegExp(
  r'^\d{1,4}$',
);

RegExp alphabetOnlyRegEx = RegExp(
  r'^[A-Za-z]+$',
);
RegExp nameRegEx = RegExp(
  r'^[A-Za-z ]+$',
);
