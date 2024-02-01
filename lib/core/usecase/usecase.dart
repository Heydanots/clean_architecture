// ignore: one_member_abstracts
abstract class Usecase<Type, Params> {
  Future<Type> call({Params? params});
}
