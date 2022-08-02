import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:bloc/bloc.dart';
import 'package:cognito_authentication_repository/cognito_authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:moraldistress/api_repository.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:moralpainapi/src/model/survey.dart';
import 'package:uuid/uuid.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart' as awssig;

part 'resources_state.dart';
part 'resources_event.dart';

class ResourcesBloc extends Bloc<ResourcesEvent, ResourcesState> {
  final log = Logger('ResourcesBloc');
  final uuid = Uuid();

  final ApiRepository repository;
  final CognitoAuthenticationRepository authRepository;
  StreamSubscription<AWSCredentials>? credentialsStream;

  final options = Set<String>();

  ResourcesBloc({required this.repository, required this.authRepository})
      : super(ResourcesLoading()) {
    on<ResourcesLoadEvent>(_onLoad);
    on<VisitedResourcesSubmitEvent>(_onSubmit);
    on<ResourceVisitedEvent>(_onUpdate);

    credentialsStream =
        authRepository.latestCredentials().listen(refreshCredentials);
  }

  void refreshCredentials(AWSCredentials credentials) {
    var credsSigFlavor = awssig.AWSCredentials(credentials.awsAccessKey!,
        credentials.awsSecretKey!, credentials.sessionToken);
    repository.credentialRefresh(credsSigFlavor);
  }

  void _onLoad(ResourcesLoadEvent event, Emitter<ResourcesState> emit) async {
    emit(ResourcesLoading());

    final data = await repository.fetchResiliencyResources();
    emit(ResourcesLoaded(data));
  }

  void _onSubmit(
      VisitedResourcesSubmitEvent event, Emitter<ResourcesState> emit) async {
    final builder = VisitedResiliencyResourcesBuilder();
    builder.selections.addAll(options);
    builder.timestamp = _secondsSinceEpoch();

    final success = await repository.submitVisitedResources(builder.build());
    emit(VisitedResourcesSubmitted(success));
  }

  void _onUpdate(ResourceVisitedEvent event, Emitter<ResourcesState> emit) {
    options.add(event.resourceId);
  }

  /**
   * UTC Seconds since epoch.
   */
  int _secondsSinceEpoch() {
    final utcNow = DateTime.now().toUtc();
    return utcNow.millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
  }
}
