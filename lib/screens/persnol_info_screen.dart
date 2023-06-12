import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class PersnolInfoScreen extends StatefulWidget {
  const PersnolInfoScreen({Key? key}) : super(key: key);


  @override
  // ignore: library_private_types_in_public_api
  _PersnolInfoScreenState createState() => _PersnolInfoScreenState();
}


class _PersnolInfoScreenState extends State<PersnolInfoScreen> {
  File? _image;
  final _token = '';
  late final String apiToken;



  Future<void> _selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
   /* await _uploadImage();*/
  }

  /*Future<void> _uploadImage() async {

    // Add the image file to the request
    var imageStream = http.ByteStream(_image!.openRead());
    var length = await _image?.length();

    var multipartFile = http.MultipartFile(
      'image',
      imageStream,
      length!,
      filename: _image!.path,
    );
  }*/

  Future<void> uploadImage(String token) async {
    if (_image == null) {
      if (kDebugMode) {
        print('No image selected.');
      }
      return;
    }

    const url = 'https://cnt.hiredeveloper.today/api/updateTalentProfileImage';

    //final response = await http.post(Uri.parse(url),body: {});
    //var responseData = jsonDecode(response.body);
    var token = _token;
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
        if (kDebugMode) {
          print('Image uploaded successfully.');
        }
      } else {
        if (kDebugMode) {
          print('Failed to upload image. Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred while uploading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 100),
        // Button to open the gallery
        ElevatedButton(
          onPressed: () => _selectImage(ImageSource.gallery),
          child: const Text('Select from Gallery'),
        ),
        // Button to open the camera
        ElevatedButton(
          onPressed: () => _selectImage(ImageSource.camera),
          child: const Text('Take a Photo'),
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
        Text(_token),
      ],
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('Token', _token));
  }
}
