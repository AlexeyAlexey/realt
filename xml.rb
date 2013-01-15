require 'builder'

b = Builder::XmlMarkup.new(:indent => 2)

b.person(:type => 'faculty') do
 b.name "Barbara Liskov"
 b.contact do
  b.phone(:location=>'office')
  b.email "liskov@csail.mit.edu"
 
 end

end

print b
