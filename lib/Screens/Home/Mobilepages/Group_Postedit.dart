import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forum3/Services/Firestoremethods.dart';
import 'package:forum3/shared/Pop_up.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../Models/Users1.dart';
import '../../../Provider/user_provider.dart';
import '../../../Services/Upload.dart';

//TODO: implement theme
class Geditpost extends StatefulWidget {
  final snap;
  final groupid;
  const Geditpost({Key? key,this.snap,this.groupid}) : super(key: key);

  @override
  State<Geditpost> createState() => _GeditpostState();
}

class _GeditpostState extends State<Geditpost> {
  dynamic _image;
  Upload Selection=Upload();
  final TextEditingController _title=TextEditingController();
  final TextEditingController _detail=TextEditingController();
  bool _isloading=false;
  bool memorypost=false;

  @override
  void initState() {
_image=widget.snap['Image Url'];
_title.text=widget.snap['title'];
_detail.text=widget.snap['detail'];
    super.initState();
  }
  Widget Avatar(User1 user1){
    try{
      return CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(user1.ppurl!),
      );
    }catch(e){
      return const CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage('Assets/hac.jpg'),
      );
    }
  }

  Widget Post(){
    if(memorypost){
      return _image!=null? SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        child: Image.memory(_image),
      ):const SizedBox();
    }else{
    return _image==null || _image==""?SizedBox():SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      child:Image.network(_image),
    );}
  }

  _selectimage(BuildContext context)async{

    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: const Text("Create Post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(15.0),
                child: const Text("Take a Photo"),
                onPressed: ()async{
                  Navigator.of(context).pop();
                  dynamic file=await Selection.uploadpic(ImageSource.camera);
                  setState(() {
                    _image=file;
                    memorypost=true;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(15.0),
                child: Text("Choose from gallery"),
                onPressed: ()async{
                  Navigator.of(context).pop();
                  dynamic file=await Selection.uploadpic(ImageSource.gallery);
                  setState(() {
                    _image=file;
                    memorypost=true;

                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(15.0),
                child: Text("Cancel"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );

  }



  @override
  void dispose() {
    _title.dispose();
    _detail.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    late  User1 user1=  Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme:const IconThemeData(
          color: Colors.white,
        ),
        title:const Text(
          "Edit Post",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _isloading? const LinearProgressIndicator():Container(),
               const SizedBox(height: 10,),
                Card(
                  color:Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Avatar(user1),
                            SizedBox(width: 15,),
                            Text(
                              user1.Username!,
                            style:const TextStyle(
                            color:Colors.white
                            ),
                            ),
                          ],
                        ),
                       const SizedBox(height: 15,),
                        TextField(
                          controller: _title,
                          decoration: const InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            label: Text(
                              "Title",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          style:const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                       const SizedBox(height: 10,),
                        SingleChildScrollView(
                          child: TextField(
                            controller: _detail,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              hintText: "Write Something.....",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              label: Text(
                                "Detail",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ),
                            style:const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Post(),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: ()=>_selectimage(context),
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                              setState(() {
                                _image=null;
                              });
                            },
                                icon: const Icon(
                                Icons.remove_circle,
                                color:Colors.white
                            )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: ()async{
          String ress=await FirestoreMethods().EditGroupPost(widget.groupid,widget.snap['Post Uid'], _title.text, _detail.text, _image, memorypost);
         await Showsnackbar(ress, context);
          Navigator.of(context).pop();
        },
        child: const FaIcon(
            FontAwesomeIcons.pencil
        ),
      ),
    );
  }
}











