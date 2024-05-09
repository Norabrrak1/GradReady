import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

String  ? type ;
String  ? uId = '' ;
String  ? token ;


// String  ? uId = 'start' ;
// String  ? request = 'start' ;

 todayDate (){
   String? dateOfToday;
   var now = DateTime.now();
   var formatter =
   DateFormat('yyyy-MM-dd');
   dateOfToday =
       formatter.format(now);
   if (kDebugMode) {
     print(dateOfToday);
   }
   return dateOfToday;
 }

 List<String> hours = [
   '9:00 Am',
   '10:00 Am',
   '11:00 Am',
   '12:00 Pm',
   '1:00 Pm',
   '2:00 Pm',
   '3:00 Pm',
   '4:00 Pm',
   '5:00 Pm',
   '6:00 Pm',
   '7:00 Pm',
   '8:00 Pm',
   '9:00 Pm',
   '10:00 Pm',
 ];
