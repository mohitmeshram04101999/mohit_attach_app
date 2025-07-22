import 'package:attach/api/bankpai/mediaApi.dart';
import 'package:attach/componant/coustom_text_field.dart';
import 'package:attach/componant/custom_check_box.dart';
import 'package:attach/const/app_constante.dart';
import 'package:attach/modles/question_for_listener_model.dart';
import 'package:attach/myfile/screen_dimension.dart';
import 'package:attach/noticiation/notificationService.dart';
import 'package:attach/providers/become_listener_provider.dart';
import 'package:attach/providers/my_hleper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;



class QuestionWidget extends StatefulWidget {
  final QuestionForListener question ;
  final void Function()? onAddFile;
  final void Function()? onUploadDone;
  const QuestionWidget({this.onUploadDone,this.onAddFile,required this.question,super.key});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {







  String? _boolAnswer;
  String? _sortAnswer;
  List<String> _multipleChooseAnswer= [];
  List<String> _multiMediaAnswer= [];
  String? _singleMediaAnswer;
  bool _multiMedia = false;

  double uploadProgressForSingleMedia = 0;
  String uploadProgressMultiMedia = '';


  bool uploading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //[MEDIA_TYPE, BOOLEAN_OPTION, SORT_QUESTION, LONG_QUESTION, MULTIPLE_CHOOSE_OPTION]

    var p = Provider.of<BecomeListenerProvider>(context,listen: false);
    if(widget.question.questionType=='BOOLEAN_OPTION')
      {
        if(p.answer[widget.question.id]!=null) {
          _boolAnswer = p.answer[widget.question.id.toString()]?.booleanAnswer;
        }
      }
    if(widget.question.questionType=='SORT_QUESTION'||widget.question.questionType=='LONG_QUESTION')
      {
        if(p.answer[widget.question.id]!=null) {
          _sortAnswer = p.answer[widget.question.id.toString()]?.sortAnswer;
        }

      }
    if(widget.question.questionType=='MULTIPLE_CHOOSE_OPTION')
      {
        if(p.answer[widget.question.id]!=null) {
          _multipleChooseAnswer = p.answer[widget.question.id.toString()]?.multipleChooseAnswer??[];
        }
        else
          {
            p.addAnswer(AnswerModel(id: widget.question.id.toString(), question: widget.question.question??'', questionType: widget.question.questionType??'', multipleChooseAnswer: _multipleChooseAnswer));
          }

      }
    if(widget.question.questionType=='MEDIA_TYPE')
      {
        _multiMedia = (widget.question.mediaCount??0)>1;
        if(_multiMedia)
          {
            if(p.answer[widget.question.id]!=null) {
              _multiMediaAnswer = p.answer[widget.question.id.toString()]?.multipleMediaAnswer??[];
            }
          }
        else
          {
            if(p.answer[widget.question.id]!=null) {
              _singleMediaAnswer = p.answer[widget.question.id.toString()]?.mediaAnswer;
            }
          }

      }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<BecomeListenerProvider>(
      builder: (context, p, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          if(kDebugMode)Text("${widget.question.questionType}"),
          GestureDetector(
            onLongPress: (){
              if(kDebugMode){
                showDialog(
                  context: context,
                  builder: (ctx){
                    return AlertDialog(
                      title: Text(widget.question.id.toString()),
                      content: Text(widget.question.toJson().toString()),
                    );
                  }
                );
              }
            },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${widget.question.question}',style: Const.font_500_16(context),),
                    if(widget.question.required==true)
                      TextSpan(text: ' *',style: Const.font_500_16(context,color: Colors.red),),
                  ],
                ),
              ),
          ),

          SizedBox(height: SC.from_width(8),),


          if(widget.question.questionType=='MULTIPLE_CHOOSE_OPTION')
            Column(
              children: [

                for(String option in widget.question.options??[])
                  Row(
                    children: [
                      CustomCheckBox(value: _multipleChooseAnswer.contains(option), onChange: (d) {
                        if(d)
                          {
                            _multipleChooseAnswer.add(option);
                          }

                        else
                          {
                            _multipleChooseAnswer.remove(option);
                          }

                        p.addAnswer(
                            AnswerModel(
                              id: widget.question.id??"",
                              question: widget.question.question??'',
                              questionType: widget.question.questionType??'',
                              multipleChooseAnswer: _multipleChooseAnswer,
                            )
                        );

                        setState(() {
                        });
                      }),
                      Text("${option}", style: Const.font_500_16(context)),
                    ],
                  ),

              ],
            ),



