import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MySmartRefresher extends StatefulWidget {
  @required
  final Widget child;
  @required
  final RefreshController refreshController;
  final ScrollController scrollController;
  final Function onLoading;
  final Function onRefresh;
  final String faildText;
  MySmartRefresher(
      {this.child,
      this.faildText,
      this.onLoading,
      this.onRefresh,
      this.refreshController,
      this.scrollController});
  @override
  _StateMySmartRefresher createState() => _StateMySmartRefresher();
}

class _StateMySmartRefresher extends State<MySmartRefresher> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: widget.refreshController,
        scrollController: widget.scrollController,
        enablePullDown: widget.onRefresh != null,
        enablePullUp: widget.onLoading != null,
        onRefresh: widget.onRefresh == null
            ? null
            : () async {
                await widget.onRefresh();
              },
        onLoading: widget.onLoading == null
            ? null
            : () async {
                await widget.onLoading();
              },
        header: BezierCircleHeader(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          canLoadingText: "",
          idleText: "",
          failedText: widget.faildText ?? "",
          loadingText: "",
        ),
        child: widget.child);
  }
}
