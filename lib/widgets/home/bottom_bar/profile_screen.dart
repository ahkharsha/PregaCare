import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weekController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  String? profilePic;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    // Load user data when the screen is initialized
    loadData();
  }

  Future<void> loadData() async {
    // Retrieve user data from Firebase and update the UI
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        _nameController.text = userData['name'];
        _weekController.text = userData['week'];
       _bioController.text = userData['bio'] ;
        //profilePic = userData['profilePic'];
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weekController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildProfileHeader(),
            _buildPregnancyTracker(),
            _buildHealthSection(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              await _pickImage();
            },
            child: CircleAvatar(
              radius: 40,
              backgroundImage: profilePic != null
                  ? FileImage(File(profilePic!))
                  : AssetImage(
                      'assets/images/default_profile/profile_picture.png') as ImageProvider,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: _weekController,
                  decoration: InputDecoration(labelText: 'Week of Pregnancy'),
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                TextFormField(
                  controller: _bioController,
                  decoration: InputDecoration(labelText: 'Bio'),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      setState(() {
        profilePic = pickedImage.path;
      });
    }
  }

  Future<String?> _uploadImage(String filePath) async {
    try {
      final fileName = Uuid().v4();
      final Reference fbStorage =
          FirebaseStorage.instance.ref('profile').child(fileName);
      final UploadTask uploadTask = fbStorage.putFile(File(filePath));
      await uploadTask;
      return await fbStorage.getDownloadURL();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return null;
  }

  Future<void> _updateProfile() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        setState(() {
          isSaving = true;
        });

        // Update profile picture if it's changed
        String? downloadUrl;
        if (profilePic != null) {
          downloadUrl = await _uploadImage(profilePic!);
        }

        // Update other profile information
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'name': _nameController.text,
          'week': _weekController.text,
          'bio': _bioController.text,
          if (downloadUrl != null) 'profilePic': downloadUrl,
        });

        Fluttertoast.showToast(msg: 'Profile updated successfully');
      } catch (error) {
        Fluttertoast.showToast(msg: 'Error updating profile: $error');
      } finally {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  Widget _buildPregnancyTracker() {
  // Assuming these are the total weeks of pregnancy.
  // You might want to fetch this value from user input or a database.
  final int totalWeeks = 40;

  // Fetch the user-inputted week of pregnancy (default to 0 if not set)
  int userWeek = int.tryParse(_weekController.text) ?? 0;

  return Container(
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Pregnancy Tracker",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        LinearProgressIndicator(
          value: userWeek / totalWeeks,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),
        ),
        SizedBox(height: 10),
        Text("Week $userWeek of $totalWeeks",
            style: TextStyle(fontSize: 16)),
        // Additional information or tips can be added here.
      ],
    ),
  );
}

  Widget _buildHealthSection() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Health Tips",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text("Daily Exercise"),
            subtitle: Text("30 minutes of walking or yoga is recommended."),
          ),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: Text("Balanced Diet"),
            subtitle: Text("Include fruits, vegetables, and whole grains."),
          ),
        ],
      ),
    );
  }


  Widget _buildSubmitButton() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 20),
    child: isSaving
        ? CircularProgressIndicator()
        : ElevatedButton(
            onPressed: _updateProfile,
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                "Update Profile",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 241, 19, 174),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
  );
}

}