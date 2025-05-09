import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:curved_nav/domain/failures/main_failure.dart';
import 'package:curved_nav/domain/models/Lending%20Card%20model/lending_model.dart';
import 'package:curved_nav/domain/models/history%20and%20others%20model/history_model.dart';
import 'package:curved_nav/domain/models/i_history_repository.dart';
import 'package:curved_nav/domain/models/i_join_repository.dart';
import 'package:curved_nav/domain/models/i_lender_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'lender_event.dart';
part 'lender_state.dart';
part 'lender_bloc.freezed.dart';

@injectable
class LenderBloc extends Bloc<LenderEvent, LenderState> {
  final ILenderRepository iLenderRepository;
  final IJoinRepository iJoinRepository;
  final IHistoryRepository iHistoryRepository;
  LenderBloc(
      this.iLenderRepository, this.iJoinRepository, this.iHistoryRepository)
      : super(LenderState.initial()) {
    on<GetData>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        getFailureOrSuccess: none(),
        isError: false,
      ));
      final Either<MainFailures, List<LendingModel>> getLenderDetails =
          await iLenderRepository.getDetails();
      emit(getLenderDetails.fold((failures) {
        return state.copyWith(
            isLoading: false,
            isError: true,
            getFailureOrSuccess: some(failures));
      }, (success) {
        success.sort((a, b) => b.datetime!.compareTo(a.datetime!));
        return state.copyWith(
            isLoading: false,
            isError: false,
            getFailureOrSuccess: some(success),
            joinData: state.joinData,
            data: success);
      }));
    });
    on<JoinGetData>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        getFailureOrSuccess: none(),
        isError: false,
      ));
      final Either<MainFailures, List<LendingModel>> getLenderDetails =
          await iJoinRepository.getJoinCardInformation(event.code);
      emit(getLenderDetails.fold((failures) {
        log('error: $failures');
        return state.copyWith(
            isLoading: false,
            isError: true,
            getFailureOrSuccess: some(failures));
      }, (success) {
        success.sort((a, b) => b.datetime!.compareTo(a.datetime!));
        return state.copyWith(
            isLoading: false,
            isError: false,
            getFailureOrSuccess: some(success),
            data: state.data,
            joinData: success);
      }));
    });
    on<History>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          getFailureOrSuccess: none(),
          historyData: [],
          isError: false,
        ),
      );
      final Either<MainFailures, List<HistoryModel>> getHistory = event.isJoiner
          ? await iHistoryRepository.getJoinerDetails(event.id)
          : await iHistoryRepository.getDetails(event.id);

      emit(getHistory.fold(
          (failure) => state.copyWith(
              isLoading: false,
              isError: true,
              getFailureOrSuccess: some(failure)), (success) {
        success.sort((a, b) => b.date!.compareTo(a.date!));
        log(success.toString());
        return state.copyWith(
            isLoading: false,
            isError: false,
            getFailureOrSuccess: some(success),
            historyData: success);
      }));
    });
    on<Search>((event, emit) async {
      emit(state.copyWith(
        isLoading: true,
        isError: false,
        searchData: [],
        isIdle: false,
        getFailureOrSuccess: none(),
      ));
      if (event.query.isEmpty) {
        emit(state.copyWith(searchData: [], isIdle: true));
      }

      final Either<MainFailures, List<LendingModel>> getLenderDetails =
          await iLenderRepository
              .searchResult(event.query.toLowerCase().trim());
      emit(getLenderDetails.fold(
          (failures) => state.copyWith(
              isLoading: false,
              isError: true,
              getFailureOrSuccess: some(failures)), (success) {
        success.sort((a, b) => b.datetime!.compareTo(a.datetime!));

        return state.copyWith(
            isLoading: false,
            isError: false,
            isIdle: false,
            getFailureOrSuccess: some(success),
            joinData: state.joinData,
            data: state.data,
            searchData: success);
      }));
    });
    on<ClearSearch>((event, emit) {
      emit(state.copyWith(
          searchData: [], isIdle: true, isLoading: false, isError: false));
    });
  }
}
