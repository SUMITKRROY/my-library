part of 'getseat_bloc.dart';

@immutable
sealed class GetSeatEvent {}

class GetSeatSuccessEvent extends GetSeatEvent {}

class InsertSeatEvent extends GetSeatEvent {
  final String selectedShift;
  final String memberId;
  final String name;
  final String chairNo;
  final String amount;
  final String dateOfJoining;
  final String memberStatus;

  // Constructor with required parameters
  InsertSeatEvent({
    required this.selectedShift,
    required this.memberId,
    required this.name,
    required this.chairNo,
    required this.amount,
    required this.dateOfJoining,
    required this.memberStatus,
  });
}

class DeleteAllSeatsEvent extends GetSeatEvent {}
