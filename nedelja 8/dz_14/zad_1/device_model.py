from database_connector import my_cursor, mydb


class Device_model:
    def __init__(self, device_model_id, model_name, model_number, water_capacity_liters, coffee_capacity_kgs,
                 milk_capacity_kgs, sugar_capacity_kgs, sweetener_capacity_count, cups_capacity_count):
        self.device_model_id = device_model_id
        self.model_name = model_name
        self.model_number = model_number
        self.water_capacity_liters = water_capacity_liters
        self.coffee_capacity_kgs = coffee_capacity_kgs
        self.milk_capacity_kgs = milk_capacity_kgs
        self.sugar_capacity_kgs = sugar_capacity_kgs
        self.sweetener_capacity_count = sweetener_capacity_count
        self.cups_capacity_count = cups_capacity_count

    @staticmethod
    def read_device_model_atributes_from_database():
        sql = "SELECT device_model_id, model_name, model_number,water_capacity_liters, coffee_capacity_kgs, milk_capacity_kgs,sugar_capacity_kgs, sweetener_capacity_count,cups_capacity_count FROM device_model"
        my_cursor.execute(sql)
        results = my_cursor.fetchall()
        device_model_atributes = []
        for row in results:
            device_model_atributes.append(
                Device_model(device_model_id=row[0], model_name=row[1], model_number=row[2],
                             water_capacity_liters=row[3], coffee_capacity_kgs=row[4], milk_capacity_kgs=row[5],
                             sugar_capacity_kgs=row[6], sweetener_capacity_count=row[7], cups_capacity_count=row[8]))
        return device_model_atributes

    def find_device_model_by_ID(id: int):

        sql = "SELECT device_model_id, model_name, model_number,water_capacity_liters, coffee_capacity_kgs, milk_capacity_kgs,sugar_capacity_kgs, sweetener_capacity_count,cups_capacity_count FROM device_model where device_model_id = (%s)"
        val = (id,)
        my_cursor.execute(sql, val)
        result = my_cursor.fetchone()
        if result:
            return Device_model(device_model_id=result[0], model_name=result[1], model_number=result[2],
                                water_capacity_liters=result[3], coffee_capacity_kgs=result[4],
                                milk_capacity_kgs=result[5],
                                sugar_capacity_kgs=result[6], sweetener_capacity_count=result[7],
                                cups_capacity_count=result[8])
        else:
            raise Exception(f"Beverage with provided id-{id} could not be found.")

    @staticmethod
    def create_new_device_model(model_name, model_number, water_capacity_liters, coffee_capacity_kgs,
                                milk_capacity_kgs, sugar_capacity_kgs, sweetener_capacity_count, cups_capacity_count):
        sql = """INSERT INTO device_model( model_name, model_number, water_capacity_liters, coffee_capacity_kgs,
                 milk_capacity_kgs, sugar_capacity_kgs, sweetener_capacity_count, cups_capacity_count) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"""
        vals = (model_name, model_number, water_capacity_liters, coffee_capacity_kgs,
                milk_capacity_kgs, sugar_capacity_kgs, sweetener_capacity_count, cups_capacity_count)
        my_cursor.execute(sql, vals)
        device_model_id = my_cursor.lastrowid
        return Device_model(device_model_id=device_model_id, model_name=model_name, model_number=model_number,
                            water_capacity_liters=water_capacity_liters, coffee_capacity_kgs=coffee_capacity_kgs,
                            milk_capacity_kgs=milk_capacity_kgs,
                            sugar_capacity_kgs=sugar_capacity_kgs, sweetener_capacity_count=sweetener_capacity_count,
                            cups_capacity_count=cups_capacity_count)

    @staticmethod
    def delete_device_model(device_model_id):
        sql = """DELETE FROM device_model WHERE device_model_id = (%s);"""
        val = (device_model_id,)
        try:
            my_cursor.execute(sql, val)

            return True
        except Exception as e:
            raise Exception(f"Delete failed. Device with provided ID: {device_model_id} was not found")

    def update_device_model(self, attributes_dict: dict):
        string_with_attributes = ""
        for attribute in attributes_dict:
            string_with_attributes += f"{attribute} = {attributes_dict[attribute]},"
        string_with_attributes = string_with_attributes[:-1]
        sql = "UPDATE device_model SET " + string_with_attributes + f" WHERE device_model_id = {self.device_model_id}"
        my_cursor.execute(sql)
        if my_cursor.rowcount == 0:
            raise Exception("Nije doslo do izmene!")
        elif my_cursor.rowcount == 1:
            return Device_model.find_device_model_by_ID(self.device_model_id)

    @staticmethod
    def count_device_models_from_database():
        sql = """SELECT COUNT(device_model_ID) FROM device_model"""
        my_cursor.execute(sql)
        result = my_cursor.fetchall()
        number_of_device_models=result[0][0]
        if result:
            return number_of_device_models
        else:
            raise Exception(f"Device model_ID or device model doesn't exist")

