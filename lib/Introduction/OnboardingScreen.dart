import 'package:car_rental_admin/Authentication%20_Screens/auth.dart';
import 'package:car_rental_admin/Introduction/Details.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OnBoardingScreenState();
  }
}

class _OnBoardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int currentindex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _isDarkmode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (int curindex) {
                setState(() {
                  currentindex = curindex;
                });
              },
              itemCount: onboardingContentsAdmin.length,
              itemBuilder: (ctx, index) => Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(onboardingContentsAdmin[index].image,
                        fit: BoxFit.contain, width: 250),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(onboardingContentsAdmin[index].title,
                        style: _isDarkmode
                            ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )
                            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.black,
                                )),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      onboardingContentsAdmin[index].descritpion,
                      textAlign: TextAlign.center,
                      style: _isDarkmode
                          ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              )
                          : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w200,
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          currentindex != onboardingContentsAdmin.length - 1
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _controller
                                  .jumpToPage(onboardingContentsAdmin.length);
                            });
                          },
                          child: const Text('Skip')),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingContentsAdmin.length,
                          (index) => Container(
                            width: currentindex == index ? 20 : 8,
                            height: 10,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: currentindex == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _controller.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeIn);
                            });
                          },
                          child: const Text('Next')),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) => const AuthScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            animation = CurvedAnimation(
                                parent: animation, curve: Curves.ease);
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize: const Size.fromHeight(80),
                    ),
                    child: Text('Get Started',
                        style: _isDarkmode
                            ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                )
                            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                )),
                  ),
                ),
        ],
      ),
    );
  }
}
