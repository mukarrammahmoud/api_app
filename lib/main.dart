

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const ApiApp());
}

class ApiApp extends StatefulWidget {
  const ApiApp({super.key});

  @override
  State<ApiApp> createState() => _ApiAppState();
}

class _ApiAppState extends State<ApiApp> {
  List data = [];
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Api")),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: MaterialButton(
                  height: 50,
                  color: const Color.fromARGB(255, 12, 247, 0),
                  textColor: Colors.white,
                  onPressed: () async {
                    loading = true;
                    setState(() {});
                    var response =
                        await get(Uri.parse("https://fakestoreapi.com/users"));
                    var responseBody = jsonDecode(response.body);
                    data.addAll(responseBody);
                    loading = false;
                    setState(() {});
                    
                  },
                  child: const Text("Http Request"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (loading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            ...List.generate(
              data.length,
              (index) => Card(
                child: ListTile(
                  style: ListTileStyle.drawer,
                  leading: Text(" ${data[index]["id"]}",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 51, 255, 24))),
                  title: Text(
                    "Name :  ${data[index]["username"]} ",
                    style: const TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 35, 29, 21)),
                  ),
                  subtitle: Text(" ${data[index]["email"]}",
                      style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 163, 24))),
                  trailing: Text("phone : ${data[index]["phone"]}",
                      style: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 163, 24))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
