enum NamedRoutes {
  splash('/'),
  login('/login'),
  resetPassword('/reset-password'),
  signUp('/sign-up'),
  team('/team'),
  stadiumSearch('/stadiums/search'),
  stadiumDetails('/stadiums/details'),
  bookingSummary('/stadiums/booking-summary');

  final String routeName;

  const NamedRoutes(this.routeName);
}
