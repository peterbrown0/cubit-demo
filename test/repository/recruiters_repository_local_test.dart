import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recru_test/model/recruiter.dart';
import 'package:recru_test/repository/recruiters_repository.dart';

import 'recruiters_repository_local_test.mocks.dart';

class RecruitersRepositoryTest extends Mock implements RecruitersRepository {}

@GenerateMocks([RecruitersRepositoryTest])
Future<void> main() async {
  // TODO: Add tests for RecruitersRepositoryLocal
  late MockRecruitersRepositoryTest recruitersRepo;

  setUpAll(() {
    recruitersRepo = MockRecruitersRepositoryTest();
  });

  group('home repo test', () {
    test('test getRecruiters', () async {
      final recruiterLists = List.generate(
        20,
        (index) => Recruiter(
          name: "name",
          surname: index.toString(),
        ),
      );

      when(recruitersRepo.getRecruiters('')).thenAnswer((_) async {
        return recruiterLists;
      });

      final res = await recruitersRepo.getRecruiters('');

      expect(res, isA<List<Recruiter>>());
      expect(res, recruiterLists);
    });

    test('test fetchData throws Exception', () {
      when(recruitersRepo.getRecruiters('')).thenAnswer((_) async {
        throw Exception();
      });

      final res = recruitersRepo.getRecruiters('');
      expect(res, throwsException);
    });
  });
}
