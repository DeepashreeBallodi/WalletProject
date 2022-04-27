import 'package:flutter/material.dart';

List<Widget> navBarIcons() {
  return <Widget>[
    Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Icon(
        Icons.dashboard,
        size: 180,
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Icon(
        Icons.account_balance_wallet_outlined,
        size: 180,
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Icon(
        Icons.history,
        size: 180,
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Icon(
        Icons.perm_identity_outlined,
        size: 180,
      ),
    )
  ];
}
