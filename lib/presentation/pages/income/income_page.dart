import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/appbar/custom_generic_appbar.dart';
import 'package:pad_lampung/presentation/pages/income/tabs/offline_income_tab.dart';
import 'package:pad_lampung/presentation/pages/income/tabs/online_income_tab.dart';

const int itemLength = 2;

class IncomePage extends StatefulWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currTab = 0;

  void handleTabSelection() {
    if (tabController.indexIsChanging ||
        tabController.index != tabController.previousIndex) {
      currTab = tabController.index;
      setState(() {});
    }
  }


  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: itemLength, vsync: this);
    tabController.addListener(handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.canvasColor,
      body: SafeArea(
        child: buildTabSection(),
      ),
    );
  }

  Widget buildTabSection() {
    return DefaultTabController(
      length: itemLength,
      initialIndex: currTab,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: GenericAppBar(url: '', title: 'Pendapatan'),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(2, 4, 4, 2),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: TabBar(
              indicatorPadding: EdgeInsets.zero,
              labelPadding: const EdgeInsets.symmetric(horizontal: 4),
              indicatorColor: Colors.transparent,
              controller: tabController,
              tabs: [
                tabItem(0, "Tunai"),
                tabItem(1, "Non Tunai"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                OfflineIncomeTab(),
                OnlineIncomeTab()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tabItem(int index, String title) {
    Color colTab;
    Color colText;
    if (index == currTab) {
      // colTab = Colors.white;
      // colText = AppTheme.primaryColor;
      colTab = AppTheme.primaryColor;
      colText = Colors.white;
    } else {
      // colTab = AppTheme.primaryColor;
      // colText = Colors.white;
      colTab = Colors.white;
      colText = AppTheme.primaryColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration:
          BoxDecoration(color: colTab, borderRadius: BorderRadius.circular(16)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(title,
            style: TextStyle(
                color: colText, fontWeight: FontWeight.w600, fontSize: 14))
      ]),
    );
  }
}
