part of '../presentation/imports/view_imports.dart';

class _FakeTeamApi {
  const _FakeTeamApi._();

  static Future<TeamPayload> getTeamPayload() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    return const TeamPayload(
      members: [
        TeamPlayer(
          name: 'أحمد محمد',
          city: 'الرياض',
          role: 'قائد',
          avatarColor: Color(0xFFEDE4DB),
        ),
        TeamPlayer(
          name: 'محمود علي',
          city: 'الرياض',
          avatarColor: Color(0xFFF0D471),
        ),
        TeamPlayer(
          name: 'كريم حسن',
          city: 'الرياض',
          avatarColor: Color(0xFFEAD8CB),
        ),
        TeamPlayer(
          name: 'يوسف طارق',
          city: 'الرياض',
          avatarColor: Color(0xFFE7C49D),
        ),
        TeamPlayer(
          name: 'مصطفى رضا',
          city: 'الرياض',
          avatarColor: Color(0xFFE3D6CF),
        ),
        TeamPlayer(
          name: 'تامر عادل',
          city: 'الرياض',
          avatarColor: Color(0xFFD9E6F3),
        ),
      ],
      requests: [
        TeamPlayer(
          name: 'خالد إبراهيم',
          city: 'الرياض',
          avatarColor: Color(0xFFE6C3A8),
        ),
        TeamPlayer(
          name: 'محمد الشريف',
          city: 'الرياض',
          avatarColor: Color(0xFFD7C0AE),
        ),
        TeamPlayer(
          name: 'عبدالله ناصر',
          city: 'الرياض',
          avatarColor: Color(0xFFDFE7E9),
        ),
      ],
    );
  }
}
