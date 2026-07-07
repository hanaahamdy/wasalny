enum NamedRoutes {
  splash('/'),
  login('/login'),
  resetPassword('/reset-password'),
  signUp('/sign-up'),
  stadiumSearch('/stadiums/search'),
  stadiumDetails('/stadiums/details'),
  bookingSummary('/stadiums/booking-summary');

  final String routeName;

  const NamedRoutes(this.routeName);
}
