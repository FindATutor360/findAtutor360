// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

typedef Operation<T> = Future<T> Function();

abstract class OperationRunnerState<T extends StatefulWidget> extends State<T> {
  @protected
  // ignore: avoid_shadowing_type_parameters
  Future<T?> runOperation<T>(
    Operation operation, {
    BuildContext? contextE,
    bool showLoader = true,
  }) async {
    contextE ??= context;

    try {
      final result = await operation();

      if (showLoader) Navigator.pop(context);

      return result as T;
    } on DioException catch (e) {
      if (showLoader) Navigator.pop(context);

      await showSnackMessage(context, e.message!, isError: true);
    } catch (e) {
      if (showLoader) Navigator.pop(context);

      await showSnackMessage(context, e.toString(), isError: true);
    }

    return null;
  }
}

Future<dynamic> showSnackMessage(context, String message,
    {bool isError = false}) async {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: isError ? Colors.red : Colors.blue,
    ),
  );
}
