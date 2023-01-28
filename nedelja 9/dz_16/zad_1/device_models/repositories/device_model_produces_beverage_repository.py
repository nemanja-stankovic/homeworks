from mysql.connector.cursor import MySQLCursor

from device_models.models.dao import DeviceModelProducesBeverage


class DeviceModelProducesBeverageRepository:
    def __init__(self, my_cursor: MySQLCursor):
        self.my_cursor = my_cursor

    def add_new_beverage_for_device_model(self, device_model_id: int, beverage_id: int):

        sql = """INSERT INTO device_model_produces_beverage (device_model_id, beverage_id) VALUES (%s, %s)"""
        val = (device_model_id, beverage_id)
        self.my_cursor.execute(sql, val)
        # result = self.my_cursor.fetchall()
        if self.my_cursor.rowcount == 1:
            return True
        else:
            return False

    def get_all_beverages_ids_for_device_model(self, device_model_id: int):
        sql = """SELECT beverage_id FROM device_model_produces_beverage WHERE device_model_id = %s """
        val = (device_model_id,)
        self.my_cursor.execute(sql, val)
        result = self.my_cursor.fetchall()
        beverage_ids = []
        for beverage_id_tuple in result:
            beverage_ids.append(DeviceModelProducesBeverage(device_model_id, beverage_id_tuple[0]))
        return beverage_ids

    def delete_beverage_from_device_model(self,  device_model_id: int, beverage_id: int):
        """
        This function deletes a beverage from a device model

        :param device_model_id: int
        :type device_model_id: int
        :param beverage_id: int
        :type beverage_id: int
        """

        sql = "DELETE FROM device_model_produces_beverage WHERE device_model_id = (%s) and beverage_id = (%s)"
        val = (device_model_id,beverage_id)
        try:
            self.my_cursor.execute(sql, val)
            if self.my_cursor.rowcount == 0:
                raise ValueError(f'Device_model_produces_beverage with provided device_model_id: {device_model_id} and beverage_id: {beverage_id}  was not found.')
        except ValueError as e:
            raise e
        except Exception as e:
            raise Exception(f"Database error occurred while deleting beverage") from e
        finally:
            print(self.my_cursor.rowcount, "record(s) deleted")

    def get_all_device_model_ids(self):
        sql = """SELECT device_model_id FROM device_model"""
        self.my_cursor.execute(sql)
        result = self.my_cursor.fetchall()
        list=[]
        for tuple_id in result:
            id=tuple_id[0]
            list.append(id)
        return list

