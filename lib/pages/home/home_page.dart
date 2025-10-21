import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:saiyan_official/core/resources/app_colors.dart';
import 'package:saiyan_official/viewmodel/home/home_page_view_model.dart';
import 'package:suffadaemon/components/texts/title_text.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  HomePageViewModel homePageViewModel = HomePageViewModel();
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this, initialIndex: 1);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    super.dispose();

    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark(context),
        body: SafeArea(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              // settings
              Center(child: SuffaText(title: "Settings")),

              Center(child: SuffaText(title: "Home")),

              // books
              Center(child: SuffaText(title: "Library")),
            ],
          ),
        ),
      ),
    );
  }
}
