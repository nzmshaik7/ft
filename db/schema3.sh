#!/bin/bash

exit 1

rails generate scaffold PaymentType name:string
rails generate migration delete_paytype_from_PaymentMethod paytype:integer
rails generate migration add_payment_type_id_to_PaymentMethod \
                                                   payment_type_id:integer
