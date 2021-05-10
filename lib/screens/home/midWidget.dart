import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwazaf_app/style/sizes.dart';

class MidWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) searchFilter;
  MidWidget({this.searchFilter});
  @override
  _MidWidgetState createState() => _MidWidgetState();
}

class _MidWidgetState extends State<MidWidget> {
  bool _openSearch = false;
  String _status = "all";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              setState(() {
                _status = "all";
                _openSearch = false;
              });
              await widget.searchFilter({"status": "all"});
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _status == "all" ? Colors.white : Colors.blue[800],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text(
                  "الكل",
                  style: TextStyle(
                    color: _status == "all" ? Colors.blue[800] : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                _status = "attendance";
                _openSearch = false;
              });
              await widget.searchFilter({"status": "attendance"});
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:
                    _status == "attendance" ? Colors.white : Colors.blue[800],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text(
                  "سجل حضور",
                  style: TextStyle(
                    color: _status == "attendance"
                        ? Colors.blue[800]
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                _status = "delay";
                _openSearch = false;
              });
              await widget.searchFilter({"status": "delay"});
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _status == "delay" ? Colors.white : Colors.blue[800],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text(
                  "تأخير",
                  style: TextStyle(
                    color: _status == "delay" ? Colors.blue[800] : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                _status = "absence";
                _openSearch = false;
              });
              await widget.searchFilter({"status": "absence"});
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _status == "absence" ? Colors.white : Colors.blue[800],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text(
                  "غياب",
                  style: TextStyle(
                    color:
                        _status == "absence" ? Colors.blue[800] : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          _openSearch ? SizedBox() : Spacer(),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _openSearch
                  ? TextFormField(
                      onFieldSubmitted: (v) async {
                        await widget
                            .searchFilter({"name": v, "status": _status});
                      },
                      decoration: InputDecoration(
                          hintText: "ابحث هنا",
                          suffixIcon: IconButton(
                            onPressed: () async {
                              if (mounted)
                                setState(() {
                                  _openSearch = false;
                                });
                              await widget.searchFilter({"status": _status});
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5)),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          _openSearch = true;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 17,
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
