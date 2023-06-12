import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../controller/get_campaign_controller.dart';

class MyCampaignCard extends StatefulWidget {
  const MyCampaignCard({Key? key}) : super(key: key);

  @override
  State<MyCampaignCard> createState() => _MyCampaignCardState();
}

class _MyCampaignCardState extends State<MyCampaignCard> {
  final GetCampaignController getCampaignController =
      Get.put(GetCampaignController());

  final dynamic _youTubeVideoUrl = "";
  var _requiredWatchSeconds = 10;

  /*var DataSize = "";*/
  dynamic _viewedByUser = 10;
  var _completedWatchDate = 'opps';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  /*Future<String?> getThumbnailUrl(String videoUrl) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      */ /*thumbnailPath: */ /**/ /*CacheManager().getTemporaryCachePath()*/ /**/ /*,*/ /*
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      quality: 50,
    );

    return thumbnailPath;
  }*/

  ///Data From Api
  Future<void> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic requiredWatchSeconds = prefs.getInt("required_watch_seconds");
    dynamic viewedByUser = prefs.getInt('viewed_by_user');
    String? completedWatchDate = prefs.getString('completed_watch_date');

    setState(() {
      _requiredWatchSeconds = requiredWatchSeconds ?? 10;
      _viewedByUser = viewedByUser ?? 10;
      _completedWatchDate = completedWatchDate ?? 'opps';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          itemCount: getCampaignController.dataList.length,
          itemBuilder: (context, index) {
            final item = getCampaignController.dataList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0 ,vertical: 2),
              child: Card(
                elevation: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 40,
                          height: 80,
                          child: Image.network(_youTubeVideoUrl),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("compete : ${item['completed_watch_date']}"),
                            Text("Watch Second : ${item['required_watch_seconds']}"),
                            Text("${item['viewed_by_user']} View"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
