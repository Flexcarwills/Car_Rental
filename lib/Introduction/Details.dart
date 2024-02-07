class AdminIntoduction {
  const AdminIntoduction(
      {required this.image, required this.title, required this.descritpion});

  final String image;
  final String title;
  final String descritpion;
}

final onboardingContentsAdmin = [
  const AdminIntoduction(
      image: 'assets/images/Image1.json',
      title: 'Add Car For Rent',
      descritpion: 'Add your car for rent and have a greater income'),
  const AdminIntoduction(
      image: 'assets/images/Image2.json',
      title: 'Dashboard Insights',
      descritpion: ''),
  const AdminIntoduction(
      image: 'assets/images/Image3.json',
      title: 'Communication Panel',
      descritpion:
          'Communicate and Resolve the Queries of Customers and Provide the Best Service.')
];
