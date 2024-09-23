import 'package:flutter_bloc/flutter_bloc.dart';
import '../../database/table/seat_allotment_db.dart';
import 'member_details_event.dart';
import 'member_details_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final SeatAllotment seatAllotment;

  MemberBloc(this.seatAllotment) : super(MemberInitial()) {
    on<FetchMembersEvent>((event, emit) async {
      emit(MemberLoading());
      try {
        if (event.index == 3) {
          // Fetch total collection if index is 3
          double totalCollection = await seatAllotment.getTotalCollection();
          emit(MemberTotalCollectionSuccess(totalCollection));
        } else {
          List<Map<String, dynamic>> members;

          // Fetch members based on index
          if (event.index == 0) {
            members = await seatAllotment.getActiveMembers();
          } else if (event.index == 1) {
            members = await seatAllotment.getUserData();
          } else if (event.index == 2) {
            members = await seatAllotment.getInactiveMembers();
          } else {
            members = []; // Empty list for default
          }

          emit(MemberSuccess(members));
        }
      } catch (error) {
        emit(MemberFailure(error.toString()));
      }
    });

    on<UpdateMemberStatusEvent>((event, emit) async {
      emit(MemberLoading());
      try {
        await seatAllotment.updateMemberStatus(memberId: event.memberId);

        emit(MemberUpdated());

        // Refetch members after deactivation
        add(FetchMembersEvent(0)); // Modify this logic based on your needs
      } catch (error) {
        emit(MemberFailure(error.toString()));
      }
    });
  }
}
