import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class WellDonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: CachedNetworkImage(imageUrl: "https://c.imge.to/2019/12/07/vwTBnW.png",width: 300,height: 100,)
    ));
  }
}
