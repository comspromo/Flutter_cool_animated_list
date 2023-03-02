# cool_animated_list

Croos-Platform This code implements an animated list that demonstrates CRUD Function.

## Getting Started

CLONE

OPEN ON ANDROID STUDIO, VSCODE OR IDE OF CHOICE

RECOMMENDED: flutter_3.3.8-stable


The app has a AnimatedList widget that is initialized with a List<UserModel> named listData. The AnimatedList widget is wrapped inside a StatefulBuilder widget, which allows it to be rebuilt when necessary.

There are five methods that manipulate the listData. The editRandomUser() method selects a random UserModel from the list and updates its firstName and lastName properties with random text generated by the Random class. It then calls the setState() method to rebuild the AnimatedList with the updated listData. The selected UserModel is animated to show the change with an insertItem method call on the _listKey GlobalKey<AnimatedListState>.

The addUser() method creates a new UserModel with an incremented id and the first name and last name set to "New" and "Person" respectively. It then adds the new UserModel to the listData and rebuilds the AnimatedList widget with an insertItem method call on the _listKey.

The addRandomUser() method generates random text using the Random class and creates a new UserModel with an incremented id and the generated text set as both the first name and last name. It then adds the new UserModel to the listData and rebuilds the AnimatedList widget with an insertItem method call on the _listKey.

The deleteUser(int id) method removes a UserModel with the specified id from the listData. It then animates the removal of the UserModel from the AnimatedList by calling the removeItem method on the _listKey GlobalKey<AnimatedListState>. The removeItem method takes a IndexedWidgetBuilder as an argument that specifies the animation to be performed when removing the item from the list. The IndexedWidgetBuilder returns a FadeTransition widget that fades out the UserModel being removed, followed by a SizeTransition widget that shrinks the UserModel to zero size. The duration of the animation is 300 milliseconds.

The _buildItem(UserModel user) method returns a ListTile widget that displays the first and last name of the UserModel along with a CircleAvatar widget that displays an icon and an IconButton widget that triggers the removal of the UserModel from the AnimatedList when pressed.