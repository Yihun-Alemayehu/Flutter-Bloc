import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
abstract class LoadPersonsAction implements LoadAction {
  final PersonUrl url;

  const LoadPersonsAction({
    required this.url,
  }) : super();
}

@immutable
class Person {
  final String name;
  final int age;

  const Person({
    required this.name,
    required this.age,
  });

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;
}

enum PersonUrl {
  person1,
  person2,
}

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return 'http://127.0.0.1:5500/lib/src/res/api/person_1.json';
      case PersonUrl.person2:
        return 'http://127.0.0.1:5500/lib/src/res/api/person_2.json';
    }
  }
}

Future<Iterable<Person>> getPerson(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((res) => res.transform(utf8.decoder).join())
    .then((str) => jsonDecode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

@immutable
class FetchData {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  const FetchData({
    required this.persons,
    required this.isRetrievedFromCache,
  });

  @override
  String toString() =>
      'FetchResult (isRetrievedFromCache = $isRetrievedFromCache , persons = $persons,)';
}

class PersonsBloc extends Bloc<LoadAction, FetchData?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonsAction>(
      (event, emit) {
        final url = event.url;
        if (_cache.containsKey(url)) {
          final cachedPersons = _cache[url]!;
          final result = FetchData(
            persons: cachedPersons,
            isRetrievedFromCache: true,
          );
          emit(result);
        }else {
          
        }
      },
    );
  }
}

class ExampleTwo extends StatelessWidget {
  const ExampleTwo({super.key});

  @override
  Widget build(BuildContext context) {
    late final Bloc myBloc;
    return const Scaffold();
  }
}
