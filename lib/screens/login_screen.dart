import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_mobile_app/shared/config.dart';


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController deviceKey = TextEditingController();

  bool _autoValidate = false;
  bool _obscureText = true;
  bool isLoading = false;
  bool isOnlineDataLoaded = false;

  // bool isLogin = false;
  bool _deviceKeyPresent = false;
  bool _deviceKeyCheck = false;
  Icon _icon = Icon(Icons.visibility_off);
  String errorEmail = 'Invalid Email', errorPassword = 'Invalid Password';
  Color activeColor = Colors.yellow[700];

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _icon =
          _obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Container(
                // margin: EdgeInsets.all(8.0),
                height: Config.getDeviceHeight(context),
                width: Config.getDeviceWidth(context),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: Config.getDeviceHeight(context),
                      width: Config.getDeviceWidth(context) * 0.4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.amber,
                            Colors.redAccent,
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.horizontal(
                          right:
                              Radius.circular(Config.getDeviceHeight(context)),
                        ),
                        color: Colors.amber,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/logo1.png',
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(10, 10),
                                        color: Colors.grey[300],
                                        blurRadius: 20),
                                    BoxShadow(
                                        offset: Offset(-10, -10),
                                        color: Colors.grey[300],
                                        blurRadius: 20)
                                  ],
                                ),
                                child: Form(
                                  key: _formKey,
                                  autovalidate: _autoValidate,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Config.activeStatus',
                                            style: GoogleFonts.ubuntuCondensed(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                                letterSpacing: 1.0,
                                                color: activeColor),
                                          ),
                                          Switch(
                                            // value: Config.isSwitched,
                                            // onChanged: _onSwitchTap,
                                            activeTrackColor:
                                                Colors.yellowAccent[600],
                                            activeColor: Colors.yellow[700],
                                            inactiveTrackColor:
                                                Colors.grey[200],
                                            inactiveThumbColor: Colors.grey,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[100]))),
                                              child: TextField(
                                                enabled: !_deviceKeyPresent,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: 'Device Key',
                                                  labelStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                  ),
                                                  errorText:
                                                      deviceKey.text != ''
                                                          ? null
                                                          : 'Required',
                                                ),
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: deviceKey,
                                              ),
                                            ),
                                          ),
                                          FlatButton(
                                            child: Text('SUBMIT'),
                                            onPressed: null,
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[100]))),
                                        child: TextFormField(
                                          enabled: _deviceKeyPresent,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            labelText: 'loginModel.hintEmail',
                                            labelStyle: TextStyle(
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          onFieldSubmitted: (value) {
                                            FocusScope.of(context).nextFocus();
                                          },
                                          validator: (value) {
                                            if (value.isEmpty ||
                                                !value.contains('@')) {
                                              return errorEmail;
                                            }
                                            return null;
                                          },
                                          controller: email,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                              child: TextFormField(
                                                enabled: _deviceKeyPresent,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText:
                                                      'loginModel.hintPassword',
                                                  labelStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                  ),
                                                ),
                                                obscureText: _obscureText,
                                                textInputAction:
                                                    TextInputAction.done,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                onFieldSubmitted: (value) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                controller: password,
                                                validator: (value) {
                                                  if (value.isEmpty ||
                                                      value.length <= 0) {
                                                    return errorPassword;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Positioned(
                                              right: 5,
                                              child: IconButton(
                                                icon: _icon,
                                                color: Colors.grey,
                                                onPressed: _toggle,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.redAccent,
                                      Colors.amber,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(10, 10),
                                        color: Colors.grey[300],
                                        blurRadius: 20),
                                    BoxShadow(
                                        offset: Offset(-10, -10),
                                        color: Colors.grey[300],
                                        blurRadius: 20)
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.yellow[100],
                                    onTap: null,
                                    child: Center(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