          if(widget.question.questionType=='LONG_QUESTION')
            CustomTextField(
              initialValue: _sortAnswer,
              onChange: (d){
                p.addAnswer(
                    AnswerModel(
                      id: widget.question.id??"",
                      question: widget.question.question??'',
                      questionType: widget.question.questionType??'',
                      sortAnswer: d,
                    )
                );
              },
              maxLine: 4,
              hintText: 'Describe here...',
            ),

          if(widget.question.questionType=='SORT_QUESTION')
            CustomTextField(
              initialValue: _sortAnswer,
              onChange: (d){
                p.addAnswer(
                  AnswerModel(
                      id: widget.question.id??"",
                      question: widget.question.question??'',
                      questionType: widget.question.questionType??'',
                    sortAnswer: d,
                  )
                );
              },
              maxLine: 1,
              hintText: 'Write your answer',
            ),


          if(widget.question.questionType=='BOOLEAN_OPTION')
            Column(
              children: [
                Row(
                  children: [
                    CustomCheckBox(value: _boolAnswer=='yes', onChange: (d) {
                      _boolAnswer = 'yes';
                      p.addAnswer(
                          AnswerModel(
                            id: widget.question.id??"",
                            question: widget.question.question??'',
                            questionType: widget.question.questionType??'',
                            booleanAnswer: 'yes',
                          )
                      );
                      setState(() {

                      });
                    }),
                    Text("Yes", style: Const.font_500_16(context)),
                  ],
                ),

                Row(
                  children: [
                    CustomCheckBox(
                        value: _boolAnswer=='no', onChange: (d) {
                           _boolAnswer = 'no';
                      p.addAnswer(
                          AnswerModel(
                            id: widget.question.id??"",
                            question: widget.question.question??'',
                            questionType: widget.question.questionType??'',
                            booleanAnswer: 'no',
                          )
                      );
                      setState(() {});
                    }),
                    Text("No", style: Const.font_500_16(context)),
                  ],
                ),

              ],
            ),


