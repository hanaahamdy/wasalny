import '../../../../../config/language/locale_keys.g.dart';
import '../models/intro_slide_model.dart';

class IntroRepository {
  const IntroRepository();

  List<IntroSlideModel> getSlides() {
    return [
      IntroSlideModel(
        title: LocaleKeys.introWaslnyTitle,
        subtitle: LocaleKeys.introWaslnySubtitle,
        imagePath: 'assets/images/intro1.png',
      ),
    ];
  }
}
