import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool Animated',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnimatedListDemo(),
    );
  }
}



class AnimatedListDemo extends StatefulWidget {
  const AnimatedListDemo({Key? key}) : super(key: key);
  static String routeName = 'misc/animated_list';

  @override
  State<AnimatedListDemo> createState() => _AnimatedListDemoState();
}

class _AnimatedListDemoState extends State<AnimatedListDemo> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<UserModel> listData = [
    UserModel(0, 'Govind', 'Dixit'),
    UserModel(1, 'Greta', 'Stoll'),
    UserModel(2, 'Monty', 'Carlo'),
    UserModel(3, 'Petey', 'Cruiser'),
    UserModel(4, 'Barry', 'Cade'),
  ];
  int _maxIdValue = 500;

  void editRandomUser() {
    final random = Random();
    if (listData.isNotEmpty) {
      final randomIndex = random.nextInt(listData.length);
      final String randomText = String.fromCharCodes(
        List.generate(10, (_) => random.nextInt(33) + 89),
      );
      setState(() {
        final user = listData[randomIndex];
        listData[randomIndex] = UserModel(
          user.id,
          randomText,
          randomText,
        );
        _listKey.currentState!
            .insertItem(randomIndex, duration: const Duration(milliseconds: 300));
      });
    }
  }

  void addUser() {
    setState(() {
      final index = listData.length;
      listData.add(
        UserModel(++_maxIdValue, 'New', 'Person'),
      );
      _listKey.currentState!
          .insertItem(index, duration: const Duration(milliseconds: 300));
    });
  }

  void addRandomUser() {
    final random = Random();
    final index = listData.length;
    final String randomText = String.fromCharCodes(
      List.generate(10, (_) => random.nextInt(33) + 89),
    );
    setState(() {
      listData.add(
        UserModel(++_maxIdValue, randomText, randomText),
      );
      _listKey.currentState!
          .insertItem(index, duration: const Duration(milliseconds: 100));
    });
  }

  void deleteUser(int id) {
    setState(() {
      final index = listData.indexWhere((u) => u.id == id);
      final user = listData.removeAt(index);
      _listKey.currentState!.removeItem(
        index,
            (context, animation) {
          return FadeTransition(
            opacity: CurvedAnimation(
                parent: animation, curve: const Interval(0.5, 1.0)),
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                  parent: animation, curve: const Interval(0.0, 1.0)),
              axisAlignment: 0.0,
              child: _buildItem(user),
            ),
          );
        },
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  Widget _buildItem(UserModel user) {
    return ListTile(
      key: ValueKey<UserModel>(user),
      title: Text(user.firstName),
      subtitle: Text(user.lastName),
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => deleteUser(user.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List With Few CRUD',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.verified_user, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Welcome!'),
                    content: const Text('Hello, user!'),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue.shade400, Colors.blue.shade800],
                  ),
                  image: DecorationImage(
                    image: NetworkImage('https://cdn.pixabay.com/photo/2016/10/26/19/00/domain-names-1772243_960_720.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Builder(
                    builder: (context) {
                      Widget r=Container();
                      StateSetter? setstateState;


                      return StatefulBuilder(
                          builder: (BuildContext context, StateSetter setStates) {
                            setstateState=setStates;

                            Future.delayed(const Duration(milliseconds: 10), ()
                            {
                              r = AnimatedList(
                                key: _listKey,
                                initialItemCount: listData.length,
                                itemBuilder: (context, index, animation) {
                                  if (index < listData.length) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: _buildItem(listData[index]),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              );
                              setstateState!((){});
                            });

                            return r;
                          }
                      );




                    }
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue,
                    Colors.purple,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        try {
                          addUser();
                        } catch (e) {
                          print('Error adding user: $e');
                        }
                      },
                      child: const Text('Add'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        try {
                          addRandomUser();
                        } catch (e) {
                          print('Error adding user: $e');
                        }
                      },
                      child: const Text('Add Random'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        try {
                          editRandomUser();
                        } catch (e) {
                          print('Error edit user: $e');
                        }
                      },
                      child: const Text('Random Edit'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        try {
                          if (listData.isNotEmpty) {
                            final randomIndex = Random().nextInt(listData.length);
                            setState(() {
                              final id = listData[randomIndex].id;
                              listData.removeWhere((user) => user.id == id);
                              _listKey.currentState!.removeItem(
                                randomIndex,
                                    (context, animation) {
                                  return FadeTransition(
                                    opacity: CurvedAnimation(
                                        parent: animation,
                                        curve: const Interval(0.5, 1.0)),
                                    child: SizeTransition(
                                      sizeFactor: CurvedAnimation(
                                          parent: animation,
                                          curve: const Interval(0.0, 1.0)),
                                      axisAlignment: 0.0,
                                      child: _buildItem(listData[randomIndex]),
                                    ),
                                  );
                                },
                                duration: const Duration(milliseconds: 600),
                              );
                            });
                          }
                        } catch (e) {
                          print('Error removing random user: $e');
                        }
                      },
                      child: const Text('Remove Random'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserModel {
  UserModel(
      this.id,
      this.firstName,
      this.lastName,
      );

  final int id;
  final String firstName;
  final String lastName;
}
