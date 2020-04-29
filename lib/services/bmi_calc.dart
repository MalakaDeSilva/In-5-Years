class BMICalculator {
  double weight;
  double height;

  final String index_18_5 =
      "Your BMI index is below 18.5 and it falls within underweight.";
  final String index_25 =
      "Your BMI index is within healthier range. Keep up your healthy behaviours.";
  final String index_30 =
      "Your BMI index is above healthier range. Maintain healthier habbits.";
  final String index_35 =
      "Your BMI index is significantly hgiher. It falls within obese range. Maintain healthier habbits.";

  getBMI(double weight, double height) {
    double bmi = weight / (height * height);
    return bmi;
  }

  getStatus(double weight, double height) {
    double bmi = getBMI(weight, height);

    if (bmi <= 18.5) {
      return index_18_5;
    } else if (bmi > 18.5 && bmi <= 25.0) {
      return index_25;
    } else if (bmi > 25 && bmi <= 30.0) {
      return index_30;
    } else if (bmi > 30) {
      return index_35;
    }
  }
}
