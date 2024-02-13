import 'package:dio/dio.dart';
import 'package:squaad_app/domain/datasources/squaad_datasource.dart';

import '../../config/constants/environment.dart';

class SquaadDBDatasource extends SquaadDatasouce {
  final dio = Dio(BaseOptions(baseUrl: Environment.squaadUrl));
  @override
  Future<List<String>> activeLicence(String license) async {
    // final response = await dio.post('/license');
    return [];
  }
}
