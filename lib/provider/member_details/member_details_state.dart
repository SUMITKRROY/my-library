import 'package:equatable/equatable.dart';

abstract class MemberState extends Equatable {
  const MemberState();

  @override
  List<Object> get props => [];
}

class MemberInitial extends MemberState {}

class MemberLoading extends MemberState {}

class MemberSuccess extends MemberState {
  final List<Map<String, dynamic>> members;

  const MemberSuccess(this.members);

  @override
  List<Object> get props => [members];
}

class MemberFailure extends MemberState {
  final String error;

  const MemberFailure(this.error);

  @override
  List<Object> get props => [error];
}

class MemberUpdated extends MemberState {}
