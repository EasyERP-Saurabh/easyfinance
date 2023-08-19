class Validators {
  static String? isEmptyValidator(String? value) {
    if (value!.trim().isEmpty) {
      return 'Invalid Value';
    }
    return null;
  }
}