          if(widget.question.questionType=='MEDIA_TYPE')
            if(_multiMedia)...[
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                children: [
                  for(String url in _multiMediaAnswer??[])
                    _mediaView(url),

                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async{

                      if(uploading)return;

                      uploading = true;

                      List<String>? filePAth = await showModalBottomSheet(
                        barrierColor: Colors.white.withOpacity(.5),
                        context: context,
                        builder: (p0) {
                          print(widget.question.mediaArray);
                          return _uploadDocDialog(context,multiMedia: _multiMedia,type: widget.question.mediaArray??[]);
                        },
                      );
                      print(filePAth);

                      if(filePAth!=null&&filePAth.isNotEmpty)
                        {
                          if(widget.onAddFile!=null)widget.onAddFile!();
                          for(String path in filePAth)
                            {
                              var resp = await MediaApi().sendMediaInMessage(path,(d){
                                setState(() {
                                  uploadProgressMultiMedia = '${path.split('/').last}${(d*100).toInt()}%';
                                });
                              });

                              String? url = MyHelper().handleResponse(context,resp);
                              if(url!=null)
                                {
                                  _multiMediaAnswer.add(url);
                                }

                              print('resp = ${resp.body}');
                            }


                          p.addAnswer(
                              AnswerModel(
                                id: widget.question.id??"",
                                question: widget.question.question??'',
                                questionType: widget.question.questionType??'',
                                multipleMediaAnswer: _multiMediaAnswer,
                              )
                          );
                          uploadProgressMultiMedia = '';
                          if(widget.onUploadDone!=null)widget.onUploadDone!();
                        }

                      uploading =  false;
                      setState(() {

                      });


                    },
                    child: DottedBorder(
                      color: Colors.white,
                      borderType: BorderType.RRect,
                      dashPattern: [5, 5],
                      radius: Radius.circular(8),
                      child: Padding(
                        // padding: const EdgeInsets.symmetric(vertical: 22),
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.file_upload_outlined, color: Const.grey_190_190_190),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  (uploadProgressMultiMedia.isNotEmpty)
                                  ?uploadProgressMultiMedia:
                                  "Add File${kDebugMode?'${widget.question.mediaCount}':''}",
                                  style: Const.font_400_14(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]
          else...[

            if(kDebugMode)
              Text('${_singleMediaAnswer}'),

              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async{

                  if(uploading)return;
                  uploading = true;



                   List<String>? filePAth = await showModalBottomSheet(
                    barrierColor: Colors.white.withOpacity(.5),
                    context: context,
                    builder: (p0) {
                      print(widget.question.mediaArray);
                      return _uploadDocDialog(context,multiMedia: _multiMedia,type: widget.question.mediaArray??[]);
                    },
                  );
                  print(filePAth);

                   if(filePAth!=null&&filePAth.isNotEmpty)
                     {
                       if(widget.onAddFile!=null)widget.onAddFile!();



                       http.Response resp = await MediaApi().sendMediaInMessage(filePAth[0], (d) {
                         uploadProgressForSingleMedia = d * 100;
                         setState(() {
                         });
                       });


                       uploadProgressForSingleMedia = 0;


                       String? mediaUrl = MyHelper().handleResponse(context, resp);

                       _singleMediaAnswer = mediaUrl;

                      if(_singleMediaAnswer!=null)
                        {
                          p.addAnswer(
                              AnswerModel(
                                id: widget.question.id??"",
                                question: widget.question.question??'',
                                questionType: widget.question.questionType??'',
                                mediaAnswer: _singleMediaAnswer,
                              )
                          );
                        }
                       setState(() {});
                      if(widget.onUploadDone!=null)widget.onUploadDone!();
                     }

                   uploading =  false;


                },
                child: DottedBorder(
                  color: Colors.white,
                  borderType: BorderType.RRect,
                  dashPattern: [5, 5],
                  radius: Radius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22),
                    // padding: const EdgeInsets.symmetric(vertical: 0),
                    child:(_singleMediaAnswer!=null&&uploadProgressForSingleMedia==0)
                        ? _mediaView(_singleMediaAnswer??'')
                        : Center(
                          child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                          Icon(Icons.file_upload_outlined, color: Const.grey_190_190_190),
                          const SizedBox(width: 8),
                          Text(
                            "Upload File${kDebugMode?'${widget.question.mediaCount}':''}${(uploadProgressForSingleMedia>0)?'(${uploadProgressForSingleMedia.toInt()}%)':''}",
                            style: Const.font_400_14(context),
                          ),
                                                  ],
                                                ),
                        ),
                  ),
                ),
              ),
            ],
          SizedBox(height: SC.from_width(20),)
        ],
      ),
    );
  }
}




