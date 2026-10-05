import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const FarmerSubsidyApp());
}

class FarmerSubsidyApp extends StatelessWidget {
  const FarmerSubsidyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farmer Subsidy Portal',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F8F5),
      ),
      home: const FarmerSubsidyPage(),
    );
  }
}

class FarmerSubsidyPage extends StatefulWidget {
  const FarmerSubsidyPage({Key? key}) : super(key: key);

  @override
  State<FarmerSubsidyPage> createState() => _FarmerSubsidyPageState();
}

class _FarmerSubsidyPageState extends State<FarmerSubsidyPage> {
  final nameController = TextEditingController();
  final aadhaarController = TextEditingController();
  final mobileController = TextEditingController();
  final villageController = TextEditingController();
  final landController = TextEditingController();
  final accountController = TextEditingController();
  final ifscController = TextEditingController();

  String? selectedState;
  String? selectedDistrict;
  String? selectedCrop;
  String? selectedScheme;

  bool declarationChecked = false;

  final List<String> states = [
    'Andhra Pradesh',
    'Telangana',
    'Tamil Nadu',
    'Karnataka',
    'Kerala',
    'Maharashtra',
    'Odisha',
  ];

  final Map<String, List<String>> districts = {
    'Andhra Pradesh': [
      'Bhimavaram',
      'Eluru',
      'Guntur',
      'Krishna',
      'Nellore',
      'Prakasam',
      'Vijayawada',
      'Visakhapatnam',
    ],
    'Telangana': [
      'Hyderabad',
      'Warangal',
      'Karimnagar',
      'Nizamabad',
      'Khammam',
    ],
    'Tamil Nadu': [
      'Chennai',
      'Coimbatore',
      'Madurai',
      'Salem',
      'Tiruchirappalli',
    ],
    'Karnataka': [
      'Bengaluru',
      'Mysuru',
      'Mangaluru',
      'Hubballi',
      'Belagavi',
    ],
    'Kerala': [
      'Kochi',
      'Thiruvananthapuram',
      'Kozhikode',
      'Thrissur',
      'Kollam',
    ],
    'Maharashtra': [
      'Mumbai',
      'Pune',
      'Nagpur',
      'Nashik',
      'Aurangabad',
    ],
    'Odisha': [
      'Bhubaneswar',
      'Cuttack',
      'Puri',
      'Ganjam',
      'Balasore',
    ],
  };

  final List<String> crops = [
    'Rice',
    'Wheat',
    'Maize',
    'Cotton',
    'Sugarcane',
    'Groundnut',
    'Vegetables',
    'Pulses',
  ];

  final List<String> schemes = [
    'PM-KISAN',
    'Crop Subsidy Scheme',
    'Fertilizer Subsidy',
    'Seed Subsidy',
    'Irrigation Subsidy',
    'Farm Equipment Subsidy',
  ];

  @override
  void dispose() {
    nameController.dispose();
    aadhaarController.dispose();
    mobileController.dispose();
    villageController.dispose();
    landController.dispose();
    accountController.dispose();
    ifscController.dispose();
    super.dispose();
  }

  void showMessage(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  bool validateForm() {
    final name = nameController.text.trim();
    final aadhaar = aadhaarController.text.trim();
    final mobile = mobileController.text.trim();
    final village = villageController.text.trim();
    final land = landController.text.trim();
    final account = accountController.text.trim();
    final ifsc = ifscController.text.trim().toUpperCase();

    if (name.isEmpty) {
      showMessage('Please enter farmer name');
      return false;
    }

    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
      showMessage('Farmer name should contain only letters');
      return false;
    }

    if (aadhaar.length != 12 || !RegExp(r'^[0-9]+$').hasMatch(aadhaar)) {
      showMessage('Aadhaar must contain exactly 12 digits');
      return false;
    }

    if (mobile.length != 10 || !RegExp(r'^[6-9][0-9]{9}$').hasMatch(mobile)) {
      showMessage('Enter a valid 10-digit mobile number');
      return false;
    }

    if (selectedState == null) {
      showMessage('Please select state');
      return false;
    }

    if (selectedDistrict == null) {
      showMessage('Please select district');
      return false;
    }

    if (village.isEmpty) {
      showMessage('Please enter village name');
      return false;
    }

    final landValue = double.tryParse(land);

    if (land.isEmpty || landValue == null || landValue <= 0) {
      showMessage('Enter a valid land area');
      return false;
    }

    if (selectedCrop == null) {
      showMessage('Please select crop');
      return false;
    }

    if (account.length < 9 ||
        account.length > 18 ||
        !RegExp(r'^[0-9]+$').hasMatch(account)) {
      showMessage('Account number must contain 9 to 18 digits');
      return false;
    }

    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(ifsc)) {
      showMessage('Enter a valid IFSC code');
      return false;
    }

    if (selectedScheme == null) {
      showMessage('Please select subsidy scheme');
      return false;
    }

    if (!declarationChecked) {
      showMessage('Please accept the declaration');
      return false;
    }

