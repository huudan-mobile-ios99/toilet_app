import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toilet_client_web_v2/api/my_api_service.dart';
import 'package:toilet_client_web_v2/getx/my_getx_controller.dart';
import 'package:toilet_client_web_v2/model/user_model.dart';
import 'package:toilet_client_web_v2/utils/button_close.dart';
import 'package:toilet_client_web_v2/utils/dialog_confirm.dart';
import 'package:toilet_client_web_v2/utils/mycolors.dart';
import 'package:toilet_client_web_v2/utils/padding.dart';
import 'package:toilet_client_web_v2/utils/text.dart';

class DialogCheckList extends StatefulWidget {
  const DialogCheckList({super.key});

  @override
  State<DialogCheckList> createState() => _DialogCheckListState();
}

class _DialogCheckListState extends State<DialogCheckList> {
  final controller_getx = Get.put(MyGetXController());
  final MyAPIService service_api = MyAPIService();
  bool isShowDialog = false;


  @override
  void initState() {
    debugPrint("init dialog checklist");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final double widthItem = width/7;
    final double heightItem = height/7;
    return Stack(
      children: [
        Container(
          width: width * .825,
          height: height * .7,
          decoration: BoxDecoration(
              color: MyColor.white,
              borderRadius: BorderRadius.circular(PaddingDefault.padding32)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: PaddingDefault.padding16,),
              //gridview builder
              Container(
                height: height * .6,
                width: width * .825,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PaddingDefault.padding16),
                ),
                child: SizedBox(
                  child: FutureBuilder(
                    future: service_api.listUsers(),
                    builder: (context, snapshot) {
                      late UserModel model = snapshot.data as UserModel;
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: text_custom(text: "An error orcur"));
                      }

                      return GridView.builder(
                        shrinkWrap: false,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: PaddingDefault.padding24,
                          vertical: PaddingDefault.pading12,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, // 2 columns
                                crossAxisSpacing: PaddingDefault.padding16,
                                mainAxisSpacing: PaddingDefault.padding16,
                                childAspectRatio: 1.25),
                        itemCount: model.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                debugPrint('ontap checklist $index');
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: DialogConfirm(
                                        image_url: model.data[index].imageUrl,
                                        username: model.data[index].username,
                                        usernameEn: model.data[index].usernameEn,
                                        id_user: model.data[index].idUser,
                                        id: model.data[index].id,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(PaddingDefault.padding04),
                                decoration: BoxDecoration(
                                    color: MyColor.bedgeLight,
                                    borderRadius: BorderRadius.circular(PaddingDefault.padding24),
                                    border: Border.all(color: MyColor.grey_tab, width: 1)),
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: widthItem,
                                      width: widthItem,
                                      decoration: BoxDecoration(
                                        color: MyColor.white,
                                        border: Border.all(
                                          color: MyColor.yellow_accent,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(widthItem),
                                        child: CachedNetworkImage(
                                          imageUrl:"${model.data[index].imageUrl}",
                                          placeholder: (context, url) => const SizedBox(
                                              width: PaddingDefault.padding16,
                                              height: PaddingDefault.padding16,
                                              child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error,
                                            color: MyColor.grey_tab,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: SizedBox(
                                        width: widthItem,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(model.data[index].usernameEn!,
                                              style:const TextStyle(fontSize: TextSizeDefault.text18,fontWeight: FontWeight.w600)
                                            ),
                                            Text(model.data[index].username!,
                                              style:const TextStyle(fontSize: TextSizeDefault.text14)
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: PaddingDefault.pading08,
              ),
            ],
          ),
        ),

        //TEXT TITLE
        Positioned(
            left: PaddingDefault.padding16,
            top: PaddingDefault.padding16,
            child: text_custom(
                text: "CHECKLIST FOR STAFF",
                // textSecond: "DANH SÁCH NHÂN VIÊN",
                color: MyColor.black_text,
                weight: FontWeight.w600,
                size: TextSizeDefault.text22)),
        //ICON CLOSE
        Positioned(
            top: -1,
            right: -1,
            child: InkWell(
                onTap: () {
                  debugPrint('close checklist');
                  Navigator.of(context).pop();
                },
                child: buttonClose())),
      ],
    );
  }
}
