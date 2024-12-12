import 'package:coba_vania/app/http/controllers/customer_controller.dart';
import 'package:coba_vania/app/http/controllers/order_controller.dart';
import 'package:coba_vania/app/http/controllers/orderitem_controller.dart';
import 'package:coba_vania/app/http/controllers/product_controller.dart';
import 'package:coba_vania/app/http/controllers/productnotes_controller.dart';
import 'package:coba_vania/app/http/controllers/vendor_controller.dart';
import 'package:vania/vania.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix

    // Route Customers
    Router.get('/customer', customerController.show);
    Router.post('/create-customer', customerController.store);
    Router.put('/update-customer/{cust_id}', customerController.update);
    Router.delete('/delete-customer/{cust_id}', customerController.destroy);
// Router Order
    Router.get('/order', orderController.show);
    Router.post('/create-order', orderController.store);
    Router.put('/update-order/{order_num}', orderController.update);
    Router.delete('/delete-order/{order_num}', orderController.destroy);

// Router OrderItems
    Router.get('/orderitems', orderitemController.show);
    Router.post('/create-orderitems', orderitemController.store);
    Router.put('/update-orderitems/{order_item}', orderitemController.update);
    Router.delete('/delete-orderitems/{order_item}', orderitemController.destroy);

    // Route Produk
    Router.get('/product', productController.show);
    Router.post('/create-product', productController.store);
    Router.put('/update-product/{prod_id}', productController.update);
    Router.delete('/delete-product/{prod_id}', productController.destroy);

    // Route Produknotes
    Router.get('/productnotes', productnotesController.show);
    Router.post('/create-productnotes', productnotesController.store);
    Router.put('/update-productnotes/{note_id}', productnotesController.update);
    Router.delete('/delete-productnotes/{note_id}', productnotesController.destroy);

    //Route Vendor 
    Router.get('/vendor', vendorController.show);
    Router.post('/create-vendor', vendorController.store);
    Router.put('/update-vendor/{vend_id}', vendorController.update);
    Router.delete('/delete-vendor/{vend_id}', vendorController.destroy);
  }
}
