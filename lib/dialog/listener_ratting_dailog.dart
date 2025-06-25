import 'dart:convert';

import 'package:attach/api/apiPath.dart';
import 'package:attach/api/bankpai/other_api.dart';
import 'package:attach/api/local_db.dart';
import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custome_action_button.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ListenerRatingDialog extends StatefulWidget {
  final String listenerId;
  const ListenerRatingDialog({required this.listenerId, Key? key})
    : super(key: key);

  @override
  State<ListenerRatingDialog> createState() => _ListenerRatingDialogState();
}

class _ListenerRatingDialogState extends State<ListenerRatingDialog> {
  double _selectedRating = 1;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitRating() async {

    if(_selectedRating == 0){
      MyHelper.snakeBar(
        context,
        title: 'Rating',
        message: 'Please Select At Least One Rating',);
    }

    try {
      final response = await OtherApi().rattingListener(
        listenerId: widget.listenerId,
        rating: _selectedRating.toInt(),
        message: _commentController.text.trim(),
      );

      switch (response.statusCode) {
        case 201:
          Navigator.of(context).pop();
          break;

        case 400:
          MyHelper.snakeBar(
            context,
            title: 'Bad Request',
            message: '${jsonDecode(response.body)['message']}',
            type: SnakeBarType.error,
          );
          break;

        case 403:
          break;

        case 401:
          MyHelper.tokenExp(context);
          break;

        case 500:
          MyHelper.serverError(context, response.body);
          break;

        default:
          MyHelper.serverError(
            context,
            '${response.statusCode}\n${response.body}',
            title: 'Exception',
          );
          break;
      }
    } catch (e) {
      MyHelper.snakeBar(
        context,
        title: 'No Internet Connection',
        message: e.toString(),
        type: SnakeBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 30),
      backgroundColor: Const.primeColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFF3D3666),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 24),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Text(
              'Tell Us About Your Experience',
              textAlign: TextAlign.center,
              style: Const.font_700_16(context, size: SC.from_width(20)),
            ),
            const SizedBox(height: 8),
            Text(
              'Your feedback helps improve conversations for everyone.',
              textAlign: TextAlign.center,
              style: Const.font_400_16(context, size: SC.from_width(18)),
            ),
            const SizedBox(height: 16),

            StarRating(
              rating: _selectedRating,
              size: SC.from_width(35),
              color: Const.yellow,
              allowHalfRating: true,
              onRatingChanged: (d) {
                _selectedRating = d;
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(hintText: 'Write a comment.... ', maxLine: 4),
            const SizedBox(height: 16),
            CustomActionButton(action: _submitRating, lable: 'Submit'),
          ],
        ),
      ),
    );
  }
}

// Usage example:
/*
showDialog(
  context: context,
  builder: (context) => ListenerRatingDialog(
    onRatingSubmitted: (rating, comment) {
      // Handle the submitted rating and comment
      print('Rating: $rating, Comment: $comment');
    },
  ),
);
*/
