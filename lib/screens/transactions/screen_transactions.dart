import 'package:flutter/material.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});
  

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(15.0),
      itemBuilder: (context,index){
      

      return const Card(child: ListTile(
        leading: CircleAvatar(radius: 35.0 ,child: Text('12\nJan',textAlign: TextAlign.center,),),
        title: Text('Rs 10,000'),
        subtitle: Text('Category'),
      ),);

    }, separatorBuilder: (context,index){
      return const SizedBox(height: 15.0,);

    }, itemCount: 10);
  }
}