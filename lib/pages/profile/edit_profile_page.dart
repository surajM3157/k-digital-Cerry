import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_state_city/country_state_city.dart' as s;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:piwotapp/constants/api_urls.dart';
import 'package:piwotapp/responses/guest_details_response.dart';
import 'package:piwotapp/widgets/app_button.dart';
import 'package:piwotapp/widgets/app_textfield.dart';
import '../../constants/colors.dart';
import '../../constants/font_family.dart';
import '../../constants/images.dart';
import '../../repository/api_repo.dart';
import '../../shared prefs/pref_manager.dart';
import '../../widgets/app_themes.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController streamController = TextEditingController();
  TextEditingController batchController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  File? _image;
  bool tapCamera = false;
  bool tapGallery = false;
  String? _gender = "Male";
  String? _isAlumni = "No";
  String? country = "";
  String? iitName = "";
  String? batch = "";
  String? stream = "";
  // PhoneNumber? _phoneNumber = PhoneNumber(dialCode: '+244'); // Default country code
  PhoneNumber? _phoneNumber = PhoneNumber(isoCode: 'IN'); // Default country code
  String? profileImage;
  String? selectedState;
  String? selectedCity;
  String? selectedCountry;
  String? selectedCountryId;
  bool isCountryChanged = false;
  bool isStateChanged = false;
  List<s.Country> countries = [];
  List<s.State> states = [];
  List<s.City> cities = [];



  Future<void> fetchCountries() async {
    countries = await s.getAllCountries();
    setState(() {});
    if (selectedCountry != null) {
      fetchStates(countries
          .firstWhere(
            (state) => selectedCountry == state.name,
            // orElse: () => countries[0], // Provide a default value in case no match is found
          )
          .isoCode);
    }
  }

  Future<void> fetchStates(String countryId) async {
    states = await s.getStatesOfCountry(countryId);
    print("state $states");

    setState(() {});
    if (selectedCity != null) {
      fetchCities(
          countries
              .firstWhere(
                (country) => selectedCountry == country.name,
                // orElse: () => countries[0], // Provide a default value in case no match is found
              )
              .isoCode,
          states
              .firstWhere(
                (state) => selectedState == state.name,
                // orElse: () => states[0], // Provide a default value in case no match is found
              )
              .isoCode);
    }
  }

  Future<void> fetchCities(String countryId, String stateId) async {
    cities = await s.getStateCities(countryId, stateId);
    setState(() {});

    print("cities $cities");
    print("states $states");
    print("countries $countries");
  }

  String selectedPrefix = "Mr";
  bool isLoading = true;
  bool _genderError = false;

  Map<String, String> CountryCodeObj ={
    "+91": "IN",
    "+93": "AF",
    "+355": "AL",
    "+213": "DZ",
    "+1684": "AS",
    "+376": "AD",
    "+244": "AO",
    "+1264": "AI",
    "+672": "AQ",
    "+1268": "AG",
    "+54": "AR",
    "+374": "AM",
    "+297": "AW",
    "+61": "AU",
    "+43": "AT",
    "+994": "AZ",
    "+1242": "BS",
    "+973": "BH",
    "+880": "BD",
    "+1246": "BB",
    "+375": "BY",
    "+32": "BE",
    "+501": "BZ",
    "+229": "BJ",
    "+1441": "BM",
    "+975": "BT",
    "+591": "BO",
    "+387": "BA",
    "+267": "BW",
    "+55": "BR",
    "+246": "IO",
    "+673": "BN",
    "+359": "BG",
    "+226": "BF",
    "+257": "BI",
    "+855": "KH",
    "+237": "CM",
    "+1": "CA",
    "+238": "CV",
    "+1345": "KY",
    "+236": "CF",
    "+235": "TD",
    "+56": "CL",
    "+86": "CN",
    "+61": "CX",
    "+61": "CC",
    "+57": "CO",
    "+269": "KM",
    "+242": "CG",
    "+243": "CD",
    "+682": "CK",
    "+506": "CR",
    "+385": "HR",
    "+53": "CU",
    "+357": "CY",
    "+420": "CZ",
    "+45": "DK",
    "+253": "DJ",
    "+1767": "DM",
    "+1809": "DO",
    "+593": "EC",
    "+20": "EG",
    "+503": "SV",
    "+240": "GQ",
    "+291": "ER",
    "+372": "EE",
    "+251": "ET",
    "+500": "FK",
    "+298": "FO",
    "+679": "FJ",
    "+358": "FI",
    "+33": "FR",
    "+594": "GF",
    "+689": "PF",
    "+241": "GA",
    "+220": "GM",
    "+995": "GE",
    "+49": "DE",
    "+233": "GH",
    "+350": "GI",
    "+30": "GR",
    "+299": "GL",
    "+1473": "GD",
    "+590": "GP",
    "+1671": "GU",
    "+502": "GT",
    "+44": "GG",
    "+224": "GN",
    "+245": "GW",
    "+592": "GY",
    "+509": "HT",
    "+39": "VA",
    "+504": "HN",
    "+852": "HK",
    "+36": "HU",
    "+354": "IS",
    "+91": "IN",
    "+62": "ID",
    "+98": "IR",
    "+964": "IQ",
    "+353": "IE",
    "+44": "IM",
    "+972": "IL",
    "+39": "IT",
    "+1876": "JM",
    "+81": "JP",
    "+44": "JE",
    "+962": "JO",
    "+7": "KZ",
    "+254": "KE",
    "+686": "KI",
    "+850": "KP",
    "+82": "KR",
    "+965": "KW",
    "+996": "KG",
    "+856": "LA",
    "+371": "LV",
    "+961": "LB",
    "+266": "LS",
    "+231": "LR",
    "+218": "LY",
    "+423": "LI",
    "+370": "LT",
    "+352": "LU",
    "+853": "MO",
    "+389": "MK",
    "+261": "MG",
    "+265": "MW",
    "+60": "MY",
    "+960": "MV",
    "+223": "ML",
    "+356": "MT",
    "+692": "MH",
    "+596": "MQ",
    "+222": "MR",
    "+230": "MU",
    "+262": "YT",
    "+52": "MX",
    "+373": "MD",
    "+377": "MC",
    "+976": "MN",
    "+382": "ME",
    "+1664": "MS",
    "+212": "MA",
    "+258": "MZ",
    "+95": "MM",
    "+264": "NA",
    "+674": "NR",
    "+977": "NP",
    "+31": "NL",
    "+599": "AN",
    "+687": "NC",
    "+64": "NZ",
    "+505": "NI",
    "+227": "NE",
    "+234": "NG",
    "+683": "NU",
    "+672": "NF",
    "+1": "MP",
    "+47": "NO",
    "+968": "OM",
    "+92": "PK",
    "+680": "PW",
    "+970": "PS",
    "+507": "PA",
    "+675": "PG",
    "+595": "PY",
    "+51": "PE",
    "+63": "PH",
    "+48": "PL",
    "+351": "PT",
    "+1": "PR",
    "+974": "QA",
    "+262": "RE",
    "+40": "RO",
    "+7": "RU",
    "+250": "RW",
    "+290": "SH",
    "+1": "KN",
    "+1": "LC",
    "+1": "PM",
    "+1784": "VC",
    "+684": "WS",
    "+221": "SN",
    "+381": "RS",
    "+248": "SC",
    "+232": "SL",
    "+65": "SG",
    "+421": "SK",
    "+386": "SI",
    "+677": "SB",
    "+252": "SO",
    "+27": "ZA",
    "+500": "GS",
    "+34": "ES",
    "+94": "LK",
    "+249": "SD",
    "+597": "SR",
    "+268": "SZ",
    "+46": "SE",
    "+41": "CH",
    "+963": "SY",
    "+886": "TW",
    "+992": "TJ",
    "+255": "TZ",
    "+66": "TH",
    "+670": "TL",
    "+228": "TG",
    "+690": "TK",
    "+676": "TO",
    "+1": "TT",
    "+216": "TN",
    "+90": "TR",
    "+993": "TM",
    "+1": "TC",
    "+688": "TV",
    "+256": "UG",
    "+380": "UA",
    "+971": "AE",
    "+44": "GB",
    "+1": "US",
    "+598": "UY",
    "+998": "UZ",
    "+678": "VU",
    "+379": "VA",
    "+58": "VE",
    "+84": "VN",
    "+1284": "VG",
    "+1340": "VI",
    "+681": "WF",
    "+967": "YE",
    "+260": "ZM",
    "+263": "ZW"
  };

  var iitItems = [
    "IIT BOMBAY",
    "IIT DELHI",
    "IIT MADRAS",
    "IIT KANPUR",
    "IIT KHARAGPUR",
    "IIT ROORKEE",
    "IIT GUWAHATI",
    "IIT BHUBANESWAR",
    "IIT GANDHINAGAR",
    "IIT HYDERABAD",
    "IIT JODHPUR",
    "IIT PATNA",
    "IIT ROPAR",
    "IIT INDORE",
    "IIT (ISM) DHANBAD",
    "IIT BHILAI",
    "IIT GOA",
    "IIT JAMMU",
    "IIT TIRUPATI",
    "IIT PALAKKAD",
    "IIT VARANASI (BHU)",
    "IIT MANDI",
    "IIT DHARWAD"
  ];

  var iitBatchItems = [
    "1970",
    "1971",
    "1972",
    "1973",
    "1974",
    "1975",
    "1976",
    "1977",
    "1978",
    "1979",
    "1980",
    "1981",
    "1982",
    "1983",
    "1984",
    "1985",
    "1986",
    "1987",
    "1988",
    "1989",
    "1990",
    "1991",
    "1992",
    "1993",
    "1994",
    "1995",
    "1996",
    "1997",
    "1998",
    "1999",
    "2000",
    "2001",
    "2002",
    "2003",
    "2004",
    "2005",
    "2006"
  ];

  var genderList = ['Male', 'Female'];

  GuestDetailsData? guestDetails;
  bool isConnected = true;

  fetchGuestDetails() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {});
    } else {
      isConnected = true;
      Future.delayed(Duration.zero, () {
        showLoader(context);
      });

      var response = await ApiRepo().getGuestDetailsResponse();
      print("guest details in api => ${response.data} ");
      if (response.data != null) {
        guestDetails = response.data;
        firstNameController.text =
            AppThemes.capitalizeFirst(guestDetails?.firstName ?? "");
        lastNameController.text =
            AppThemes.capitalizeFirst(guestDetails?.lastName ?? "");
        emailController.text = guestDetails?.emailId ?? "";
        phoneNumberController.text =
            guestDetails?.mobileNumber.toString() ?? "";
        print(
            "Fetched Phone Number: ${phoneNumberController.text}"); // Debugging line
        companyController.text = guestDetails?.companyName ?? '';
        designationController.text = guestDetails?.designation ?? "";
        selectedCountry = guestDetails?.country ?? null;
        selectedState = guestDetails?.state ?? null;
        selectedCity = guestDetails?.city ?? null;
        streamController.text = guestDetails?.stream ?? "";
        // country = (countryItems.contains(guestDetails?.country) ? guestDetails?.country : null)??"";
        _gender = guestDetails?.gender ?? "";
        print("Country_code1 ${CountryCodeObj["+91"]}");


        var CountryIsoCode ;

        if (guestDetails?.countryCode != null) {
          CountryIsoCode = CountryCodeObj[guestDetails?.countryCode];
        } else {
          CountryIsoCode = CountryCodeObj["+91"];
        }

        // _phoneNumber = PhoneNumber(isoCode: CountryIsoCode);
        print("ksdbfubdiufbd dfkbdiufgdiuofhbn ${CountryIsoCode}");
        _phoneNumber = PhoneNumber(isoCode: CountryIsoCode);

        iitName = (iitItems.contains(guestDetails?.iitName)
                ? guestDetails?.iitName
                : null) ??
            "";
        batchController.text = (guestDetails?.batch.toString() != "null"
            ? guestDetails!.batch.toString()
            : "");
        // batch = (iitBatchItems.contains(guestDetails?.batch.toString()) ? guestDetails?.batch.toString() : null)??"";

        _isAlumni = guestDetails?.alumniOfIit == true ? "Yes" : "No";
        profileImage = guestDetails?.guestProfileImage ?? "";
        isLoading = false;

        fetchCountries();
      }

      print("selectedCountry $selectedCountry");
      print("selectedState $selectedState");
      print("selectedCity $selectedCity");

      setState(() {});
    }
  }

  @override
  void initState() {

    fetchGuestDetails();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected = false;
      } else {
        // Handle case when internet connection is available
        isConnected = true;
        fetchGuestDetails();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: isConnected
          ? SingleChildScrollView(
              child: Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 250,
                          width: Get.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: AppColor.gradientColors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(170),
                                  bottomLeft: Radius.circular(170))),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Center(
                                  child: SvgPicture.asset(Images.logo,
                                      height: 40, width: 147)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                hintText: "Enter First Name*",
                                controller: firstNameController,
                                labelText: "First Name*",
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                inputFormatters: [
                                  // Deny leading spaces
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(?!\s).*')),
                                  // Allow only alphabetic characters, spaces, and period (for initials)
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z\\s\\.]")),
                                ],
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter valid first name.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Expanded(
                              child: AppTextField(
                                hintText: "Enter Last Name*",
                                controller: lastNameController,
                                labelText: "Last Name*",
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                inputFormatters: [
                                  // Deny leading spaces
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(?!\s).*')),
                                  // Allow only alphabetic characters and spaces
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z\\s]")),
                                ],
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Enter valid last name.';
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        AppTextField(
                          hintText: "Type your Email*",
                          controller: emailController,
                          labelText: "Email*",
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.toString() == "" ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value.toString())) {
                              return 'Enter a valid email.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        //InternationalPhoneNumberInput
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 28),
                          child: InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              // On input change, no need to use setState() unless you want to refresh the UI
                              _phoneNumber = number; // Only update the phone number state variable
                            },
                            onInputValidated: (bool value) {
                              // Handle validation if needed
                            },
                            initialValue: _phoneNumber,
                            textFieldController: phoneNumberController,
                            hintText: "9876543210",
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET, // Dropdown for country code
                            ),
                            inputDecoration: const InputDecoration(
                              prefixIcon: Icon(Icons.call, color: Colors.grey),
                              labelText: "Phone Number*",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter a valid phone number.';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        genderWidget(),
                        const SizedBox(
                          height: 25,
                        ),
                        AppTextField(
                          hintText: "Type your Designation*",
                          controller: designationController,
                          labelText: "Designation*",
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                "[a-zA-Z\\s@#\$%!&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]")),
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter a valid designation.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        AppTextField(
                          hintText: "Type your Company Name*",
                          controller: companyController,
                          labelText: "Company Name*",
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter a valid company name.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: isLoading
                              ? const SizedBox.shrink()
                              : DropdownSearch<String>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      cursorColor: AppColor.primaryColor,
                                      decoration: InputDecoration(
                                        hintText: 'Search country',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.black
                                                  .withOpacity(0.12)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.primaryColor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Select your Country*",
                                      labelText: "Country/Region*",
                                      labelStyle: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontFamily: appFontFamily,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                      hintStyle: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: appFontFamily,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 10),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: AppColor.black
                                                .withOpacity(0.12)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: AppColor.black
                                                .withOpacity(0.12)),
                                      ),
                                    ),
                                  ),
                                  items: countries
                                      .map((country) => country.name)
                                      .toList(),
                                  selectedItem: selectedCountry,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      isCountryChanged = true;
                                      selectedCountry = newValue;
                                      selectedState = null;
                                      selectedCity = null;
                                      states = [];
                                      cities = [];
                                    });
                                    final selectedCountryIsoCode = countries
                                        .firstWhere((country) =>
                                            country.name == newValue)
                                        .isoCode;
                                    fetchStates(selectedCountryIsoCode);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select a valid country.';
                                    }
                                    return null;
                                  },
                                ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: isLoading
                              ? const SizedBox.shrink()
                              : DropdownSearch<String>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      cursorColor: AppColor.primaryColor,
                                      decoration: InputDecoration(
                                        hintText: 'Search state',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.black
                                                  .withOpacity(0.12)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.primaryColor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Select your State*",
                                      labelText: "State*",
                                      labelStyle: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontFamily: appFontFamily,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                      hintStyle: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: appFontFamily,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 10),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: AppColor.black
                                                .withOpacity(0.12)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: AppColor.black
                                                .withOpacity(0.12)),
                                      ),
                                    ),
                                  ),
                                  items: states
                                      .map((state) => state.name)
                                      .toList(),
                                  selectedItem: selectedState,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      isStateChanged = true;
                                      selectedState = newValue;
                                      selectedCity = null;
                                      cities = [];
                                    });
                                    fetchCities(
                                        countries
                                            .firstWhere((country) =>
                                                country.name == selectedCountry)
                                            .isoCode,
                                        states
                                            .firstWhere((state) =>
                                                state.name == newValue)
                                            .isoCode);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select a valid state.';
                                    }
                                    return null;
                                  },
                                ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: isLoading
                              ? const SizedBox.shrink()
                              : DropdownSearch<String>(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      cursorColor: AppColor.primaryColor,
                                      decoration: InputDecoration(
                                        hintText: 'Search city',
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.black
                                                  .withOpacity(0.12)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.primaryColor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColor.primaryColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Select your city*",
                                      labelText: "City*",
                                      labelStyle: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontFamily: appFontFamily,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                      hintStyle: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: appFontFamily,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 10),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: AppColor.black
                                                .withOpacity(0.12)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: AppColor.black
                                                .withOpacity(0.12)),
                                      ),
                                    ),
                                  ),
                                  items:
                                      cities.map((city) => city.name).toList(),
                                  selectedItem: selectedCity,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCity = newValue;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Select a valid city.';
                                    }
                                    return null;
                                  },
                                ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        isAlumniWidget(),
                        _isAlumni == "Yes"
                            ? const SizedBox(
                                height: 25,
                              )
                            : const SizedBox.shrink(),
                        _isAlumni == "Yes"
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "If Yes, Please Select Your IIT: ",
                                  style: TextStyle(
                                      fontFamily: appFontFamily,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.primaryColor,
                                      fontSize: 14),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 10,
                        ),
                        _isAlumni == "Yes"
                            ? const SizedBox(
                                height: 10,
                              )
                            : const SizedBox.shrink(),
                        _isAlumni == "Yes"
                            ? isLoading == true
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: DropdownButtonFormField<String>(
                                      value: iitName == "" ? null : iitName,
                                      items: iitItems
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (_isAlumni == "Yes")
                                          ? (value) {
                                              if (value.toString() == "" ||
                                                  value == null) {
                                                return 'Select a valid IIT.';
                                              }
                                              return null;
                                            }
                                          : null,
                                      onChanged: (value) {
                                        iitName = value!;
                                      },
                                      dropdownColor: AppColor.white,
                                      iconSize: 30,
                                      decoration: InputDecoration(
                                        hintText: "Select your IIT*",
                                        labelText: "IIT*",
                                        labelStyle: TextStyle(
                                            color: AppColor.primaryColor,
                                            fontFamily: appFontFamily,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                        hintStyle: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: appFontFamily,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                color: AppColor.black
                                                    .withOpacity(0.12))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                                color: AppColor.black
                                                    .withOpacity(0.12))),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 2.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 2.0),
                                        ),
                                      ),
                                    ),
                                  )
                            : const SizedBox.shrink(),
                        _isAlumni == "Yes"
                            ? const SizedBox(
                                height: 25,
                              )
                            : const SizedBox.shrink(),
                        _isAlumni == "Yes"
                            ? isLoading == true
                                ? const SizedBox.shrink()
                                : AppTextField(
                                    hintText: "Type your Batch",
                                    controller: batchController,
                                    labelText: "Batch",
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      // Deny leading spaces
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^(?!\s).*')),
                                      // Allow only digits and limit length to 4
                                      LengthLimitingTextInputFormatter(4),
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      // Ensure the value is not empty or just spaces
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please enter a batch.';
                                      }
                                      // Ensure the value is a 4-digit number
                                      if (value.length != 4) {
                                        return 'Batch must be exactly 4 digits.';
                                      }
                                      return null;
                                    },
                                  )
                            : const SizedBox.shrink(),
                        _isAlumni == "Yes"
                            ? const SizedBox(
                                height: 25,
                              )
                            : const SizedBox.shrink(),
                        _isAlumni == "Yes"
                            ? AppTextField(
                                hintText: "Type your Stream",
                                controller: streamController,
                                labelText: "Stream",
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                inputFormatters: [
                                  // Deny leading spaces
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^(?!\s).*')),
                                ],
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter a stream.';
                                  }
                                  return null;
                                },
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 30,
                        ),
                        AppButton(
                            title: "Update",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                print("form validated");
                                profileUpdate();
                              }
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImageFromCameraAndGallery();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 188,
                        height: 188,
                        margin: const EdgeInsets.only(top: 120),
                        padding: _image != null || profileImage != ""
                            ? null
                            : const EdgeInsets.all(50),
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            border: Border.all(color: AppColor.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100))),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: _image != null
                                ? Image.file(
                                    _image!,
                                    fit: BoxFit.fill,
                                  )
                                : profileImage != ""
                                    ? Image.network(
                                        ApiUrls.imageUrl + (profileImage ?? ""),
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        Images.profileDefault,
                                        height: 64,
                                        width: 64,
                                        fit: BoxFit.cover,
                                      )),
                      ),
                    ),
                  ),
                  Prefs.checkProfile == true
                      ? const SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 60),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                  Positioned(
                    left: 230,
                    top: 250,
                    child: GestureDetector(
                      onTap: pickImageFromCameraAndGallery,
                      child: Container(
                          height: 54,
                          width: 54,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                  colors: AppColor.gradientColors)),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: AppColor.white,
                            size: 30,
                          )),
                    ),
                  )
                ],
              ),
            )
          : const Center(
              child: Text(
              "OOPS! NO INTERNET.",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontFamily: appFontFamily,
                  fontSize: 20),
            )),
    );
  }

  Widget isAlumniWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Are you an alumni of any IIT?*",
            style: TextStyle(
                fontFamily: appFontFamily,
                fontWeight: FontWeight.w600,
                color: AppColor.primaryColor,
                fontSize: 14),
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'Yes',
                    activeColor: AppColor.primaryColor,
                    groupValue: _isAlumni,
                    onChanged: (String? value) {
                      setState(() {
                        _isAlumni = value;
                      });
                    },
                  ),
                  Text(
                    'Yes',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: appFontFamily,
                        color: AppColor.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'No',
                    activeColor: AppColor.primaryColor,
                    groupValue: _isAlumni,
                    onChanged: (String? value) {
                      setState(() {
                        _isAlumni = value;
                      });
                    },
                  ),
                  Text(
                    'No',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: appFontFamily,
                        color: AppColor.black),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget genderWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender*",
            style: TextStyle(
              fontFamily: appFontFamily,
              fontWeight: FontWeight.w600,
              color: AppColor.primaryColor,
              fontSize: 13,
            ),
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'Male',
                    activeColor: AppColor.primaryColor,
                    groupValue: _gender,
                    onChanged: (String? value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                  Text(
                    'Male',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: appFontFamily,
                        color: AppColor.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Female',
                    activeColor: AppColor.primaryColor,
                    groupValue: _gender,
                    onChanged: (String? value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                  Text(
                    'Female',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: appFontFamily,
                        color: AppColor.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Other',
                    activeColor: AppColor.primaryColor,
                    groupValue: _gender,
                    onChanged: (String? value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                  Text(
                    'Other',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: appFontFamily,
                        color: AppColor.black),
                  ),
                ],
              ),
            ],
          ),
          // Gender Error Message (Red)
          if (_genderError)
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                "Please select your gender.",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: appFontFamily,
                    color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  pickImageFromCameraAndGallery() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setstate) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 1),
                height: 80,
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            await _imgFromCamera();
                            Get.back();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Camera",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            await _imgFromGallery();
                            Get.back();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload, color: Colors.black),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Upload",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  Future _imgFromGallery() async {
    //_image.clear();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    // if (pickedFile != null) {
    //   var _file = File(pickedFile.path);
    //   _image = _file;
    //   tapGallery = true;
    // } else {
    //   print('No image selected.');
    // }

    if (pickedFile != null) {
      // Step 2: Crop the image with a specific aspect ratio
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioLockEnabled: true,
          ),
        ],
      );

      if (croppedFile != null) {
        // Use the cropped image
        setState(() {
          // Update your UI with the cropped image
          _image = File(croppedFile.path);
          tapGallery = true;
        });
      }
    }
    setState(() {});
  }

  Future _imgFromCamera() async {
    //_image.clear();
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);

    // if (pickedFile != null) {
    //   var _file = File(pickedFile.path);
    //   _image = _file;
    //   tapCamera = true;
    // } else {
    //   print('No image selected.');
    // }

    if (pickedFile != null) {
      // Step 2: Crop the image with a specific aspect ratio
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioLockEnabled: true,
          ),
        ],
      );

      if (croppedFile != null) {
        // Use the cropped image
        setState(() {
          // Update your UI with the cropped image
          _image = File(croppedFile.path);
          tapCamera = true;
        });
      }
    }
    setState(() {});
  }

  void profileUpdate() async {
    // Check internet connectivity
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      EasyLoading.showToast("No Internet", dismissOnTap: true,
          duration: const Duration(seconds: 1), toastPosition: EasyLoadingToastPosition.center);
      return; // Exit if no internet connection
    }

    // Form validation
    if (firstNameController.text.trim().isEmpty) {
      EasyLoading.showToast("Please enter your first name.", dismissOnTap: true,
          duration: const Duration(seconds: 1), toastPosition: EasyLoadingToastPosition.center);
      return;
    }

    if (lastNameController.text.trim().isEmpty) {
      EasyLoading.showToast("Please enter your last name.", dismissOnTap: true, duration: const Duration(seconds: 1), toastPosition: EasyLoadingToastPosition.center);
      return;
    }

    if (emailController.text.trim().isEmpty ||
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
            .hasMatch(emailController.text.trim())) {
      EasyLoading.showToast("Please enter a valid email address.", dismissOnTap: true, duration: const Duration(seconds: 1), toastPosition: EasyLoadingToastPosition.center);
      return;
    }

    if (phoneNumberController.text.trim().isEmpty) {
      EasyLoading.showToast("Please enter a valid phone number.", dismissOnTap: true, duration: const Duration(seconds: 1), toastPosition: EasyLoadingToastPosition.center);
      return;
    }

    // Gender validation
    if (_gender == null || _gender!.isEmpty) {
      // Set gender error state
      setState(() {
        _genderError = true;  // This is the only place we update the UI for gender error
      });
      return; // Exit if gender is not selected
    } else {
      setState(() {
        _genderError = false;  // Clear gender error
      });
    }

    // Phone number handling with country code
    String cleanedPhoneNumber = phoneNumberController.text.replaceAll(RegExp(r"\s+"), ""); // Remove any spaces from the phone number
    String countryCode = _phoneNumber?.dialCode ?? '+91'; // Default to '+91' if dialCode is null

    // Preparing params for API call
    Map<String, dynamic> params = Map<String, dynamic>();
    params["last_name"] = lastNameController.text.trim();
    params["first_name"] = firstNameController.text.trim();
    params["email_id"] = emailController.text.trim();
    params["mobile_number"] = cleanedPhoneNumber; // Cleaned phone number
    params["country_code"] = countryCode; // Adding country code
    params["company_name"] = companyController.text.trim();
    params["designation"] = designationController.text.trim();
    params["country"] = selectedCountry;
    params["state"] = selectedState;
    params["city"] = selectedCity;
    params["alumni_of_iit"] = _isAlumni == "Yes" ? true : false;
    params["iit_name"] = iitName;  // Ensure IIT name is added to the request
    params["batch"] = batchController.text.trim();  // Add entered batch
    params["stream"] = streamController.text.trim();  // Add entered stream

    print('Selected IIT: $iitName');
    print('Selected Batch: ${batchController.text.trim()}');
    print('Selected Stream: ${streamController.text.trim()}');
    print('Parameters to API: $params');


    print('Cleaned Phone Number: $cleanedPhoneNumber');
    print('Country Code: $countryCode');

    // Gender parameter
    if (_gender != null) {
      params["gender"] = _gender!;
    }

    print('Cleaned Phone Number: $cleanedPhoneNumber');
    print('Country Code: $countryCode');
    print(params); // Debug log for parameters

    // Call API to update profile with or without image
    if (_image != null) {
      ApiRepo().updateProfile(params, image: _image);
    } else {
      ApiRepo().updateProfile(params);
    }
  }

  /*void profileUpdate() async {
    // Check internet connectivity
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {});
      EasyLoading.showToast("No Internet",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      return; // Exit if no internet connection
    }

    // Form validation
    if (firstNameController.text.trim().isEmpty) {
      EasyLoading.showToast("Please enter your first name.",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      return;
    }

    if (lastNameController.text.trim().isEmpty) {
      EasyLoading.showToast("Please enter your last name.",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      return;
    }

    if (emailController.text.trim().isEmpty ||
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
            .hasMatch(emailController.text.trim())) {
      EasyLoading.showToast("Please enter a valid email address.",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      return;
    }

    // Validate phone number length -> ||
    //         phoneNumberController.text.trim().length != 10
    if (phoneNumberController.text.trim().isEmpty) {
      EasyLoading.showToast("Please enter a valid phone number.",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      return;
    }

    // Gender validation
    if (_gender == null || _gender!.isEmpty) {
      setState(() {
        _genderError = true;
      });
      return; // Exit if gender is not selected
    } else {
      setState(() {
        _genderError = false;
      });
    }

    // Phone number handling with country code
    String cleanedPhoneNumber = phoneNumberController.text.replaceAll(
        RegExp(r"\s+"), ""); // Remove any spaces from the phone number
    String countryCode =
        _phoneNumber?.dialCode ?? '+91'; // Default to '+91' if dialCode is null

    // Preparing params for API call
    Map<String, dynamic> params = Map<String, dynamic>();
    params["last_name"] = lastNameController.text.trim();
    params["first_name"] = firstNameController.text.trim();
    params["email_id"] = emailController.text.trim();
    params["mobile_number"] = cleanedPhoneNumber; // Cleaned phone number
    params["country_code"] = countryCode; // Adding country code
    params["company_name"] = companyController.text.trim();
    params["designation"] = designationController.text.trim();
    params["country"] = selectedCountry;
    params["state"] = selectedState;
    params["city"] = selectedCity;
    params["alumni_of_iit"] = _isAlumni == "Yes" ? true : false;

    print('Cleaned Phone Number: $cleanedPhoneNumber');
    print('Country Code: $countryCode');

    // IIT specific fields if alumni
    if (_isAlumni == "Yes") {
      params["iit_name"] = iitName;
      params["batch"] = batchController.text.trim();
      params["stream"] = streamController.text.trim();
    }

    // Gender
    if (_gender != null) {
      params["gender"] = _gender!;
    }

    print(params); // Debug log to see the params being sent to the API

    // Call API to update profile with or without image
    if (_image != null) {
      ApiRepo().updateProfile(params, image: _image);
    } else {
      ApiRepo().updateProfile(params);
    }
  }*/

