import 'package:formz/formz.dart';

enum AmountValidationError {
  invalid
}

class Amount extends FormzInput<double, AmountValidationError> {
  const Amount.pure({
    required double balance
  }) : this.balance = balance, super.pure(0);

  const Amount.dirty({
    required this.balance,
    double value = 0
  }) : super.dirty(value);

  final double balance;

  @override
  AmountValidationError? validator(double? value) {
    print('validator value: $value, balance: $balance');
    return value != null && value <= balance && value > 0
        ? null : AmountValidationError.invalid;
  }
}