    return true;
  }

  void submitApplication() {
    if (!validateForm()) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text('Application Submitted'),
              ),
            ],
          ),
          content: const Text(
            'Your farmer subsidy application has been submitted successfully.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void resetForm() {
    nameController.clear();
    aadhaarController.clear();
    mobileController.clear();
    villageController.clear();
    landController.clear();
    accountController.clear();
    ifscController.clear();

    setState(() {
      selectedState = null;
      selectedDistrict = null;
      selectedCrop = null;
      selectedScheme = null;
      declarationChecked = false;
    });

    showMessage(
      'Form has been reset',
      success: true,
    );
  }

  Widget sectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 15,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.green.shade800,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget inputField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? formatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: formatters,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: Colors.green,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget dropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        onChanged: enabled ? onChanged : null,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: enabled ? Colors.green : Colors.grey,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Farmer Subsidy Portal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade800,
                      Colors.green.shade500,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.agriculture,
                      size: 60,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Farmer Subsidy Application',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Apply for government agricultural subsidies',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // FORM
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // FARMER DETAILS
                    sectionTitle(
                      'Farmer Details',
                      Icons.person,
                    ),

                    inputField(
                      label: 'Farmer Name',
                      hint: 'Enter your full name',
                      icon: Icons.person_outline,
                      controller: nameController,
                    ),

                    inputField(
                      label: 'Aadhaar Number',
                      hint: 'Enter 12-digit Aadhaar number',
                      icon: Icons.badge_outlined,
                      controller: aadhaarController,
                      keyboardType: TextInputType.number,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(12),
                      ],
                    ),

                    inputField(
                      label: 'Mobile Number',
                      hint: 'Enter 10-digit mobile number',
                      icon: Icons.phone_outlined,
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),

                    // ADDRESS
                    sectionTitle(
                      'Address Details',
                      Icons.location_on,
                    ),

                    dropdownField(
                      label: 'State',
                      hint: 'Select your state',
                      icon: Icons.map_outlined,
                      value: selectedState,
                      items: states,
                      onChanged: (value) {
                        setState(() {
                          selectedState = value;
                          selectedDistrict = null;
                        });
                      },
                    ),

                    dropdownField(
                      label: 'District',
                      hint: selectedState == null
                          ? 'Select state first'
                          : 'Select your district',
                      icon: Icons.location_city,
                      value: selectedDistrict,
                      items: selectedState == null
                          ? []
                          : districts[selectedState] ?? [],
                      enabled: selectedState != null,
                      onChanged: (value) {
                        setState(() {
                          selectedDistrict = value;
                        });
                      },
                    ),

                    inputField(
                      label: 'Village',
                      hint: 'Enter village name',
                      icon: Icons.home_work_outlined,
                      controller: villageController,
                    ),

                    // FARM DETAILS
                    sectionTitle(
                      'Farm Details',
                      Icons.agriculture,
                    ),

                    inputField(
                      label: 'Land Area',
                      hint: 'Enter land area in acres',
                      icon: Icons.landscape_outlined,
                      controller: landController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),

                    dropdownField(
                      label: 'Crop',
                      hint: 'Select crop',
                      icon: Icons.grass,
                      value: selectedCrop,
                      items: crops,
                      onChanged: (value) {
                        setState(() {
                          selectedCrop = value;
                        });
                      },
                    ),

                    // BANK DETAILS
                    sectionTitle(
                      'Bank Details',
                      Icons.account_balance,
                    ),

                    inputField(
                      label: 'Account Number',
                      hint: 'Enter bank account number',
                      icon: Icons.account_balance_wallet_outlined,
                      controller: accountController,
                      keyboardType: TextInputType.number,
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(18),
                      ],
                    ),

                    inputField(
                      label: 'IFSC Code',
                      hint: 'Example: SBIN0001234',
                      icon: Icons.account_balance_outlined,
                      controller: ifscController,
                      formatters: [
                        UpperCaseFormatter(),
                        LengthLimitingTextInputFormatter(11),
                      ],
                    ),

                    // SUBSIDY
                    sectionTitle(
                      'Subsidy Details',
                      Icons.currency_rupee,
                    ),

                    dropdownField(
                      label: 'Subsidy Scheme',
                      hint: 'Select subsidy scheme',
                      icon: Icons.card_giftcard,
                      value: selectedScheme,
                      items: schemes,
                      onChanged: (value) {
                        setState(() {
                          selectedScheme = value;
                        });
                      },
                    ),

                    // DECLARATION
                    sectionTitle(
                      'Declaration',
                      Icons.fact_check,
                    ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.green.shade200,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: declarationChecked,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                declarationChecked = value ?? false;
                              });
                            },
                          ),
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 12),
                              child: Text(
                                'I hereby declare that the information '
                                'provided by me is true and correct to '
                                'the best of my knowledge.',
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // BUTTONS
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: OutlinedButton.icon(
                              onPressed: resetForm,
                              icon: const Icon(Icons.refresh),
                              label: const Text(
                                'Reset',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.green.shade700,
                                side: BorderSide(
                                  color: Colors.green.shade700,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton.icon(
                              onPressed: submitApplication,
                              icon: const Icon(Icons.send),
                              label: const Text(
                                'Submit Application',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade700,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Center(
                      child: Text(
                        'All fields are required',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Farmer Subsidy Portal',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
