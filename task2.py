import mysql.connector
group_number="43" #FILL IN YOUR GROUP NUMBER

#To run locally:
config = {
     "user": "root",
     "password": "",
     "host": "127.0.0.1",
     "database": "project_group43",
     }

'''
#To run on university server:
config = {
  "host": "",
  "user": ""+ group_number,
  "passwd": ""+ group_number,
  "database": "ht21_2_project_group_"+ group_number
  }
'''

cnx = mysql.connector.connect(**config)
cursor = cnx.cursor()

x = input("Enter a product ID: ")

query1 = "SELECT product_discount, product_id from product_ where product_id = %s"

cursor.execute(query1, (x,))

for (discount, product) in cursor:
    print(f"Discount of {discount}% for product ID {product}")

new_discount = input(f"Enter new discount for product ID {product}: ")

query2 = "UPDATE product_ SET product_discount = %s WHERE product_id = %s"

cursor.execute(query2, (new_discount, x))

query3 = """SELECT product_discount, product_id from product_
where product_id = %s"""

cursor.execute(query3, (x,))

for (discount, product) in cursor:
    print(f"Discount of {discount}% for product ID {product}")

cursor.close()
cnx.commit()
cnx.close()