/*void profileUpdate() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    // Connectivity check
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
      setState(() {});
      EasyLoading.showToast("No Internet",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      return; // Exit if no internet connection
    }

    // Form validation
    if (firstNameController.text.trim().isEmpty) {
      EasyLoading.showToast("Please enter your first name.",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      return;
    }

    if (lastNameController.text.trim().isEmpty) {
      EasyLoading.showToast("Please enter your last name.",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      return;
    }

    if (emailController.text.trim().isEmpty ||
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(emailController.text.trim())) {
      EasyLoading.showToast("Please enter a valid email address.",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      return;
    }

    if (phoneNumberController.text.trim().isEmpty || phoneNumberController.text.trim().length != 10) {
      EasyLoading.showToast("Please enter a valid phone number.",
          dismissOnTap: true,
          duration: const Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.center);
      return;
    }

    // Gender validation
    if (_gender == null || _gender!.isEmpty) {
      setState(() {
        _genderError = true;
      });
      return;  // Exit if gender is not selected
    } else {
      setState(() {
        _genderError = false;
      });
    }

    // Preparing params for API call
    Map<String, dynamic> params = new Map<String, dynamic>();
    params["last_name"] = lastNameController.text.trim();
    params["first_name"] = firstNameController.text.trim();
    params["email_id"] = emailController.text.trim();
    params["mobile_number"] = phoneNumberController.text.trim();
    params["company_name"] = companyController.text.trim();
    params["designation"] = designationController.text.trim();
    params["country"] = selectedCountry;
    params["state"] = selectedState;
    params["city"] = selectedCity;
    params["alumni_of_iit"] = _isAlumni == "Yes" ? true : false;

    // IIT specific fields if alumni
    if (_isAlumni == "Yes") {
      params["iit_name"] = iitName;
      params["batch"] = batchController.text.trim();
      params["stream"] = streamController.text.trim();
    }

    // Gender
    if (_gender != null) {
      params["gender"] = _gender!;
    }

    print(params);

    // Call API to update profile with or without image
    if (_image != null) {
      ApiRepo().updateProfile(params, image: _image);
    } else {
      ApiRepo().updateProfile(params);
    }
  }*/
}
