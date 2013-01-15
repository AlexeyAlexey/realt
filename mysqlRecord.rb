require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :host     => "127.0.0.1",
  :username => "root",
  :password => "18281828",
  :database => "realt"
  )
  
  
class Realt < ActiveRecord::Base


end

resalt = Realt.find :Street_number == 'Alexeyeva'


puts "|#{resalt.Street_number}| |#{resalt.flor}|"









