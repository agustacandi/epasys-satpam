import 'package:intl/intl.dart';

class Functions {
  String convertDateTime(DateTime date) {
    DateFormat format = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
    String dateFormated = format.format(date);
    return dateFormated;
  }

  String convertDateTime2(DateTime date) {
    DateFormat format = DateFormat('dd MMMM yyyy', 'id_ID');
    String dateFormated = format.format(date);
    return dateFormated;
  }

  String convertDateTime3(DateTime date) {
    DateFormat format = DateFormat('hh:mm', 'id_ID');
    String dateFormated = format.format(date);
    return dateFormated;
  }

  String convertDateTime4(DateTime date) {
    DateFormat format = DateFormat('ddMMyyhhmm', 'id_ID');
    String dateFormated = format.format(date);
    return dateFormated;
  }
}
