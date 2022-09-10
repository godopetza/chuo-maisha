import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chuomaisha/blocs/auth/auth_bloc.dart';
import 'package:chuomaisha/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _authSubscription;

  SwipeBloc({
    required AuthBloc authBloc,
    required DatabaseRepository databaseRepository,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        super(SwipeLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<UpdateHome>(_onUpdateHome);
    on<SwipeLeft>(_onSwipeLeft);
    on<SwipeRight>(_onSwipeRight);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.status == AuthStatus.authenticated) {
        add(LoadUsers(user: state.user!));
      }
    });
  }

  void _onLoadUsers(
    LoadUsers event,
    Emitter<SwipeState> emit,
  ) {
    _databaseRepository.getUsers(event.user).listen((users) {
      print('Loading Users: $users');
      add(UpdateHome(users: users));
    });
  }

  void _onUpdateHome(
    UpdateHome event,
    Emitter<SwipeState> emit,
  ) {
    if (event.users!.isNotEmpty) {
      emit(SwipeLoaded(users: event.users!));
    } else {
      emit(SwipeError());
    }
  }

  void _onSwipeLeft(
    SwipeLeft event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;

      List<User> users = List.from(state.users)..remove(event.user);

      _databaseRepository.updateUserSwipe(
        _authBloc.state.authUser!.uid,
        event.user.uid!,
        false,
      );

      if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }

  void _onSwipeRight(
    SwipeRight event,
    Emitter<SwipeState> emit,
  ) async {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      String userId = _authBloc.state.authUser!.uid;
      List<User> users = List.from(state.users)..remove(event.user);

      await _databaseRepository.updateUserSwipe(
        userId,
        event.user.uid!,
        true,
      );

      if (event.user.swipeRight!.contains(userId)) {
        await _databaseRepository.updateUserMatch(
          userId,
          event.user.uid!,
        );
        emit(SwipeMatched(user: event.user));
      } else if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }

  @override
  Future<void> close() async {
    _authSubscription?.cancel();
    super.close();
  }
}
