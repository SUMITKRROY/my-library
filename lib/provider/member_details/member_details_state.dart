abstract class MemberState {}

class MemberInitial extends MemberState {}

class MemberLoading extends MemberState {}

class MemberSuccess extends MemberState {
  final List<Map<String, dynamic>> members;
  MemberSuccess(this.members);
}

class MemberTotalCollectionSuccess extends MemberState {
  final double totalCollection;
  MemberTotalCollectionSuccess(this.totalCollection);
}

class MemberFailure extends MemberState {
  final String error;
  MemberFailure(this.error);
}

class MemberUpdated extends MemberState {}
