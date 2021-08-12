//import 'package:math_expressions/math_expressions.dart';
//
//abstract class CalculatorService {
//  Future<String> getCalculatedValue(String value);
//  String deleteAll();
//  String deleteBack(String value);
//}
//
//class SimpleCalculatorService extends CalculatorService {
//  @override
//  Future<String> getCalculatedValue(String value) async {
//    Parser p = Parser();
//    Expression exp = p.parse(value);
//    return exp.evaluate(EvaluationType.REAL, ContextModel()).toString();
//  }
//
//  @override
//  String deleteAll() {
//    return "";
//  }
//
//  @override
//  String deleteBack(String value) {
//    int _length = value.length;
//    return value.replaceRange(_length - 1, _length, "");
//  }
//}