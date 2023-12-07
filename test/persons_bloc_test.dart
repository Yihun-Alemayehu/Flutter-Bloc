import 'package:bloc_practice/bloc/bloc_actions.dart';
import 'package:bloc_practice/bloc/person.dart';
import 'package:bloc_practice/bloc/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPersons1 = [
  Person(
    name: 'Zeri',
    age: 20,
  ),
  Person(
    name: 'Abi',
    age: 30,
  ),
];

const mockedPersons2 = [
  Person(
    name: 'Zeri',
    age: 20,
  ),
  Person(
    name: 'Abi',
    age: 30,
  ),
];

Future<Iterable<Person>> mockGetPersons1(String url) =>
    Future.value(mockedPersons1);

Future<Iterable<Person>> mockGetPersons2(String url) =>
    Future.value(mockedPersons2);

void main() {
  group(
    'Testing bloc',
    () {
      late PersonsBloc bloc;

      setUp(() {
        bloc = PersonsBloc();
      });

      blocTest<PersonsBloc, FetchData?>(
        'Test initial state',
        build: () => bloc,
        verify: (bloc) => expect(bloc.state, null),
      );

      blocTest<PersonsBloc, FetchData?>(
        'Mock retrieving person',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonsAction(
              loader: mockGetPersons1,
              url: 'http',
            ),
          );
          bloc.add(
            const LoadPersonsAction(
              loader: mockGetPersons1,
              url: 'http',
            ),
          );
        },
        expect: () => [
          const FetchData(
            persons: mockedPersons1,
            isRetrievedFromCache: false,
          ),
        ],
      );

      blocTest<PersonsBloc, FetchData?>(
        'Mock retrieving person',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonsAction(
              loader: mockGetPersons2,
              url: 'http2',
            ),
          );
          bloc.add(
            const LoadPersonsAction(
              loader: mockGetPersons2,
              url: 'http2',
            ),
          );
        },
        expect: () => [
          const FetchData(
            persons: mockedPersons2,
            isRetrievedFromCache: false,
          ),
        ],
      );
    },
  );
}
