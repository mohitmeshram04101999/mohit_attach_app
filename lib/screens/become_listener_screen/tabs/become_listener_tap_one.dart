import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custom_check_box.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class BecomeListenerTapOne extends StatelessWidget {
  final PageController pageController;
  const BecomeListenerTapOne({required this.pageController,super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 14, right: 14, bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Const.primeColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Text(
              "Your Experience & Preferences",
              style: Const.font_500_18(context, size: SC.from_width(20)),
            ),

            SizedBox(height: SC.from_width(12)),

            Text(
              "Do you have prior experience in providing emotional support?",
              style: Const.font_400_14(context),
            ),

            Row(
              children: [
                CustomCheckBox(value: true, onChange: (d) {}),
                Text("Yes", style: Const.font_500_16(context)),
              ],
            ),

            Row(
              children: [
                CustomCheckBox(value: false, onChange: (d) {}),
                Text("No", style: Const.font_500_16(context)),
              ],
            ),
            SizedBox(height: SC.from_width(16)),

            //
            Text(
              "If yes, please describe your experience (e.g., counseling, teaching, volunteering, experience from other apps etc.",
              style: Const.font_400_14(context, color: Const.grey_190_190_190),
            ),
            SizedBox(height: SC.from_width(8)),
            CustomTextField(hintText: 'Please Describe Here ', maxLine: 4),
            SizedBox(height: 30),

            //
            CustomTextField(
              label: 'Highest Qualification',
              hintText: 'Write your qualification here',
              maxLine: 4,
            ),
            SizedBox(height: 30),

            //
            Text(
              "Have you done any counseling or mental health related course?",
              style: Const.font_400_14(context),
            ),

            Row(
              children: [
                CustomCheckBox(value: true, onChange: (d) {}),
                Text("Yes", style: Const.font_500_16(context)),
              ],
            ),

            Row(
              children: [
                CustomCheckBox(value: false, onChange: (d) {}),
                Text("No", style: Const.font_500_16(context)),
              ],
            ),
            SizedBox(height: SC.from_width(16)),

            Text(
              "If yes, mention course name and upload certificate",
              style: Const.font_400_14(context, color: Const.grey_190_190_190),
            ),
            SizedBox(height: 8),

            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                showModalBottomSheet(
                  barrierColor: Colors.white.withOpacity(.5),
                  context: context,
                  builder: (p0) => _uploadDocDialog(context),
                );
              },
              child: DottedBorder(
                color: Colors.white,
                borderType: BorderType.RRect,
                dashPattern: [5, 5],
                radius: Radius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.file_upload_outlined, color: Const.grey_190_190_190),
                      const SizedBox(width: 8),
                      Text(
                        "certificate upload",
                        style: Const.font_400_14(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),

            SizedBox(
              height: SC.from_width(49),
              child: CustomActionButton(
                action: () {
                  pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                },
                lable: 'Save and Continue',
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

Widget _uploadDocDialog(BuildContext context) {
  return SizedBox(
    // height: SC.from_width(222),
    child: Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: SC.from_width(40),
          right: SC.from_width(40),
          bottom: SC.from_width(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            SizedBox(height: 20),
            Container(
              width: SC.from_width(69),
              height: SC.from_width(5),
              decoration: BoxDecoration(
                color: Const.grey_190_190_190,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: SC.from_width(34)),

            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Const.yellow,
                child: Icon(Icons.camera_alt, color: Colors.white),
              ),
              title: Text("Camera", style: Const.font_500_16(context)),
            ),
            Divider(
              height: .3,
              color: Const.grey_190_190_190.withOpacity(.2),
            ),

            //
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () {},
              leading: CircleAvatar(
                backgroundColor: Const.yellow,
                child: Icon(Icons.photo_library, color: Colors.white),
              ),
              title: Text("Gallery", style: Const.font_500_16(context)),
            ),
            Divider(
              height: .3,
              color: Const.grey_190_190_190.withOpacity(.2),
            ),

            //
            ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () {
              },
              leading: CircleAvatar(
                backgroundColor: Const.yellow,
                child: Icon(Icons.picture_as_pdf, color: Colors.white),
              ),
              title: Text("PDF", style: Const.font_500_16(context)),
            ),

          ],
        ),
      ),
    ),
  );
}
