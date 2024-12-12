import 'package:vania/vania.dart';

class CreateOrderTable extends Migration {

  @override
  Future<void> up() async{
   super.up();
   await createTableNotExists('order', () {
      integer("order_num",length: 11);
      primary("order_num");
      dateTime("order_date");
      char("cust_id",length: 5);
      foreign("cust_id", "customer", "cust_id");
      timeStamps();
    });
  }
  
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('order');
  }
}
