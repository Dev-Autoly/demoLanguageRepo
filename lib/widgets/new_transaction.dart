import 'package:flutter/material.dart';

import '../app_localizations.dart';

class NewTransaction extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Function addTransaction;
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  final _priceController = TextEditingController();

  NewTransaction(this.addTransaction);


  bool validateForm(){
    final form = _formKey.currentState;
    if(form.validate()){
      print("#### FORM VALIDATED ####");
      return true;
    }
    print("#### FORM VALIDATE FAILED ###");
    return false;

  }

  void submitData(){
    if(validateForm()){
      addTransaction(
          _titleController.text,
          _detailsController.text,
          double.parse(_priceController.text)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
                decoration: InputDecoration(labelText: AppLocalizations.of(context)
                    .translate('new_item')),
                validator: (value) => value.isEmpty ? AppLocalizations.of(context)
                    .translate('new_item_form_error') : null,
                controller: _titleController,
              ),
              TextFormField(
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(labelText: AppLocalizations.of(context)
                    .translate('details')),
                validator: (value) => value.isEmpty ? AppLocalizations.of(context)
                    .translate('details_form_error') : null,
                controller: _detailsController,
              ),
              TextFormField(
                style: TextStyle(fontSize: 15),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "${AppLocalizations.of(context)
                    .translate('price')}"),
                validator: (value) => value.isEmpty ? AppLocalizations.of(context)
                    .translate('price_form_error') : null,
                controller: _priceController,
              ),
              RaisedButton(
                padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
                color: Theme.of(context).primaryColorLight,
                child: Text(
                  AppLocalizations.of(context)
                      .translate('add_transaction'),
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
