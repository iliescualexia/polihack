import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_project/models/register/register_disabilites_mapping_extension.dart';
import 'package:test_project/widgets/description_text_field_widget.dart';
import 'package:test_project/widgets/text_button_three.dart';
import '../configuration/api_response_handler.dart';
import '../configuration/api_constants.dart';
import '../configuration/custom_http_client.dart';
import '../models/register/register_disabilities_credential_model.dart';
import '../navigation/route_type.dart';
import '../utils/app_gradient.dart';
import '../utils/app_text_style.dart';
import '../utils/custom_sizes.dart';
import '../widgets/credential_text_field_widget.dart';
import '../widgets/dropdown_list_two.dart';
import '../widgets/snack_bar_custom.dart';
import '../widgets/text_button_one.dart';
import 'package:http/http.dart' as http;

class RegisterCaregiverPageDisabilities extends StatefulWidget {
  const RegisterCaregiverPageDisabilities({super.key});

  @override
  State<RegisterCaregiverPageDisabilities> createState() => _RegisterCaregiverPageDisabilitiesState();
}

class _RegisterCaregiverPageDisabilitiesState extends State<RegisterCaregiverPageDisabilities> {
  RegisterCredentialsModel registerCredentialsModel = RegisterCredentialsModel();

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> countries = [];
  List<String> counties = [];
  List<String> cities = [];
  List<String> selectedOptions = [];
  bool isLoadingCountries = true;
  String? selectedCountry;
  String? selectedCounty;
  String? selectedCity;
  bool isLoadingCounties = false;
  bool isLoadingCities = false;
  XFile? image;

  final ImagePicker picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _loadCountries();
    emailController.text = registerCredentialsModel.email;
    firstNameController.text = registerCredentialsModel.firstName;
    lastNameController.text = registerCredentialsModel.lastName;
    emailController.text = registerCredentialsModel.email;
    passwordController.text = registerCredentialsModel.password;
    descriptionController.text = registerCredentialsModel.description;

