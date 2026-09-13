import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/stripe_connect_model.dart';
import '../../../data/repositories/stripe_connect_repository.dart';

// ─── Events ──────────────────────────────────────────────────────────────────
abstract class StripeConnectEvent {}

class FetchStripeConnectStatusEvent extends StripeConnectEvent {}

class GetStripeOnboardingLinkEvent extends StripeConnectEvent {
  final String? returnUrl;
  final String? refreshUrl;

  GetStripeOnboardingLinkEvent({this.returnUrl, this.refreshUrl});
}

class RetryOrderPayoutEvent extends StripeConnectEvent {
  final String orderId;

  RetryOrderPayoutEvent(this.orderId);
}

// ─── States ──────────────────────────────────────────────────────────────────
abstract class StripeConnectState {}

class StripeConnectInitial extends StripeConnectState {}

class StripeConnectLoading extends StripeConnectState {}

class StripeConnectLoaded extends StripeConnectState {
  final StripeConnectStatusModel status;

  StripeConnectLoaded(this.status);
}

class StripeOnboardingLinkGenerated extends StripeConnectState {
  final String url;
  final StripeConnectStatusModel? currentStatus;

  StripeOnboardingLinkGenerated(this.url, {this.currentStatus});
}

class StripeConnectError extends StripeConnectState {
  final String message;

  StripeConnectError(this.message);
}

class StripePayoutRetrySuccess extends StripeConnectState {
  final String message;

  StripePayoutRetrySuccess(this.message);
}

// ─── Bloc Implementation ─────────────────────────────────────────────────────
class StripeConnectBloc extends Bloc<StripeConnectEvent, StripeConnectState> {
  final StripeConnectRepository repository;

  StripeConnectStatusModel? _lastStatus;

  StripeConnectBloc({required this.repository}) : super(StripeConnectInitial()) {
    on<FetchStripeConnectStatusEvent>(_onFetchStatus);
    on<GetStripeOnboardingLinkEvent>(_onGetOnboardingLink);
    on<RetryOrderPayoutEvent>(_onRetryPayout);
  }

  Future<void> _onFetchStatus(
    FetchStripeConnectStatusEvent event,
    Emitter<StripeConnectState> emit,
  ) async {
    emit(StripeConnectLoading());
    final response = await repository.getStripeConnectStatus();
    if (response.success && response.data != null) {
      _lastStatus = response.data;
      emit(StripeConnectLoaded(response.data!));
    } else {
      emit(StripeConnectError(response.message));
    }
  }

  Future<void> _onGetOnboardingLink(
    GetStripeOnboardingLinkEvent event,
    Emitter<StripeConnectState> emit,
  ) async {
    emit(StripeConnectLoading());
    final response = await repository.getOnboardingLink(
      returnUrl: event.returnUrl,
      refreshUrl: event.refreshUrl,
    );
    if (response.success && response.data != null && response.data!.url.isNotEmpty) {
      emit(StripeOnboardingLinkGenerated(
        response.data!.url,
        currentStatus: _lastStatus,
      ));
    } else {
      emit(StripeConnectError(response.message));
    }
  }

  Future<void> _onRetryPayout(
    RetryOrderPayoutEvent event,
    Emitter<StripeConnectState> emit,
  ) async {
    emit(StripeConnectLoading());
    final response = await repository.retryPayout(event.orderId);
    if (response.success) {
      emit(StripePayoutRetrySuccess(response.message));
      add(FetchStripeConnectStatusEvent());
    } else {
      emit(StripeConnectError(response.message));
    }
  }
}
