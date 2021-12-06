import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTODO extends StatefulWidget {
  final Function addTODO;
  const AddNewTODO(this.addTODO, {Key? key}) : super(key: key);

  @override
  State<AddNewTODO> createState() => _AddNewTODOState();
}

class _AddNewTODOState extends State<AddNewTODO> {
  final _nameController = TextEditingController();
  DateTime? _selectedDate;

  void _submitDate() {
    final enteredName = _nameController.text;
    if (enteredName.isEmpty || _selectedDate == null) {
      return;
    }

    widget.addTODO(DateTime.now().toString(), enteredName, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(DateTime.now().year + 2),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5.0,
        margin: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(15.0),
              child: const Text(
                'Add a new TODO: ',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              child: TextField(
                onSubmitted: (_) => _submitDate(),
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                controller: _nameController,
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextButton.icon(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                      ),
                    ),
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.date_range_rounded),
                    label: const Text('Choose date: '),
                  ),
                ),
                Text(
                  _selectedDate == null
                      ? 'No date choosen!'
                      : 'Picked date: ${DateFormat('yyyy/MM/dd').format(_selectedDate!)}',
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: _submitDate,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Add new TODO'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ThemeData().errorColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
