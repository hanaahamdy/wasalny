part of '../imports/view_imports.dart';

class TeamTabView extends StatefulWidget {
  const TeamTabView({super.key});

  @override
  State<TeamTabView> createState() => _TeamTabViewState();
}

class _TeamTabViewState extends State<TeamTabView> {
  bool _showMembers = true;

  final List<TeamPlayer> _members = const [
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
  ];

  final List<TeamPlayer> _requests = const [
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
  ];

  Future<void> _acceptRequest() async {
    await successDialog(
      context: context,
      title: LocaleKeys.teamJoinAcceptedSuccessfully,
    );
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          const TeamHeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                AppPadding.pW14,
                AppPadding.pH16,
                AppPadding.pW14,
                AppPadding.pH20,
              ),
              child: Column(
                spacing: AppMargin.mH14,
                children: [
                  TeamSegmentedTabs(
                    showMembers: _showMembers,
                    onChanged: (value) => setState(() => _showMembers = value),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child: _showMembers
                        ? Column(
                            key: const ValueKey('members'),
                            spacing: AppMargin.mH12,
                            children: _members
                                .asMap()
                                .entries
                                .map(
                                  (entry) => TeamMemberCardWidget(
                                    player: entry.value,
                                    number: entry.key + 1,
                                  ),
                                )
                                .toList(),
                          )
                        : Column(
                            key: const ValueKey('requests'),
                            spacing: AppMargin.mH12,
                            children: _requests
                                .map(
                                  (player) => TeamRequestCardWidget(
                                    player: player,
                                    onAccept: _acceptRequest,
                                  ),
                                )
                                .toList(),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TeamPlayer {
  final String name;
  final String city;
  final String? role;
  final Color avatarColor;

  const TeamPlayer({
    required this.name,
    required this.city,
    required this.avatarColor,
    this.role,
  });
}
