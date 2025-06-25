
import 'package:attach/componant/online_user_widget.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/listener_filer_provider.dart';
import 'package:attach/screens/home_sub_screen/ageRangeDailod.dart';
import 'package:attach/screens/home_sub_screen/language%20dailoge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListerFilterScreen extends StatefulWidget {
  const ListerFilterScreen({super.key});

  @override
  State<ListerFilterScreen> createState() => _ListerFilterScreenState();
}

class _ListerFilterScreenState extends State<ListerFilterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ListenerFilterProvider>(context, listen: false).init(context);
    _scrollController.addListener((){
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent)
        {
          Provider.of<ListenerFilterProvider>(context, listen: false).getMore();
        }
    });
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListenerFilterProvider>(
      builder:
          (context, p, child) => WillPopScope(
            onWillPop: () async {
              _scrollController.dispose();
              Provider.of<ListenerFilterProvider>(
                context,
                listen: false,
              ).clear(context);
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text("All Listeners"),
                centerTitle: false,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      children: [
                        //Language
                        Expanded(
                          child: Container(
                            height: SC.from_width(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.white),
                            ),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => LanguageDialog(),
                                );
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: SC.from_width(13),
                                      right: SC.from_width(11),
                                    ),
                                    child: Image.asset(
                                      "assets/icons/home_icon/solar_user-speak-bold.png",
                                      width: SC.from_width(20),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      p.selectedLanguage?.name ?? 'Language',
                                      style: Const.font_500_14(
                                        context,
                                        size: SC.from_width(15),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: SC.from_width(13),
                                    ),

                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: SC.from_width(30),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: SC.from_width(11)),

                        //Age Group
                        Expanded(
                          child: Container(
                            height: SC.from_width(40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.white),
                            ),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => AgeRangeDialog(),
                                );
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: SC.from_width(13),
                                      right: SC.from_width(11),
                                    ),
                                    child: Image.asset(
                                      "assets/icons/home_icon/age-group 1.png",
                                      width: SC.from_width(20),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      p.selectedRange == null
                                          ? 'Age Range'
                                          : '${p.selectedRange?.start.toInt()}-${p.selectedRange?.end.toInt()}',
                                      style: Const.font_500_14(
                                        context,
                                        size: SC.from_width(15),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: SC.from_width(13),
                                    ),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: SC.from_width(30),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              body:
                  (p.isInit == false)
                      ? Center(child: CircularProgressIndicator())
                      : (p.listener.isEmpty)
                      ? Center(child: Text("No Listeners"))
                      : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        itemCount: p.listener.length,
                        separatorBuilder:
                            (context, index) =>
                                SizedBox(height: SC.from_width(0)),
                        itemBuilder:
                            (context, index) =>
                                OnlineUserWidget(
                                  key: ValueKey(p.listener[index].id),
                                  onFollow: (){
                                    p.updateFollow(p.listener[index]);
                                  },
                                    listener: p.listener[index]),
                      ),
            ),
          ),
    );
  }
}
