import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/profile/data/data_sources/profile_remote_data_source_contract.dart';
import 'package:tracking_app/features/profile/data/models/profile_data_model.dart';
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

  // NOTE: getProfileData() حاليًا (مؤقتًا، لحد ما الـ API يشتغل فعليًا)
  // بيرجّع نفس الـ fakeData الثابتة سواء الـ data source نجح أو فشل.
  // الاختبارات دي بتتأكد من السلوك المؤقت ده بالظبط زي ما هو متعرّف
  // جوه ProfileRepoImpl.getProfileData().
  group('getProfileData', () {
    final tFakeEntity = ProfileDataEntity(
      id: '1',
      firstName: 'Kareem',
      lastName: 'Yasser',
      email: 'kareem.yasser@example.com',
      phone: '+201016473761',
      photo: 'assets/images/Gemini image profile.png',
    );

    test(
      'should return SuccessBaseResponse<ProfileDataEntity> with fixed '
      'fakeData when the data source succeeds',
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
        // الـ repo بيرجّع fakeData ثابتة، مش الـ mapping من الـ model الحقيقي
        expect(successResult.data.id, tFakeEntity.id);
        expect(successResult.data.firstName, tFakeEntity.firstName);
        expect(successResult.data.lastName, tFakeEntity.lastName);
        expect(successResult.data.email, tFakeEntity.email);
        expect(successResult.data.phone, tFakeEntity.phone);
        expect(successResult.data.photo, tFakeEntity.photo);

        verify(mockDataSource.getProfileData()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'should still return SuccessBaseResponse<ProfileDataEntity> with fixed '
      'fakeData when the data source returns an error (temporary fallback)',
      () async {
        // arrange
        final tException = Exception('Something went wrong');
        when(mockDataSource.getProfileData()).thenAnswer(
          (_) async => ErrorBaseResponse<ProfileDataModel>(
            error: tException,
            errorMessage: 'Something went wrong',
          ),
        );

        // act
        final result = await repo.getProfileData();

        // assert
        // مؤقتًا، حتى في حالة الـ error، الـ repo بيرجّع fakeData بدل
        // ما يبعت ErrorBaseResponse الحقيقي
        expect(result, isA<SuccessBaseResponse<ProfileDataEntity>>());
        final successResult = result as SuccessBaseResponse<ProfileDataEntity>;
        expect(successResult.data.id, tFakeEntity.id);
        expect(successResult.data.firstName, tFakeEntity.firstName);
        expect(successResult.data.lastName, tFakeEntity.lastName);
        expect(successResult.data.email, tFakeEntity.email);
        expect(successResult.data.phone, tFakeEntity.phone);
        expect(successResult.data.photo, tFakeEntity.photo);

        verify(mockDataSource.getProfileData()).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );
  });
}