# encoding: utf-8

User.delete_all
User.create! name: 'Uwe Kubosch', email: 'uwe@kubosch.no', password: 'pass123',
        password_confirmation: 'pass123'