    emailController.addListener(() {
      registerCredentialsModel.email = emailController.text;
    });
    firstNameController.addListener(() {
      registerCredentialsModel.firstName = firstNameController.text;
    });
    lastNameController.addListener(() {
      registerCredentialsModel.lastName = lastNameController.text;
    });
    passwordController.addListener(() {
      registerCredentialsModel.password = passwordController.text;
    });
    descriptionController.addListener(() {
      registerCredentialsModel.description = descriptionController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(gradient: AppGradient.settingsGradient()),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:  CustomSizes.defaultHorizontalOffset() * 4),
              child: Form(
                key: _formKey,
                child: SafeArea(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //const Spacer(),
                        Text(
                          'Register',
                          style: AppTextStyle.titleStyle(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: CustomSizes.defaultVerticalOffset() * 2),
                          child: CredentialsTextFieldWidget(
                            controller: emailController,
                            obscureText: false,
                            hintText: 'Email',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: CustomSizes.defaultVerticalOffset() * 2,
                          ),
                          child: CredentialsTextFieldWidget(
                            controller: firstNameController,
                            obscureText: false,
                            hintText: 'First Name',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: CustomSizes.defaultVerticalOffset() * 2,
                          ),
                          child: CredentialsTextFieldWidget(
                            controller: lastNameController,
                            obscureText: false,
                            hintText: 'Last Name',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: CustomSizes.defaultVerticalOffset() * 2,
                          ),
                          child: CredentialsTextFieldWidget(
                            controller: passwordController,
                            obscureText: true,
                            hintText: 'Password',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: CustomSizes.defaultVerticalOffset() * 2,
                          ),
                          child: DescriptionTextFieldWidget(
                            controller: descriptionController,
                            obscureText: false,
                            hintText: 'Description',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: CustomSizes.defaultVerticalOffset() * 2,
                          ),
                          child: TextButtonOne(
                            text: 'Upload Criminal Record',
                            onPressed: () {
                              myAlert();
                            },
                          ),
                        ),
                        image != null
                            ? Center(
                              child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                //to show image, you type like this.
                                File(image!.path),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                              ),
                          ),
                        ),
                            )
                            : Center(
                              child: Text(
                          "No Image",
                          style: AppTextStyle.lightDefaultStyle(),
                        ),
                            ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: CustomSizes.defaultVerticalOffset() * 2,
                          ),
                          child: isLoadingCountries ?
                          Center(child: CircularProgressIndicator()) :
                          DropDownListTwo(
                            items: countries,
                            hintText: 'Country',
                            onItemSelected: (value) {
                              registerCredentialsModel.country = value!;
                              selectedCountry = value;
                              _loadCounties(value!);
                              setState(() {
                                selectedCounty = null;
                                cities = [];
                              });
                            },
                          ),
                        ),
                        if(selectedCountry != null)
                          Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: CustomSizes.defaultVerticalOffset() * 2,
                              ),
                              child: isLoadingCounties
                                  ? Center(child: CircularProgressIndicator())
                                  : DropDownListTwo(
                                items: counties,
                                hintText: 'County',
                                onItemSelected: (value) {
                                  selectedCounty = value;
                                  _loadCities(selectedCountry!, value!);
                                  registerCredentialsModel.county = value!;
                                },
                              )
                          ),
                        if(selectedCounty != null && selectedCountry !=null)
                          Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: CustomSizes.defaultVerticalOffset() * 2,
                              ),
                              child: isLoadingCities
                                  ? Center(child: CircularProgressIndicator())
                                  : DropDownListTwo(
                                items: cities,
                                hintText: 'City',
                                onItemSelected: (value) {
                                  selectedCity = value;
                                  registerCredentialsModel.city = value!;
                                },
                              )
                          ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: CustomSizes.defaultVerticalOffset()*10),
                            child: TextButtonOne(
                              text: 'Register',
                              onPressed: () async {
                                String? errorResponse = await _register();
                                if (errorResponse == null) {
                                  Navigator.of(context)
                                      .pushReplacementNamed(RouteType.LoginPage.path());
                                } else {
                                  final snackBar = SnackBarCustom(text: errorResponse);
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
  _loadCountries() async {
    setState(() {
      isLoadingCountries = true;
    });
    final response = await http.get(Uri.parse('https://countriesnow.space/api/v0.1/countries'));
    final Map<String, dynamic> data = json.decode(response.body);

    if (data.containsKey('data') && data['data'] is List) {
      List<dynamic> countryData = data['data'];
      List<String> countryNames = countryData.map((country) => country['country']).cast<String>().toList();

      setState(() {
        countries = countryNames;
        isLoadingCountries = false;
      });
    }
  }

  _loadCounties(String countryName) async {
    setState(() {
      isLoadingCounties = true;
    });

    final client = http.Client();
    try {
      final baseUri = Uri.parse('https://countriesnow.space/api/v0.1/countries/states');
      final request = http.Request('POST', baseUri)
        ..bodyFields = {'country': countryName};

      var response = await client.send(request);
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 301 || response.statusCode == 302) {
        var redirectUrl = response.headers['location'] ?? '';
        final redirectUri = Uri.parse('https://countriesnow.space' + redirectUrl);
        var responseNew = await http.get(redirectUri); // Switch to a GET request
        responseBody = responseNew.body;
      }

      final Map<String, dynamic> data = json.decode(responseBody);

      if (!data['error']) {
        List<String> countyNames = data['data']['states'].map<String>((stateData) {
          return stateData['name'].toString();
        }).toList();

        setState(() {
          counties = countyNames;
          cities = [];
          isLoadingCounties = false;
        });
      } else {
        print('API Error: ${data['msg']}');
        setState(() {
          isLoadingCounties = false;
        });
      }
    } catch (e) {
      print('Error loading counties: $e');
      setState(() {
        isLoadingCounties = false;
      });
    } finally {
      client.close();
    }
  }


  _loadCities(String countryName, String stateName) async {
    setState(() {
      isLoadingCities = true; // Assuming you have a similar boolean flag for cities
    });

    final client = http.Client();
    try {
      final baseUri = Uri.parse('https://countriesnow.space/api/v0.1/countries/state/cities');
      final request = http.Request('POST', baseUri)
        ..bodyFields = {'country': countryName, 'state': stateName};

      var response = await client.send(request);
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 301 || response.statusCode == 302) {
        var redirectUrl = response.headers['location'] ?? '';
        final redirectUri = Uri.parse('https://countriesnow.space' + redirectUrl);
        var responseNew = await http.get(redirectUri); // Switch to a GET request
        responseBody = responseNew.body;
      }

      final Map<String, dynamic> data = json.decode(responseBody);

      if (!data['error']) {
        List<String> cityNames = data['data'].map<String>((cityData) {
          return cityData.toString(); // Assuming cityData is just a string list, if not adjust appropriately
        }).toList();

        setState(() {
          cities = cityNames;
          isLoadingCities = false; // Turn off the loading flag for cities
        });
      } else {
        print('API Error: ${data['msg']}');
        setState(() {
          isLoadingCities = false; // Turn off the loading flag for cities
        });
      }
    } catch (e) {
      print('Error loading cities: $e');
      setState(() {
        isLoadingCities = false; // Turn off the loading flag for cities
      });
    } finally {
      client.close();
    }
  }
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }
  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select',style: AppTextStyle.darkDefaultStyle(),),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  TextButtonThree(
                    icon: Icons.photo,
                    text: 'From Gallery',
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                  ),
                  TextButtonThree(
                    icon: Icons.camera,
                    text: 'From Camera',
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String?> _register() async{
    CustomHttpClient httpClient = CustomHttpClient();

    // final Map<String, String> headers = {
    //   'Content-Type':'application/json',
    // };
    //
    String url = '${httpClient.baseUrl}${APIConstants.registerUrl}/caretaker';;
// Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));
    // request.headers['Content-Type'] = 'multipart/form-data';

    // Add image to the request
    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('profilePicture', image!.path));
    }

    // Add other fields to the request
    request.fields.addAll({
      'email': registerCredentialsModel.email,
      'firstName': registerCredentialsModel.firstName,
      'lastName': registerCredentialsModel.lastName,
      'password': registerCredentialsModel.password,
      'city': registerCredentialsModel.city,
      'country': registerCredentialsModel.country,
      'role': 'CARETAKER',
      'status': 'APPROVE',
      'county': registerCredentialsModel.county,
      'description': registerCredentialsModel.description,
      // Add other fields as needed
    });
    try{
      var response = await request.send();
      print(response.statusCode);
      if(response.statusCode == 200){
        print("success");
      }
      else{
        return "Internal server error. Please try again.";
      }
    }catch(e){
      print('Error: $e');
      return 'An error occurred. Please try again.';
    }

  }

}
