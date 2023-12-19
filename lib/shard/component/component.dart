import 'package:flutter/material.dart';
import 'package:Tasks/shard/cubit/cubit.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required String text,
  IconData? icon,
  bool isCleckable=true,
  VoidCallback? onTap,
 String? Function(String?)? validator,
  TextInputType keyboardType = TextInputType.text,
})=>
  TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    enabled: isCleckable,
    onTap: onTap,
    validator: validator,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: text,
      hintText: text,
      prefixIcon: Icon(icon),
    ),
  );


Widget buildTaskItem(context,int id,String title,String time,String date){
  return Dismissible(
    key: Key('$id'),
    onDismissed: (direction){
      AppCubit.getInstance(context).deleteDataInDatabase(id: id);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 40.0,
            child: Text(
              "$time",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold
                  ) ,
                ),
                Text(
                  "$date",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey
                  ) ,
                ),
    
              ],
            ),
          ),
          SizedBox(width: 20.0,),
          IconButton(
            color: Colors.green,
              onPressed: (){
                AppCubit.getInstance(context).updateDataInDatabase(
                    state: 'done',
                    id: id);
              },
              icon: Icon(Icons.check_box)),
          IconButton(
              color: Colors.black45,
              onPressed: (){
                AppCubit.getInstance(context).updateDataInDatabase(
                    state: 'archive',
                    id: id);
              },
              icon: Icon(Icons.archive)),
        ],
      ),
    ),
  );
}