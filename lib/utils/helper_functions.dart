//Class for creating Helper functions

class HelperFunction{

  //String first letter capitalize funcction
  static String firstLetterCapitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }
}