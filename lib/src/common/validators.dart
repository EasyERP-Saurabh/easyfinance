class Validators {
  static String? isEmptyValidator(String? value) {
    if (value!.trim().isEmpty) {
      return 'Invalid Value';
    }
    return null;
  }

  static String? isValidMonth(String? value) {
    if (value!.trim().isEmpty) {
      return 'Invalid Value';
    }
    if (int.tryParse(value) == null) {
      return 'Invalid Integer';
    }
    if (int.parse(value) < 1 || int.parse(value) > 12) {
      return 'Invalid Month';
    }
    return null;
  }

  static String? isValidYear(String? value) {
    if (value!.trim().isEmpty) {
      return 'Invalid Value';
    }
    if (int.tryParse(value) == null) {
      return 'Invalid Integer';
    }
    if (int.parse(value) < 0 || int.parse(value) > 9999) {
      return 'Invalid Month';
    }
    return null;
  }
}
