import 'package:bloc_practice/bloc/persons_bloc.dart';
import 'package:bloc_practice/example_1.dart';
import 'package:bloc_practice/example_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PersonsBloc(),
        child: const ExampleTwo(),
      ),
    ),
  );
}
