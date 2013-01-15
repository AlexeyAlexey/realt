require 'mysql'

m = Mysql.connect('127.0.0.1', 'root', '18281828', 'kbd')

r = m.query("SELECT * FROM tbl1")

r.each_hash do |f|
  puts "#{f['row1']} - #{f['row2']}"
end