Widget _uploadDocDialog(BuildContext context,{bool multiMedia=false,List<String> type =const  []}) {


  List<String> _allowedImageTypes = ['jpg','png','jpeg'];
  List<String> _allowedVideoTypes = ['mp4','avi','mov'];


  List<String> _allowedTypes = [];


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
            if(kDebugMode)
              ...[
                Text("${type}",style: Const.font_500_16(context),),
              ],

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

           if(type.contains("AUDIO_CAMERA"))...[
             ListTile(
               contentPadding: EdgeInsets.zero,
               onTap: () async {
                 var image = await ImagePicker().pickImage(source: ImageSource.camera);
                 if (image != null) {
                   Navigator.pop(context, [image.path]);
                 }
                 else
                   {
                     Navigator.pop(context);
                   }
               },
               leading: CircleAvatar(
                 backgroundColor: Const.yellow,
                 child: Icon(Icons.camera_alt, color: Colors.white),
               ),
               title: Text("Image Camera", style: Const.font_500_16(context)),
             ),
             Divider(
               height: .3,
               color: Const.grey_190_190_190.withOpacity(.2),
             ),
           ],

            if(type.contains("VIDEO_CAMERA"))...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () async {
                  var image = await ImagePicker().pickVideo(source: ImageSource.camera);
                  if (image != null) {
                    Navigator.pop(context, [image.path]);
                  }
                  else
                  {
                    Navigator.pop(context);
                  }
                },
                leading: CircleAvatar(
                  backgroundColor: Const.yellow,
                  child: Icon(Icons.video_camera_back, color: Colors.white),
                ),
                title: Text("Video Camera", style: Const.font_500_16(context)),
              ),
              Divider(
                height: .3,
                color: Const.grey_190_190_190.withOpacity(.2),
              ),
            ],

            //
           if(type.contains("IMAGE"))...[
             ListTile(
               contentPadding: EdgeInsets.zero,
               onTap: () async{
                 //---------------------------------------------------------------------------------------

                 FilePickerResult? file  = await FilePicker.platform.pickFiles(
                     allowMultiple:multiMedia,
                     type: (type.isNotEmpty)?FileType.custom:FileType.any,
                     allowedExtensions:[ 'jpg', 'png', 'jpeg']
                 );


                 if(file==null)
                   {
                     Navigator.pop(context);
                   }
                 else
                   {
                     if(file.files.isNotEmpty)
                       {
                         Navigator.pop<List<String>>(context,file.files.map((e) => e.path.toString(),).toList());
                       }
                   }
                 // Navigator.pop(context,file);


                 //---------------------------------------------------------------------------------------


               },
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
           ],

           //
           if(type.contains("AUDIO"))...[
             ListTile(
               contentPadding: EdgeInsets.zero,
               onTap: () async{
                 //---------------------------------------------------------------------------------------

                 FilePickerResult? file  = await FilePicker.platform.pickFiles(
                     allowMultiple:multiMedia,
                     type: FileType.audio,

                 );


                 if(file==null)
                   {
                     Navigator.pop(context);
                   }
                 else
                   {
                     if(file.files.isNotEmpty)
                       {
                         Navigator.pop<List<String>>(context,file.files.map((e) => e.path.toString(),).toList());
                       }
                   }
                 // Navigator.pop(context,file);


                 //---------------------------------------------------------------------------------------


               },
               leading: CircleAvatar(
                 backgroundColor: Const.yellow,
                 child: Icon(Icons.audiotrack, color: Colors.white),
               ),
               title: Text("Audio", style: Const.font_500_16(context)),
             ),
             Divider(
               height: .3,
               color: Const.grey_190_190_190.withOpacity(.2),
             ),
           ],


           //
           if(type.contains("VIDEO"))...[
             ListTile(
               contentPadding: EdgeInsets.zero,
               onTap: () async{
                 //---------------------------------------------------------------------------------------

                 FilePickerResult? file  = await FilePicker.platform.pickFiles(
                     allowMultiple:multiMedia,
                     type: FileType.video,

                 );


                 if(file==null)
                   {
                     Navigator.pop(context);
                   }
                 else
                   {
                     if(file.files.isNotEmpty)
                       {
                         Navigator.pop<List<String>>(context,file.files.map((e) => e.path.toString(),).toList());
                       }
                   }
                 // Navigator.pop(context,file);


                 //---------------------------------------------------------------------------------------


               },
               leading: CircleAvatar(
                 backgroundColor: Const.yellow,
                 child: Icon(Icons.videocam_rounded, color: Colors.white),
               ),
               title: Text("Video", style: Const.font_500_16(context)),
             ),
             Divider(
               height: .3,
               color: Const.grey_190_190_190.withOpacity(.2),
             ),
           ],


            //
            if(type.contains("PDF")||type.contains("CV"))...[


              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () async{
                  FilePickerResult? file  = await FilePicker.platform.pickFiles(
                      allowMultiple:multiMedia,
                      type: (type.isNotEmpty)?FileType.custom:FileType.any,
                      allowedExtensions:['pdf']
                  );

                  if(file==null)
                    {
                      Navigator.pop(context);
                    }
                  else
                    {
                      if(file.files.isNotEmpty)
                        {
                          Navigator.pop<List<String>>(context,file.files.map((e) => e.path.toString(),).toList());
                        }
                    }


                },
                leading: CircleAvatar(
                  backgroundColor: Const.yellow,
                  child: Icon(Icons.picture_as_pdf, color: Colors.white),
                ),
                title: Text("PDF", style: Const.font_500_16(context)),
              )
            ],

          ],
        ),
      ),
    ),
  );
}

Widget _mediaView(String url)
{
  if(url.isImageFileName)
    {
      return AspectRatio(
        aspectRatio: 2,
          child: Image.network(url,fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported_outlined),));
    }
  else if(url.isVideoFileName)
    {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Video : ${url.split("/").last.replaceAll("%20", ' ')}'),
      );
    }
  else if(url.contains("pdf"))
    {
      return SizedBox(
        width: double.infinity,
          child: Center(child: Text(url.split("/").last.replaceAll("%20", ' '))));
    }
  else
    {
      return Text("File not supported");
    } 
}




