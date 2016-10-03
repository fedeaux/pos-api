Consumption.destroy_all
Product.destroy_all
Report.destroy_all
Restaurant.destroy_all
Table.destroy_all
User.destroy_all
Waiter.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!(Consumption.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(Payment.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(Product.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(ProductConsumption.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(Restaurant.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(Table.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(User.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(Waiter.table_name)
