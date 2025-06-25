import 'package:attach/api/local_db.dart';
import 'package:attach/modles/all_language_responce_model.dart';
import 'package:attach/modles/home_data_responce_model.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/language_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ListenerFilterProvider with ChangeNotifier
{

  bool _init = false;
  io.Socket? _socket;
  List<HomeListener> _listener = [];
  RangeValues? _selectedAgeRange;
  Language? _selectedLanguage;
  final List<RangeValues> _ageRange =const [RangeValues(20, 30),RangeValues(30, 40),RangeValues(40, 50),RangeValues(50, 60),];


  List<HomeListener> get  listener => _listener;
  RangeValues? get selectedRange => _selectedAgeRange;
  Language? get selectedLanguage => _selectedLanguage;
  int _page = 1;
  List<RangeValues> get ageRange =>_ageRange;
  bool get isInit =>_init;

  setAgeRange(RangeValues? range)
  {
    print("range Set");
    _selectedAgeRange = range;
    notifyListeners();
  }

  setSocket(io.Socket s)
  {
    _socket = s;
  }

  init(BuildContext context) async
  {
    _listener = [];
    _socket?.on("filteredListeners", _filterListeners);
    _socket?.on("followAndUnFollowResponse", _followAndUnFollowResponse);
    filter();
    _init = true;
    await Provider.of<LanguageProvider>(context,listen: false).getAllLanguage(context);
  }

  _followAndUnFollowResponse(dynamic data)
  {
    print("followAndUnFollowResponse");
    var _h = HomeListener.fromJson(data['data']);
    Logger().i(_h.toJson());

    int i = _listener.indexWhere((element) => element.id==_h.id,);

    print("change index $i");

    if(i>=0)
      {
        _listener.removeAt(i);
        _listener.insert(i, _h);
        notifyListeners();

      }
  }


  updateFollow(HomeListener d)
  {
    print("update Follow for ${d.id}");
    _socket?.emit("followAndUnFollowListener",{
      "userId":DB.curruntUser?.id??'',
      "listenerId":d.id,
    });
  }

  setLanguage(Language? l)
  {
    _selectedLanguage = l;
    notifyListeners();
  }

  getMore()
  {
    _page++;
    filter();
  }

  refresh()
  {
    _page =1;
    _listener = [];
    filter();
  }

  filter()
  {
    _socket?.emit("filterListeners",{
      'ageMin':_selectedAgeRange?.start,
      'ageMax':_selectedAgeRange?.end,
      'languages':_selectedLanguage?.id,
      'page':_page,
    });

  }

  _filterListeners(dynamic data)
  {
    print("this is from filter lister");
    Logger().i(data);
    List d = data['data'];
    List<HomeListener> _l = d.map((e) => HomeListener.fromJson(e)).toList();
    _listener.addAll(_l);
    notifyListeners();
  }


  clear(BuildContext context) async
  {
    _init =false;
    _listener = [];
    _selectedLanguage = null;
    _selectedAgeRange  = null;
    _page = 1;
    await Provider.of<LanguageProvider>(context,listen: false).clear();
    _stopListen();
  }

  _stopListen()
  {
    _socket?.off("filteredListeners");
  }

  disconnectSocket()
  {
    _socket?.offAny();            // (Optional) Remove all event listeners
    _socket?.destroy();
    if(navigatorKey.currentContext!=null)
      {
        clear(navigatorKey.currentContext!);
      }
  }



}