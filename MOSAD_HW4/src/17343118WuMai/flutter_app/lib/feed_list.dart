import 'package:flutter/material.dart';
import 'package:flutter_app/feed_detail.dart';

class EveryCell extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        //padding: EdgeInsets.all(10.0),
        //margin: EdgeInsets.only(top: 10.0),
        margin: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: Wrap(    //流式布局
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            //上方头像
            Container(
              width: 50.0,
              height: 50.0,
              margin: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                        "resources/dog.jpeg"
                  ),
                ),
              ),
            ),

            //昵称
            Container(
              width: MediaQuery.of(context).size.width - 80.0,
              height: 50.0,
              alignment: Alignment.centerLeft,
              child: Text("Andrew",
                style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                ),
              ),
            ),

            //图片
            Container(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return DetailContent();
                      }));
                },
                child: (
                    Image.asset("resources/timg.jpeg")
                ),
              ),
            ),

            //左下图标
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              margin: EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    disabledColor: Colors.black,
                  ),
                  IconButton(
                    icon: Icon(Icons.crop_3_2),
                    disabledColor: Colors.black,
                  ),
                ],
              ),
            ),

            //下方头像
            Container(
              width: 50.0,
              height: 50.0,
              margin: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                      "resources/dog.jpeg"
                  ),
                ),
              ),
            ),

            //留言框
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width - 80.0,
              alignment: Alignment.centerLeft,
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Add a comment...',//提示词
                    border: InputBorder.none,//删去下划线
                ),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        )
    );
  }
}