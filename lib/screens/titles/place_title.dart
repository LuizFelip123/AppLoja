import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacesTitle extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const PlacesTitle(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100.0,
            child: Image.network(
              documentSnapshot["image"],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  documentSnapshot["title"],
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                Text(
                  documentSnapshot["address"],
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: TextButton(
                  onPressed: () {
                    launchUrl(
                      Uri(
                        scheme: 'https',
                        host: 'www.google.com',
                        path: '/maps/search/',
                        queryParameters: {
                          'api': '1',
                          'query': '${documentSnapshot['lat']},${documentSnapshot['log']}'
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Ver no mapa",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: TextButton(
                  onPressed: () {
                    launchUrl(
                        Uri(scheme: 'tel', path: documentSnapshot['phone']));
                  },
                  child: Text(
                    "Ligar",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
