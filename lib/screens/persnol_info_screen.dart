import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class PersnolInfoScreen extends StatefulWidget {

  @override
  _PersnolInfoScreenState createState() => _PersnolInfoScreenState();
}


class _PersnolInfoScreenState extends State<PersnolInfoScreen> {
  File? _image;
  var Token = '';
  late final String apiToken;



  Future<void> _selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
    await _uploadImage();
  }

  Future<void> _uploadImage() async {
    /*if (_image == null || _accessToken == null) {
      // Image file or access token is missing
      return;
    }

    // Create a multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://cnt.hiredeveloper.today/api/updateTalentProfileImage'),
    );

    // Set the authorization header
    request.headers['Authorization'] = 'Bearer $_accessToken';*/

    // Add the image file to the request
    var imageStream = http.ByteStream(_image!.openRead());
    var length = await _image?.length();

    var multipartFile = http.MultipartFile(
      'image',
      imageStream,
      length!,
      filename: _image!.path,
    );

    /*request.files.add(multipartFile);

    // Send the request and get the response
    var response = await request.send();*/

    /*if (response.statusCode == 200) {
      // Image uploaded successfully
      print('Image uploaded');
    } else {
      // Handle error
      print('Image upload failed');
    }*/
  }

  Future<void> uploadImage(String token) async {
    if (_image == null) {
      print('No image selected.');
      return;
    }

    const url = 'https://cnt.hiredeveloper.today/api/updateTalentProfileImage';

    final response = await http.post(Uri.parse(url),body: {});
    var responseData = jsonDecode(response.body);
    var token = Token;
    // Create multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));
    // Set the authorization header with the token
    request.headers['Authorization'] = 'Bearer $token';
    // Add the image file to the request
    request.files.add(
      await http.MultipartFile.fromPath('image', _image!.path),
    );

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully.');
      } else {
        print('Failed to upload image. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while uploading image: $e');
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 100),
          // Button to open the gallery
          ElevatedButton(
            onPressed: () => _selectImage(ImageSource.gallery),
            child: Text('Select from Gallery'),
          ),
          // Button to open the camera
          ElevatedButton(
            onPressed: () => _selectImage(ImageSource.camera),
            child: Text('Take a Photo'),
          ),
          // Display the selected image
          if (_image != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 80, // adjust the radius as needed
                backgroundImage: FileImage(_image!),
              ),
            ),

          Text(Token),
        ],
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('Token', Token));
  }
}
