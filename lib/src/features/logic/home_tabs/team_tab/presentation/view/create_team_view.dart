part of '../imports/view_imports.dart';

class CreateTeamView extends StatefulWidget {
  const CreateTeamView({super.key});

  @override
  State<CreateTeamView> createState() => _CreateTeamViewState();
}

class _CreateTeamViewState extends State<CreateTeamView> {
  late final List<String> _sports = [
    LocaleKeys.stadiumsFootball,
    LocaleKeys.stadiumsBasketball,
    LocaleKeys.stadiumsTennis,
    LocaleKeys.stadiumsPadel,
  ];

  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlocProvider(
      create: (_) => CreateTeamCubit(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar(title: LocaleKeys.stadiumsCreateTeam),
        body: BlocBuilder<CreateTeamCubit, AsyncState<BaseModel?>>(
          builder: (context, _) {
            final cubit = context.read<CreateTeamCubit>();
            return Form(
              key: cubit.params.formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 20.h),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: ValueListenableBuilder<String?>(
                  valueListenable: cubit.params.selectedSportNotifier,
                  builder: (context, selectedSport, _) {
                    return ValueListenableBuilder<File?>(
                      valueListenable: cubit.params.teamImageNotifier,
                      builder: (context, teamImage, _) {
                        return _CreateTeamCard(
                          selectedSport: selectedSport,
                          sports: _sports,
                          teamNameController: cubit.params.teamNameController,
                          playersCountController:
                              cubit.params.playersCountController,
                          teamImage: teamImage,
                          onSportChanged: cubit.selectSport,
                          onPickImage: cubit.pickTeamImage,
                          onRemoveImage: cubit.removeTeamImage,
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: const _CreateTeamSubmitButton(),
      ),
    );
  }
}
