import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failure.dart';

/// Класс для выполнения бизнес логики, который невозможно вывести
/// UseCase<Type - тип возврата без ошибок, Params - при возникновении ошибки изменится код в usecases и вернется этот тип> 
abstract class UseCase<Type, Params> {

/// Метод с опциональным названием, чтобы не придумывать свои имена для множества методов.
  Future<Either<Failure, Type>> call(Params params);
}

// 1.3
// Абстрактный класс для предоставления методов из domain/usecases/
