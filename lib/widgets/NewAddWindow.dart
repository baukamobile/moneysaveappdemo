
import 'package:flutter/material.dart';
import 'package:moneyapp/models/expence.dart';
class NewWindow extends StatefulWidget {
  const NewWindow({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewWindow> createState() => _NewWindowState();
}

class _NewWindowState extends State<NewWindow> {
  final _titleController = TextEditingController();
  final _enteredAmountController= TextEditingController();
  DateTime? selectedDate; 
  Category selectedCategory = Category.airplane;


  void _submitFormExpense(){

    final enterAmount = double.tryParse(_enteredAmountController.text); 
    final amountIsInvalid = enterAmount == null || enterAmount<=0;
    if(
      _titleController.text.trim().isEmpty || amountIsInvalid || selectedCategory == null
    ){
      showDialog(context: context,
       builder: ((ctx) => AlertDialog(
        title: const Text("Error"),
        content:  Text("Please write correct input!"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancel")),
          SizedBox(width: 30,),
        
        ],
       ))
       );
       return;
    }
    widget.onAddExpense(Expense(
      title: _titleController.text,
       amount: enterAmount, date: selectedDate!,
        category: selectedCategory));
        Navigator.pop(context);
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
  void presentDatePicker() async{
    final now = DateTime.now();
    final firstdate = DateTime(now.year-1, now.month, now.day);
    final pickeDate = await showDatePicker(
      
    context: context,
    initialDate: now,
    firstDate: firstdate,
    lastDate: now,
    
    
    builder: (context, child) => Theme(
      data: ThemeData(
      colorScheme: ColorScheme.light(
        primary: Color.fromARGB(255, 71, 186, 130),
      ),
      
    ), child:child! 
    ),
    
    
    );
    setState(() {
      selectedDate = pickeDate;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      decoration: BoxDecoration(
        
        color: Colors.white,
        
        ),
        
      width: double.maxFinite,
      height: 600,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 300,
              height: 80,
              child: TextField(
                controller: _titleController,
                // onChanged: _saveTitleInput,
                decoration: InputDecoration(
                  labelText: 'Reason',
          
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                maxLength: 50,
                keyboardType: TextInputType.text,
                
              ),
            ),
          ),
       Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  height: 80,
                  child: TextField(
                    controller: _enteredAmountController,
                    // onChanged: _saveTitleInput,
                    decoration: InputDecoration(
                      labelText: 'amount',
                      prefixText: '\$ ',
                      
          
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    maxLength: 50,
                    keyboardType: TextInputType.number,
                    
                  ),
                ),
             Row(
               children: [
                 Text( selectedDate == null ? 'date' : formatter.format(selectedDate!),
                  style: TextStyle(fontSize: 20),),
                 IconButton(onPressed: (){
                  presentDatePicker();
                 }, icon: Icon(Icons.date_range, size: 35,))
               ],
             ),
    
              ],
            ),
          ),
        Padding(
    padding: const EdgeInsets.only(right: 20, left: 8),
    child: DropdownButton<Category>(
    value: selectedCategory, // Use the selectedCategory variable
    items: Category.values.map((category) {
      return DropdownMenuItem<Category>(
        value: category,
        child: Text(category.name.toUpperCase()),
      );
    }).toList(),
    onChanged: (value) {
      setState(() {
        selectedCategory = value!; // Update selectedCategory with the new value
        print(selectedCategory.name.toUpperCase());
    
      });
    },
    ),
    ),
    
        
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios_new)),
              SizedBox(width: 100,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 71, 186, 130),
                ),
                
                onPressed: (){
                // enterTitle;
                // print("Hello");
                
                  _submitFormExpense();
                
                print(_titleController.text);
              }, child: Text("Save Changes",), ),
            ],
          )
         
        ],
      ),
    );
  }
}