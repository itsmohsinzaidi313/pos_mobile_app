import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pos_mobile_app/bloc/shift_bloc/shift_bloc.dart';
import 'package:pos_mobile_app/screens/login_screen.dart';

class ShiftScreen extends StatefulWidget {
  @override
  _ShiftScreen createState() => _ShiftScreen();
}

class _ShiftScreen extends State<ShiftScreen> {

  final _dropdownFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<ShiftBloc>().add(GettingShifts());

    _dropdownFocusNode.addListener(() {
      if (!_dropdownFocusNode.hasFocus) {
        context.read<ShiftBloc>().add(ShiftUnfocused());
        FocusScope.of(context).requestFocus(_amountFocusNode);
      }
    });

    _amountFocusNode.addListener(() {
      if (!_amountFocusNode.hasFocus) {
        context.read<ShiftBloc>().add(AmountUnfocused());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Shift'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
      ),
      body: BlocListener<ShiftBloc, MyShiftState>(
        // listenWhen: (previousState, currentState) =>
        // (previousState.status != currentState.status),
        listener: (context, state) {
          if(state.status.isSubmissionInProgress){
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Progressing...')),
              );
          }
          if(state.status.isSubmissionSuccess){
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Submission Successful!')),
              );
            Navigator.pushReplacementNamed(context, '/dashboardScreen');

          }
          if(state.status.isSubmissionFailure){
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Submission Failed!')),
              );
          }
          if(state is ShiftError){
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                 SnackBar(content: Text('${state.error.toString()}')),
              );
          }
        },
        child: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 90.0,
                      backgroundColor: Colors.yellow[600],
                      child: CircleAvatar(
                        radius: 80.0,
                        backgroundImage: AssetImage('assets/money-bag.jpg'),
                      ),
                    ),
                  ),
                ),
                bodyLayoutController(layoutType: 1),
              ]),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingButton(layoutType: 1,),
    );
  }

  Widget bodyLayoutController({int layoutType}) {
    switch (layoutType) {
      case 1:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Form(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Select Shift',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          DropdownSelection(focusNode: _dropdownFocusNode),
                        ],
                      ),
                    ),
                    AmountInput(focusNode: _amountFocusNode),
                  ],
                ),
              ),
            ),
          ),
        );
        break;
      case 2:
        return Container(
          // padding: EdgeInsets.all(10.0),
          // margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
          ),
          // width: Config.getDeviceWidth(context) * 0.4,
          child: Wrap(
            children: [
              Container(
                child: Card(
                  color: Colors.grey[100],
                  child: ListTile(
                    leading: Icon(
                      Icons.monetization_on,
                      color: Colors.grey[600],
                    ),
                    title: TextField(
                      keyboardType: TextInputType.number,
                      // controller: closingAmount,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.amberAccent, width: 1),
                        ),
                        hintText: 'Closing Amount',
                        // errorText: checkField ? errorMessage : null),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      default:
        return Container(
          child: Text('Invalid Layout Type'),
        );
        break;
    }
  }

/*
  Widget floatingButtonLayoutController({int layoutType}) {
    switch (layoutType) {
      case 1:
        return FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.check),
          backgroundColor: Colors.yellow[600],
        );
        break;
      case 2:
        return FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.close),
          backgroundColor: Colors.yellow[600],
        );
        break;
      default:
        return Container();
        break;
    }
  }
*/
}

class FloatingButton extends StatelessWidget {

  final int layoutType;

  FloatingButton({ this.layoutType});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftBloc, MyShiftState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: state.status.isValidated ?
              () => context.read<ShiftBloc>()
                  .add(ShiftSubmitted(layoutType: layoutType)) : null,
          child: Icon(
            layoutType == 1 ? Icons.check : Icons.close,
            color: Colors.white,
          ),
          backgroundColor: Colors.yellow[600],
        );
      },
    );
  }
}


class AmountInput extends StatelessWidget {

  final FocusNode focusNode;

  AmountInput({this.focusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftBloc, MyShiftState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Amount",
              errorText: state.amount.invalid
                  ? 'Please ensure that the amount entered is valid'
                  : null,
              prefixIcon: Icon(
                Icons.attach_money,
                size: 20,
                color: Colors.amber,
              ),
              hintText: "1000",
              helperText: 'Amount value must be valid e.g, 1000',
              hintStyle: TextStyle(
                color: Colors.grey[300],
              ),
              labelStyle: TextStyle(
                color: Colors.grey[400],
              ),
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              context.read<ShiftBloc>().add(AmountChanged(amount: value));
            },
            focusNode: focusNode,
            autofocus: false,
            // controller: openingAmount,
          ),
        );
      },
    );
  }
}

class DropdownSelection extends StatelessWidget {

  final FocusNode focusNode;

  DropdownSelection({this.focusNode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftBloc, MyShiftState>(
      builder: (context, state) {
        return DropdownButton<String>(
          icon: Icon(Icons.arrow_drop_down_circle),
          iconSize: 24,
          elevation: 16,
          value: state.shift.value,
          focusNode: focusNode,
          isExpanded: true,
          style: TextStyle(
            color: Colors.grey[700],
          ),
          onChanged: (newValue) {
            context.read<ShiftBloc>().add(ShiftChanged(shift: newValue));
          },
          items: state.dropDownMenuList,
        );
      },
    );
  }
}
