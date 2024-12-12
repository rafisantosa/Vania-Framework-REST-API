import 'package:vania/vania.dart';

class CreateProductTable extends Migration {

  @override
  Future<void> up() async{
   super.up();
   await createTableNotExists('product', () {
      string("prod_id",length: 10);
      primary("prod_id");
      string("prod_name",length: 25);
      integer("prod_price",length: 11);
      text("prod_desc");
      char("vend_id",length: 5);
      foreign("vend_id", "vendor", "vend_id");
      timeStamps();
    });
  }
  
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('product');
  }
}
