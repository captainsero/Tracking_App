import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/profile/data/data_sources/profile_remote_data_source_contract.dart';
import 'package:tracking_app/features/profile/data/models/profile_data_model.dart';
import 'package:tracking_app/features/profile/data/models/profile_model_mapper.dart';
import 'package:tracking_app/features/profile/data/repo/profile_repo_impl.dart';
import 'package:tracking_app/features/profile/domain/entities/profile_data_entity.dart';

// Run `dart run build_runner build --delete-conflicting-outputs`
// (or `flutter pub run build_runner build ...`) to generate
// profile_repo_impl_test.mocks.dart
import 'profile_repo_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSourceContract])
void main() {
  provideDummy<BaseResponse<String>>(const SuccessBaseResponse<String>(data: ''));
  provideDummy<BaseResponse<ProfileDataModel>>(
    SuccessBaseResponse<ProfileDataModel>(
      data: ProfileDataModel(
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        gender: '',
        phone: '',
        photo: '',
        role: '',
        wishlist: const [],
        addresses: const [],
        createdAt: '',
      ),
    ),
  );

  late MockProfileRemoteDataSourceContract mockDataSource;
  late ProfileRepoImpl repo;

  setUp(() {
    mockDataSource = MockProfileRemoteDataSourceContract();
    repo = ProfileRepoImpl(profileRemoteDataSourceContract: mockDataSource);
  });

  group('logout', () {
    test(
      'should return the exact SuccessBaseResponse<String> coming from the '
      'data source, unchanged',
      () async {
        // arrange
        const tResponse = SuccessBaseResponse<String>(
          data: 'Logged out successfully',
        );
        when(mockDataSource.logout()).thenAnswer((_) async => tResponse);

        // act
        final result = await repo.logout();

        // assert
        expect(result, same(tResponse)); // repo just forwards the response
        verify(mockDataSource.logout()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return the exact ErrorBaseResponse<String> coming from the '
      'data source, unchanged',
      () async {
        // arrange
        final tException = Exception('Network error');
        final tResponse = ErrorBaseResponse<String>(
          error: tException,
          errorMessage: 'Network error',
        );
        when(mockDataSource.logout()).thenAnswer((_) async => tResponse);

        // act
        final result = await repo.logout();

        // assert
        expect(result, same(tResponse));
        verify(mockDataSource.logout()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });

  group('getProfileData', () {
    test(
      'should return ErrorBaseResponse<ProfileDataEntity> with the same '
      'error/errorMessage when the data source returns an error',
      () async {
        // arrange
        final tException = Exception('Something went wrong');
        const tErrorMessage = 'Something went wrong';
        when(mockDataSource.getProfileData()).thenAnswer(
          (_) async => ErrorBaseResponse<ProfileDataModel>(
            error: tException,
            errorMessage: tErrorMessage,
          ),
        );

        // act
        final result = await repo.getProfileData();

        // assert
        expect(result, isA<ErrorBaseResponse<ProfileDataEntity>>());
        final errorResult = result as ErrorBaseResponse<ProfileDataEntity>;
        expect(errorResult.error, tException);
        expect(errorResult.errorMessage, tErrorMessage);
        verify(mockDataSource.getProfileData()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should return SuccessBaseResponse<ProfileDataEntity> mapped from the '
      'model when the data source succeeds',
      () async {
        // arrange
        final tProfileDataModel = ProfileDataModel(
          id: '123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          gender: 'male',
          phone: '1234567890',
          photo: 'photo_url',
          role: 'user',
          wishlist: const [],
          addresses: const [],
          createdAt: '2026-06-21T00:00:00Z',
        );
        final tProfileDataEntity = tProfileDataModel.toEntity();

        when(mockDataSource.getProfileData()).thenAnswer(
          (_) async => SuccessBaseResponse<ProfileDataModel>(
            data: tProfileDataModel,
          ),
        );

        // act
        final result = await repo.getProfileData();

        // assert
        expect(result, isA<SuccessBaseResponse<ProfileDataEntity>>());
        final successResult = result as SuccessBaseResponse<ProfileDataEntity>;
        expect(successResult.data.id, tProfileDataEntity.id);
        expect(successResult.data.firstName, tProfileDataEntity.firstName);
        expect(successResult.data.lastName, tProfileDataEntity.lastName);
        expect(successResult.data.email, tProfileDataEntity.email);
        expect(successResult.data.gender, tProfileDataEntity.gender);
        expect(successResult.data.phone, tProfileDataEntity.phone);
        expect(successResult.data.photo, tProfileDataEntity.photo);
        expect(successResult.data.role, tProfileDataEntity.role);
        expect(successResult.data.wishlist, tProfileDataEntity.wishlist);
        expect(successResult.data.addresses, tProfileDataEntity.addresses);
        expect(successResult.data.createdAt, tProfileDataEntity.createdAt);

        verify(mockDataSource.getProfileData()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });
}