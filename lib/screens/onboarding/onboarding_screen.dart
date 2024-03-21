import 'package:auto_route/auto_route.dart';
import 'package:kresas_app/router/router.dart';
import 'package:kresas_app/theme/colors.dart';
import 'package:kresas_app/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.gradientBackground,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 300,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        isLastPage = index == 1;
                      });
                    },
                    controller: controller,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 40),
                              Text(
                                'Cresus museum is empty...',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Cres museum, one of the greatest museum of France, has been robed!',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Finish all puzzles to find all statues and complete the cress collection',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 50),
                              Text(
                                'Help Cresus right before it’s too late!',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 38,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Complete all images!',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ActionButtonWidget(
                    text: isLastPage ? 'Start' : 'Next',
                    onTap: () {
                      isLastPage ? context.router.push(HomeRoute()) :
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    width: 200,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset('assets/images/elements/cresus.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
