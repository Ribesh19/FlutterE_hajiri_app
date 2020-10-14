import 'package:e_hajiri_app/components/CustomSuffixIcon.dart';
import 'package:e_hajiri_app/components/DefaultButton.dart';
import 'package:e_hajiri_app/components/form_error.dart';
import 'package:e_hajiri_app/constants.dart';
import 'package:e_hajiri_app/models/UsersJson.dart';
import 'package:e_hajiri_app/screens/administations/adminDashboard.dart';
import 'package:e_hajiri_app/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.08),
              Text(
                "Welcome Back",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: (28/375.0)*size.width,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Sign in with your email and password",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.08),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding*1.5),
                child: LoginForm(),
              ),
              SizedBox(height: size.height * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  bool admin = false;
  bool validUser = false;
  final List<String> errors = [];
  List<Users> userList;

  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();
  bool permissionStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getinitalpermission();
    getAllRequiredPermissions();
    getUserlist();
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: (30 / 812.0) * size.height),
          buildPasswordFormField(),
          SizedBox(height: (30 / 812.0) * size.height),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
//                onTap: () => Navigator.pushNamed(
//                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(height: (30 / 812.0) * size.height * 0.05),
          Row(
            children: [
              Switch(
                  value: admin,
                  activeColor: kSecondaryColor,
                  onChanged: (value) {
                    setState(() {
                      admin = value;
                    });
                  }),
              Text("Administrator"),
              Spacer(),
            ],
          ),

          FormError(errors: errors),
          SizedBox(height: (20 / 812.0) * size.height),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                validatelogin();
                _formKey.currentState.save();
                // if all are valid then go to success screen
//                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordInput,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailInput,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  void getAllRequiredPermissions() async
  {
    var status = await Permission.location.status;
    if (status.isGranted == true) {
      permissionStatus = true;
    }
    if (status.isUndetermined == true) {
      // We didn't ask for permission yet.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        //Permission.notification,
      ].request();
      print(statuses[Permission.location]);
      if (statuses[Permission.location].isGranted == true) {
        permissionStatus = true;
      }
    }
// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      openAppSettings();
    }
    if (await Permission.location.isDenied == true) {
      // You can request multiple permissions at once.
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        //Permission.notification,
      ].request();
      print(statuses[Permission.location]);
      if (statuses[Permission.location].isGranted == true) {
        permissionStatus = true;
      }
    }
    if (await Permission.location.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
  }

  void getinitalpermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      //Permission.notification,
    ].request();
    print(statuses[Permission.location]);
    if (statuses[Permission.location].isGranted == true) {
      permissionStatus = true;
    }
  }

  Future<List<Users>> getUserlist() async {

    final List<Users> _UserList = await getAllusersList();
    setState(() {
      userList = _UserList;
    });
    return userList;

  }
  void  validatelogin() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (final user in userList)
      {
        if(user.email.toLowerCase().trim() == emailInput.text.toLowerCase().trim())
          {
//            if(remember == true) {
//              prefs.setString('UserId', user.id);
//              prefs.setString('Username', user.name);
//              prefs.setBool('IsAdmin', admin);
//            }
          prefs.setString('UserId', user.id);
          prefs.setString('Username', user.name);
          prefs.setBool('IsAdmin', admin);
//            setState(() {
//              validUser = true;
//            });
            if (permissionStatus == true) {
                admin ?
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminDashboard(),
                    ), (route) => false
                ) : Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardScreen(Username: user.name,UserId: user.id ),),
                        (route) => false);

            }
          }
        else
        {
          final snackBar =
          SnackBar(
              content: Text("Invalid User"));
          Scaffold.of(context).showSnackBar(snackBar);
        }
      }
  }
}
