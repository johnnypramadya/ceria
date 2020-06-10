import 'dart:async';

import 'package:ceria/login/repository/login_repository.dart';
import 'package:ceria/utils/tema.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/Welcome';

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  final Tema tema = Tema();
  final loginRepository = LoginRepository();

  int _state = 0;
  Animation _animation;
  AnimationController _controller;
  GlobalKey _globalKey = GlobalKey();
  double minHeight = 0;
  String phone = '';
  String password = '';
  double _width = 360.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: SlidingUpPanel(
          isDraggable: false,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22.0),
            topRight: Radius.circular(22.0),
          ),
          panel: _buildPanel(context),
          body: _buildBody(context),
          maxHeight: 400,
          minHeight: minHeight,
        ),
      ),
    );
  }

  Widget _buildPanel(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 360,
            margin: const EdgeInsets.only(left: 32, top: 50, right: 32),
            decoration: tema.boxDecorationTextFormField,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: TextFormField(
                textAlign: TextAlign.center,
                maxLength: 15,
                decoration: tema.inputDecorationTextFormField
                    .copyWith(hintText: 'Nomor Telepon'),
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                onChanged: (value) => {
                  setState(() {
                    phone = value;
                  }),
                },
              ),
            ),
          ),
          Container(
            width: 360,
            margin: const EdgeInsets.only(left: 32, top: 20, right: 32),
            decoration: tema.boxDecorationTextFormField,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: TextFormField(
                textAlign: TextAlign.center,
                maxLength: 15,
                decoration: tema.inputDecorationTextFormField
                    .copyWith(hintText: 'Password'),
                obscureText: true,
                onChanged: (value) => {
                  setState(() {
                    password = value;
                  }),
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: PhysicalModel(
              elevation: 8,
              color: (phone.isNotEmpty && password.isNotEmpty)
                  ? tema.colorAqua
                  : Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(28.0)),
              child: Container(
                key: _globalKey,
                height: 48,
                width: _width,
                child: RaisedButton(
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28.0)),
                  ),
                  elevation: 4.0,
                  color: (phone.isNotEmpty && password.isNotEmpty)
                      ? tema.colorAqua
                      : Colors.grey,
                  child: setUpButton(),
                  onPressed: () async {
                    _showDialog(bool status) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildAlertDialog(context, status),
                      );
                    }

                    if (phone.isNotEmpty && password.isNotEmpty) {
                      setState(() {
                        if (_state == 0) animateButtontoLoading();
                      });

                      if (await loginRepository.login(phone, password)) {
                        animateButtontoNormal();
                        _showDialog(true);
                      } else {
                        animateButtontoNormal();
                        _showDialog(false);
                      }
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Lupa password?'),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Belum punya akun?'),
              SizedBox(
                width: 4,
              ),
              Text(
                'Daftar disini',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: tema.colorUtama,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 200,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Clean Home',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            Text(
              'Clean Life.',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 60,
              ),
              child: Text(
                'Book Cleaners at the Comfort of you home.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SvgPicture.asset(
              'assets/images/login.svg',
              height: 280,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  minHeight = 400;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(22.0)),
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Get Started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: tema.colorUtama,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertDialog(BuildContext context, bool status) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 100,
      ),
      child: AlertDialog(
        content: Center(
          child: Text(
            (status) ? 'Sukses' : 'Gagal',
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    if (minHeight == 400) {
      setState(() {
        minHeight = 0;
      });
      return false;
    } else {
      return true;
    }
  }

  setUpButton() {
    if (_state == 0) {
      return Text(
        'Login',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      );
    } else if (_state == 1) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
  }

  void animateButtontoNormal() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.1, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = 360.0 * _animation.value;
        });
      });
    _controller.forward();

    Timer(Duration(milliseconds: 500), () {
      setState(() {
        _state = 0;
      });
    });
  }

  void animateButtontoLoading() {
    double initialWidth = _globalKey.currentContext.size.width;
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48) * _animation.value);
        });
      });
    _controller.forward();

    setState(() {
      _state = 1;
    });
  }
}
