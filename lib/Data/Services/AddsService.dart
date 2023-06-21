import 'dart:convert';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http ;
import 'package:mob1/Data/Models/Drink.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';
class AddsService{
  static Future<Map<String, dynamic>> getAdd({required File picture,required String distUid}) async {
    try {
      String imagePath = 'lib/UI/assets/images/rrr.jpg';
      ByteData imageBytes = await rootBundle.load(imagePath);
      List<int> imageBytesList = imageBytes.buffer.asUint8List();

      // Create a temporary file to store the image
      Directory tempDir = await getTemporaryDirectory();
      String tempFilePath = '${tempDir.path}/temp_image.png';
      File tempImage = File(tempFilePath);
      await tempImage.writeAsBytes(imageBytesList);

      // Create the multipart request
      var request = http.MultipartRequest('POST', Uri.parse('https://age-gender-ad.onrender.com/detect'));

      // Attach the image file
      request.files.add(http.MultipartFile('image', tempImage.readAsBytes().asStream(), tempImage.lengthSync(), filename: 'temp_image.jpg'));

      // Add other form fields if required
      request.fields['distUID'] = distUid;

      // Send the request and get the response
      var response = await request.send();
       print("res $response");
      // Read the response into a string
      var responseString = await response.stream.bytesToString();

      // Check the response status
      print("hhh $responseString");
      if (response.statusCode == 200) {
        // Request successful
        print('Image uploaded successfully');
        var data = json.decode(responseString) as Map<String, dynamic>;
        print(data);
        return data;
      } else {
        // Request failed
        print('Failed to upload image. Status code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print("Error: $e");
      return {};
    }
  }
}