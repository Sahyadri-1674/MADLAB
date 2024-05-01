import 'package:flutter/material.dart';
import 'confirmation_page.dart';
import 'main.dart';

class OrderPage extends StatefulWidget {
  final String productName;
  final String price;
  final String type;

  OrderPage({
    required this.productName,
    required this.price,
    required this.type,
  });

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController _quantityController = TextEditingController();
  DateTime? _selectedDate; // Store the selected date

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Products'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Order'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Confirmation Page'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(
                      productName: widget.productName,
                      price: widget.price,
                      type: widget.type,
                      quantity: _quantityController.text,
                      orderDate: _selectedDate != null ? _selectedDate!.toString() : '',
                      // Pass selected date as a string to ConfirmationPage
                      address: '', // Update with the address
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  'Order Date:',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(width: 12.0),
                _selectedDate != null
                    ? Text(
                        '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        style: TextStyle(fontSize: 16.0),
                      )
                    : TextButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text(
                          'Select Date',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Address',
              ),
              onChanged: (value) {
                // Update address if needed
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back
                  },
                  child: Text('Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationPage(
                          productName: widget.productName,
                          price: widget.price,
                          type: widget.type,
                          quantity: _quantityController.text,
                          orderDate: _selectedDate != null ? _selectedDate!.toString() : '',
                          address: '', // Update with the address
                        ),
                      ),
                    );
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }
}
