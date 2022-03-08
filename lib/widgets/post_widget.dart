import 'package:flutter/material.dart';
import 'package:news_app/screens/web_view_screen.dart';

class PostWidget extends StatelessWidget {

  final List data;
  final int index;


  PostWidget(
   {
      required this.data,
     required this.index,
   }
 );

  @override
  Widget build(BuildContext context) {
    String imageUrl = data[index]['urlToImage'] ?? 'Unknown';
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              child: Card(
                elevation: 0.0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: imageUrl == 'Unknown' ?Container(
                  color: Colors.blue,
                ):Image.network(imageUrl, fit: BoxFit.cover,),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data[index]['title']?? 'Unknown',
                    style: Theme.of(context).textTheme.headline1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    data[index]['author']?? 'Unknown',
                    style:  Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    data[index]['description']?? 'Unknown',
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 30,
                    child: Row(
                        children: [
                          Text(
                            data[index]['source']['name']?? 'Unknown',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              data[index]['publishedAt']?? 'Unknown',
                              style: Theme.of(context).textTheme.headline3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WebviewScreen(url: data[index]['url']),
          ),
        );
      },
    );
  }
}
