part of '../imports/view_imports.dart';

class IntroViewModel extends ChangeNotifier {
  final IntroRepository _repository;

  late final List<IntroSlideModel> slides;
  int _currentIndex = 0;

  IntroViewModel({IntroRepository repository = const IntroRepository()})
    : _repository = repository {
    slides = _repository.getSlides();
  }

  int get currentIndex => _currentIndex;

  int get indicatorCount => 3;

  IntroSlideModel get currentSlide => slides[_currentIndex];

  void updateIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }

  void start(BuildContext context) {
    Go.offAll(const LoginScreen());
  }
}
