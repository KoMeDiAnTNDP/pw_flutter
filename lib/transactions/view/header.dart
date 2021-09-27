import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Widget _createTile(String title) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.secondaryVariant,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                )
              )
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RawMaterialButton(
                  onPressed: () => print('test'),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  shape: CircleBorder(),
                  child: Icon(Icons.add),
                )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _createTile('Date/Time of the transaction'),
              _createTile('Correspondent Name'),
              _createTile('Transaction amount'),
              _createTile('Resulting balance'),
            ],
          ),
        ],
      ),
    );
  }
}
