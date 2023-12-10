import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project/models/register/register_disabilites_mapping_extension.dart';
import 'package:test_project/widgets/description_text_field_widget.dart';
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

class RegisterPageDisabilities extends StatefulWidget {
  const RegisterPageDisabilities({super.key});

  @override
  State<RegisterPageDisabilities> createState() => _RegisterPageDisabilitiesState();
}

class _RegisterPageDisabilitiesState extends State<RegisterPageDisabilities> {
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
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;

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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        buildDisabilitiesCheckboxes(),
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


  Future<String?> _register() async{
    CustomHttpClient httpClient = CustomHttpClient();

    final Map<String, String> headers = {
      'Content-Type':'application/json',
    };
    registerCredentialsModel.role="PERSON_WITH_DISABILITIES";
    registerCredentialsModel.status="ACTIVE";
    registerCredentialsModel.categories = selectedOptions;
    String body = jsonEncode(registerCredentialsModel.toJson());
    final response = await httpClient.post(path: '${APIConstants.registerUrl}/disability', headers: headers, body: body);
    if(response.statusCode == 200){
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      if(!APIResponseHandler.hasErrors(responseBody)){
        print("Register successful");
      }
      else{
        return APIResponseHandler.getData(responseBody);
      }
    }
    else{
      return "Internal server error. Please try again.";
    }
  }
  Widget buildDisabilitiesCheckboxes() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
              vertical: CustomSizes.defaultVerticalOffset() * 2,
            ),
            child:Text(
              "Selectati categoriile in care va incadrati",
              style: AppTextStyle.lightDefaultStyle(),
            )
        ),
        Padding(
            padding: EdgeInsets.symmetric(
              vertical: CustomSizes.defaultVerticalOffset() * 2,
            ),
            child:CheckboxListTile(
              value: isChecked1,
              onChanged: (value) {
                setState(() {
                  isChecked1 = value ?? false;

                  if (isChecked1) {
                    // If checkbox is selected, add "MUT" to the list
                    selectedOptions.add("SURD");
                  } else {
                    // If checkbox is deselected, remove "MUT" from the list
                    selectedOptions.remove("SURD");
                  }
                });
              },
              title: Text('Hearing impairment', style: AppTextStyle.lightDefaultStyle()),
            )
        ),
        Padding(
            padding: EdgeInsets.symmetric(
              vertical: CustomSizes.defaultVerticalOffset() * 2,
            ),
            child:CheckboxListTile(
              value: isChecked2,
              onChanged: (value) {
                setState(() {
                  isChecked2 = value ?? false;

                  if (isChecked2) {
                    // If checkbox is selected, add "MUT" to the list
                    selectedOptions.add("MUT");
                  } else {
                    // If checkbox is deselected, remove "MUT" from the list
                    selectedOptions.remove("MUT");
                  }
                });
              },
              title: Text('Speech disorders', style: AppTextStyle.lightDefaultStyle()),
            )
        ),
        Padding(
            padding: EdgeInsets.symmetric(
              vertical: CustomSizes.defaultVerticalOffset() * 2,
            ),
            child:CheckboxListTile(
              value: isChecked3,
              onChanged: (value) {
                setState(() {
                  isChecked3 = value ?? false;

                  if (isChecked3) {
                    // If checkbox is selected, add "MUT" to the list
                    selectedOptions.add("NEVAZATOR");
                  } else {
                    // If checkbox is deselected, remove "MUT" from the list
                    selectedOptions.remove("NEVAZATOR");
                  }
                });
              },
              title: Text('Blindness', style: AppTextStyle.lightDefaultStyle()),
            )
        ),
        Padding(
            padding: EdgeInsets.symmetric(
              vertical: CustomSizes.defaultVerticalOffset() * 2,
            ),
            child:CheckboxListTile(
              value: isChecked4,
              onChanged: (value) {
                setState(() {
                  isChecked4 = value ?? false;

                  if (isChecked4) {
                    // If checkbox is selected, add "MUT" to the list
                    selectedOptions.add("PARALIZIE");
                  } else {
                    // If checkbox is deselected, remove "MUT" from the list
                    selectedOptions.remove("PARALIZIE");
                  }
                });
              },
              title: Text('Locomotor impairments', style: AppTextStyle.lightDefaultStyle()),
            )
        ),
        Padding(
            padding: EdgeInsets.symmetric(
              vertical: CustomSizes.defaultVerticalOffset() * 2,
            ),
            child:CheckboxListTile(
              value: isChecked5,
              onChanged: (value) {
                setState(() {
                  isChecked5 = value ?? false;

                  if (isChecked5) {
                    // If checkbox is selected, add "MUT" to the list
                    selectedOptions.add("MENTAL");
                  } else {
                    // If checkbox is deselected, remove "MUT" from the list
                    selectedOptions.remove("MENTAL");
                  }
                });
              },
              title: Text('Mental illness', style: AppTextStyle.lightDefaultStyle()),
            )
        ),
        Padding(
            padding: EdgeInsets.symmetric(
              vertical: CustomSizes.defaultVerticalOffset() * 2,
            ),
            child:CheckboxListTile(
              value: isChecked6,
              onChanged: (value) {
                setState(() {
                  isChecked6 = value ?? false;

                  if (isChecked6) {
                    // If checkbox is selected, add "MUT" to the list
                    selectedOptions.add("VARSTNICI");
                  } else {
                    // If checkbox is deselected, remove "MUT" from the list
                    selectedOptions.remove("VARSTNICI");
                  }
                });
              },
              title: Text('Elders', style: AppTextStyle.lightDefaultStyle()),
            )
        ),
      ],
    );
  }

}
