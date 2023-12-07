import 'package:bloc_practice/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

const person1Url = 'http://127.0.0.1:5500/lib/src/res/api/person_1.json';
const person2Url = 'http://127.0.0.1:5500/lib/src/res/api/person_2.json';

typedef PersonsLoader = Future<Iterable<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonsLoader loader;

  const LoadPersonsAction({
    required this.loader,
    required this.url,
  }) : super();
}
