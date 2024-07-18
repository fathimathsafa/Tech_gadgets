import 'package:sqflite/sqflite.dart' as sql;

class SQL_Functions {
  
  static Future<sql.Database> openOrcreateDB() async {
    return await sql.openDatabase(
      'users',
      version: 2, 
      onCreate: (database, version) async {
        await createTable(database);
        await createPurchasedProductsTable(database);
      },
      onUpgrade: (database, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await createPurchasedProductsTable(database);
        }
      },
    );
  }

  static Future<void> createTable(sql.Database database) async {
    await database.execute(
        'CREATE TABLE data (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, email TEXT, password TEXT, phone TEXT)');
  }

  
  static Future<void> createPurchasedProductsTable(sql.Database database) async {
    await database.execute(
        'CREATE TABLE purchased_products (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, productName TEXT, description TEXT, price TEXT, image TEXT)');
  }

  static Future<int> adduser(String name, String email, String phonnumber, String password) async {
    final db = await SQL_Functions.openOrcreateDB();
    var data = { "name": name, "email": email, "phone": phonnumber, "password": password };
    final id = await db.insert("data", data);
    return id;
  }

 
  static Future<List<Map<String, dynamic>>> readTask() async {
    final db = await SQL_Functions.openOrcreateDB(); 
    return db.query('data', orderBy: 'id');
  }

 


  static Future<List<Map>> checkUserAlreadyRegistered(String email) async {
    final db = await SQL_Functions.openOrcreateDB();
    final user = await db.rawQuery("SELECT * FROM data WHERE email = '$email'");
    return user;
  }

 
  static Future<List<Map<String, dynamic>>> checkUserExist(String email, String pwd) async {
    final db = await SQL_Functions.openOrcreateDB();
    final data = await db.rawQuery("SELECT * FROM data WHERE email='$email' AND password='$pwd'");
    return data;
  }


  static Future<int> addPurchasedProduct(String productName, String description, String price, String image) async {
    final db = await SQL_Functions.openOrcreateDB();
    var product = { "productName": productName, "description": description, "price": price, "image": image };
    final id = await db.insert("purchased_products", product);
    return id;
  }

 
  static Future<List<Map<String, dynamic>>> getPurchasedProducts() async {
    final db = await SQL_Functions.openOrcreateDB();
    return db.query('purchased_products', orderBy: 'id');
  }

  
  static Future<void> printTables() async {
    final db = await SQL_Functions.openOrcreateDB();
    final tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
    print(tables);
  }
}
