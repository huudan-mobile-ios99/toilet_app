import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toilet_client_web_v2/api/my_api_service.dart';
import 'package:toilet_client_web_v2/getx/my_getx_controller.dart';
import 'package:toilet_client_web_v2/utils/button_close.dart';
import 'package:toilet_client_web_v2/utils/button_deboucer.dart';
import 'package:toilet_client_web_v2/utils/dialog_sucess.dart';
import 'package:toilet_client_web_v2/utils/dialog_waiting.dart';
import 'package:toilet_client_web_v2/utils/function.dart';
import 'package:toilet_client_web_v2/utils/mycolors.dart';
import 'package:toilet_client_web_v2/utils/padding.dart';
import 'package:toilet_client_web_v2/utils/text.dart';
import 'package:toilet_client_web_v2/widget/button.dart';
import 'package:toilet_client_web_v2/widget/custom_snackbar.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  final controller_getx = Get.put(MyGetXController());
  final MyAPIService service_api = MyAPIService();
  bool isShowDialog = false;
  final _debouncer = Debouncer(milliseconds: 500, delay: const Duration(milliseconds: 500));

  @override
  void initState() {
    controller_getx.startCountdown(() {
      print('count down finished! - INIT ');
      createFBAPIs(context: context, controller: controller_getx);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  createFBAPIs({MyGetXController? controller, context, VoidCallback? function}) {
    final serviceApi = MyAPIService();
    try {
      serviceApi.createFeedBack(
      driver: 'USER',
      star: controller!.starCount.value,
      content: 'FEEDBACK FROM USER',
      experience: removeDuplicates(controller.selectedItemNames.value),
    ).then((value) {
      if (value['status'] == true) {
        // customSnackBar(context: context, message: value['message']);
        print('show success dialog');
        setState(() {
          isShowDialog = true;
        });
        isShowDialog == false
            ? showDialogWaiting(context: context, dismissDuration: const Duration(seconds: 5))
            : showDialogSucess(context: context, dismissDuration: const Duration(seconds: 2));
        function!();
        controller.resetForm();
      } else if (value == null || value.isBlank) {
        print('value is blank');
        function!();
        controller.resetForm();
      }
    }).whenComplete(() {
      serviceApi.sendNotification(
          registrationToken:"dYJY5dTjE0Ujg1t6vVvjNT:APA91bHiFJaOHpmmQ1-QJWnj1vZUHlep1DAqvpOvBwTsG-Iv_A2dpS44U8Y5gASgqLTbw-HgWNviVjnLuWdVa5JXM_JFEK3LoOegJRnICg5sG8NRe-xTf5omGkNgwKaVUCJLfcr8MXs6",
          title: 'New feedback has arrived',
          body: getRandomString(),
          // body: 'Kindly review and process the feedback. Thank you 👉👌',
          star: '${controller.starCount.value}' ?? 0,
          feedback: removeDuplicates(controller.selectedItemNames.value));
      // when complete then create notification
      controller.resetForm();
    });
    } catch (e) {
       controller!.resetForm();
       customSnackBar(context: context, message: 'Can not send your feedback $e');

    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
              //gridview builder
              Container(
                height: height * .475,
                width: width * .825,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PaddingDefault.padding16),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(PaddingDefault.padding24),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // 2 columns
                      crossAxisSpacing: PaddingDefault.pading12,
                      mainAxisSpacing: PaddingDefault.pading12,
                      childAspectRatio: 1.215),
                  itemCount: controller_getx.items.length,
                  itemBuilder: (context, index) {
                    // var item = controller_getx.items[index];
                    return GestureDetector(
                        onTap: () {
                          print('ontap $index ${controller_getx.items[index].name} ${controller_getx.items[index].isSelect} ');
                          controller_getx.toggleSelection(
                              index: index,
                              function: () {
                                print('reach 0 - reset count down  = 0 ');
                                createFBAPIs(
                                    function: () {
                                      print('function button submit evoke');
                                    },
                                    context: context,
                                    controller: controller_getx);
                              });
                        },
                        child: Column(
                          children: [
                            Obx(
                              () => Container(
                                padding: const EdgeInsets.all(
                                    PaddingDefault.padding24),
                                decoration: BoxDecoration(
                                    color:
                                        controller_getx.items[index].isSelect ==
                                                true
                                            ? MyColor.greenBG2
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                        PaddingDefault.padding24),
                                    border: Border.all(
                                        color: controller_getx.items[index].isSelect ==
                                                true
                                            ? MyColor.yellowBG3
                                            : MyColor.black_text,
                                        width: controller_getx
                                                    .items[index].isSelect ==
                                                true
                                            ? 3.5
                                            : 1)),
                                child: Container(
                                  height: 100.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(controller_getx.items[index].image),
                                          fit: BoxFit.contain,
                                          filterQuality: FilterQuality.high)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: PaddingDefault.padding04,
                            ),
                            text_custom(
                                text: controller_getx.items[index].name,
                                size: TextSizeDefault.text18,
                                weight: FontWeight.w500)
                          ],
                        ));
                  },
                ),
              ),
              const SizedBox(
                height: PaddingDefault.pading08,
              ),
              GetBuilder<MyGetXController>(
                builder: (controller) {
                  return button(
                      onPressed: () {
                        // showLoaderDialog(context) : null;
                        _debouncer.run(() => print('text'));
                        //     print('click  submit ! ') ;
                        print('content SS: ${controller.selectedItemNames.value.toString()}');
                        print('star SS: ${controller.starCount.value}');
                        print('selected items SS: ${controller.selectedItemNames.value}');
                        try {
                          createFBAPIs(
                              context: context,
                              controller: controller,
                              function: () {
                                print('function button submit evoke');
                              });
                        } catch (e) {
                          print(e);
                        }
                      },
                      text: "SUBMIT");
                },
              ),
              const SizedBox(
                height: PaddingDefault.pading12,
              ),
              Obx(() => text_custom(
                  text:'Auto submit after ${controller_getx.count.value} seconds without action',
                  size: TextSizeDefault.text18,
                  color: MyColor.black_text,
                  weight: FontWeight.w300))
            ],
          ),
        ),

        //ICON CLOSE
        Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                print('close');
                controller_getx.resetForm();
              },
              child: buttonClose()
            )),
      ],
    );
  }
}

List<String> removeDuplicates(List<String> inputList) {
  Set<String> uniqueItems = Set<String>.from(inputList);
  return List<String>.from(uniqueItems);
}
