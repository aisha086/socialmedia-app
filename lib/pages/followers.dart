import 'package:flutter/material.dart';
import 'package:memorykeeper/pages/user_details.dart';
import 'package:memorykeeper/services/api_services_users.dart';
import 'package:memorykeeper/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import '../model/users.dart';
import '../services/themes_services.dart';
import '../utils/themes.dart';

class ShowFollowers extends StatefulWidget {
  const ShowFollowers({super.key});

  @override
  State<ShowFollowers> createState() => _ShowFollowersState();
}

class _ShowFollowersState extends State<ShowFollowers> {
  @override
  Widget build(BuildContext context) {

    bool isLight =
        context.watch<ThemeServices>().currentTheme == MyThemes.lightTheme;
    UserServices userServices = UserServices();

    return Scaffold(
      backgroundColor: isLight ? lightBeigeColor : lightGreyColor,
      appBar: appbar(context,"Followers"),
      body: FutureBuilder(
          future: userServices.getUsers(),
          builder: (context,snapshot){
            {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                List<Users> userList = snapshot.data!;
                print("Printing users");
                print(userList.length);
                if (userList.isNotEmpty) {
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        final user = userList[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 6,horizontal: 25),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isLight ? yellowishColor : greyColor,
                            borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1.0,
                                  color: isLight
                                      ? Colors.white
                                      : Colors.grey[700]!)),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black26,
                              backgroundImage: NetworkImage(user.image),
                              radius: 20,
                            ),
                            title: Text(
                              "${user.firstName} ${user.lastName}"
                            ),
                            subtitle: Text(
                              user.company['title']
                            ),
                            trailing: IconButton(
                                icon:Icon(Icons.visibility),
                              onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetailPage(user: user)));
                              },
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: Text("No Comments"),
                  );
                }
              }
            }
          }
      ),
    );
  }
}
