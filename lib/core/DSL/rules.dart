import 'package:sefertorah/core/DSL/main.dart';

typedef Condition = bool Function(MorphContext);
typedef Action = String Function(MorphContext);

RuleBuilder rule() => RuleBuilder();

class Rule {
  final Condition when;
  final Action then;

  Rule({required this.when, required this.then});
}

class RuleBuilder {
  late Condition _condition;

  RuleBuilder when(Condition c) {
    _condition = c;
    return this;
  }

  Rule then(Action a) {
    return Rule(when: _condition, then: a);
  }
}