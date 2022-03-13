import mysql.connector
'''
Update pip and install mysql connector:
python -m pip install --upgrade pip
pip install mysql-connector-python
'''
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

x = input("Enter a department ID: ")

# look for department childrens
query = "SELECT department_id, title from department_ WHERE parent_department = %s"
cursor.execute(query, (x,))

q = (len(cursor.fetchall()))

if q == 0:
    
    query1 = """SELECT product_id, title, retail_price* (1-ifnull(product_discount, 0)/100) as 'final_price' 
    from product_ 
    where department_id = %s"""

    cursor.execute(query1, (x,))

    for (product, title, final_price) in cursor:
        print(f"product_id: {product}, title: {title}, final_price {final_price}")

else:

    cursor.execute(query, (x,))

    for (department, title) in cursor:
        print(f"department_id: {department}, title: {title}")

cursor.close()
cnx.commit()
cnx.close()
