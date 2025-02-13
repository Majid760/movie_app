import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
