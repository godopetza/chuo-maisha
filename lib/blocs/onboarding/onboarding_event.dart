part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class StartOnboarding extends OnboardingEvent {
  final User user;

  StartOnboarding({
    this.user = const User(
      name: '',
      uid: '',
      role: '',
      interestedIn: '',
      gender: '',
      age: 0,
      location: '',
      imageUrls: [],
      bio: '',
      jobTitle: '',
      skills: [],
    ),
  });

  @override
  List<Object?> get props => [user];
}

class UpdateUser extends OnboardingEvent {
  final User user;

  UpdateUser({required this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateUserImages extends OnboardingEvent {
  final User? user;
  final XFile image;

  UpdateUserImages({this.user, required this.image});
  @override
  List<Object?> get props => [user, image];
}
