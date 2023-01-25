abstract class StarterState {}

class InitiateStarterState extends StarterState {}

class LoadingStarter extends StarterState {}

class NavigateToHomeParking extends StarterState {
  final String? lastXenditTransactionUrl;

  NavigateToHomeParking(this.lastXenditTransactionUrl);
}

class NavigateToHomeTicket extends StarterState {
  final String? lastXenditTransactionUrl;

  NavigateToHomeTicket(this.lastXenditTransactionUrl);
}

class NavigateToLogin extends StarterState {}

class NavigateToOnBoarding extends StarterState {}