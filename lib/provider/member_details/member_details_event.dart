import 'package:equatable/equatable.dart';

abstract class MemberEvent extends Equatable {
 const MemberEvent();

 @override
 List<Object> get props => [];
}

class FetchMembersEvent extends MemberEvent {
 final int index;

 const FetchMembersEvent(this.index);

 @override
 List<Object> get props => [index];
}

class UpdateMemberStatusEvent extends MemberEvent {
 final String memberId;

 const UpdateMemberStatusEvent(this.memberId);

 @override
 List<Object> get props => [memberId];
}
