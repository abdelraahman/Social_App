import 'package:flutter/material.dart';
import 'package:socail_app/constant.dart';

class SearchScrren extends StatelessWidget {
  //const SearchScrren({Key? key}) : super(key: key);

  var postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Card(
        elevation: 10.0,
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/woman-doctor-wearing-lab-coat-with-stethoscope-isolated_1303-29791.jpg?w=996&t=st=1670167098~exp=1670167698~hmac=1ec3c7191303321804db44ccd15fba3fab0b7f80de9ef9d4de572d66e0bf6a7e',
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  Text('Abdelrahman Ayman'),
                  Spacer(),
                  TextButton(
                      onPressed: (){},
                      child: Text('POST',
                      style: TextStyle(
                        color: orange,
                      ),),
                  ),
          ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: postController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "What Is On Your Mind.....!",
                    border:InputBorder.none,
                  ),
                  validator: (value) {
                    if(value != null && value.isEmpty)
                      return "Post Cant Be Empty";
                    else return null;
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
