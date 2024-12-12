import 'dart:io';
import 'package:vania/vania.dart';
import 'create_product_table.dart';
import 'create_productnotes_table.dart';
import 'create_vendor_table.dart';
import 'create_order_table.dart';
import 'create_orderitems_table.dart';
import 'create_customer_table.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		 await CreateVendorTable().up();
		 await CreateProductTable().up();
		 await CreateProductnotesTable().up();
		 await CreateCustomerTable().up();
		 await CreateOrderTable().up();
		 await CreateOrderitemsTable().up();
	}

  dropTables() async {
		 await CreateVendorTable().down();
		 await CreateCustomerTable().down();
		 await CreateOrderTable().down();
		 await CreateOrderitemsTable().down();
		 await CreateProductnotesTable().down();
		 await CreateProductTable().down();
	 }
}
