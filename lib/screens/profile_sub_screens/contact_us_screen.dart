import 'package:attach/api/bankpai/other_api.dart';
import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final fromKey = GlobalKey<FormState>();

  // ✅ TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // ✅ Send Data Function
   sendData() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final message = messageController.text.trim();

     await OtherApi().contactUs(context,
        name: name,
        email: email,
        phone: phone,
        message: message,
         onDone: () {
           MyHelper.snakeBar(
             context,
             title: "Contact Updated",
             message: "Our Team will Contact You Soon",
           );


           Navigator.pop(context);

         }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Contact Us"),
      ),
      body: Form(
        key: fromKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 23, vertical: 20),
          children: [
            Text(
              "Get in Touch",
              style: Const.font_900_20(context, size: SC.from_width(27)),
            ),
            Text(
              "24/7 we will answer your questions and problems",
              style: Const.font_400_16(
                context,
                size: SC.from_width(14),
                color: Const.grey_190_190_190,
              ),
            ),
            SizedBox(height: SC.from_width(25)),

            // ✅ Name
            CustomTextField(
              controller: nameController,
              label: 'Name',
              validator: (d){
                if(d!.isEmpty)
                  {
                    return 'Enter Your Name';
                  }
              },
              hintText: 'Enter name',
            ),
            SizedBox(height: SC.from_width(15)),

            // ✅ Email
            CustomTextField(
              controller: emailController,
              label: 'Email id',
              hintText: 'Enter email',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Email is required';
                }
                final gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
                if (!gmailRegex.hasMatch(value.trim())) {
                  return 'Please enter a valid Gmail address';
                }
                return null;
              },
            ),
            SizedBox(height: SC.from_width(15)),

            // ✅ Phone Number
            CustomTextField(
              controller: phoneController,
              label: 'Phone number',
              hintText: 'Enter phone number',
              keyTyp: TextInputType.number,
              validator: (d){
                if(d!.isEmpty||d.length<10)
                  {
                    return 'Enter Vaileda';
                  }
              },
              formatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            SizedBox(height: SC.from_width(15)),

            // ✅ Message
            CustomTextField(
              controller: messageController,
              maxLine: 4,
              label: 'Message',
              hintText: 'Describe your issue ',
              validator: (d){
                if(d!.isEmpty)
                  {
                    return 'Explain Your Query';
                  }
              },
            ),
            SizedBox(height: SC.from_width(60)),

            SizedBox(
              height: SC.from_width(48),
              child: CustomActionButton(
                action: () async {
                  if (fromKey.currentState!.validate()) {
                     await sendData(); // ✅ Only call if form is valid
                  }
                },
                lable: 'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

