require 'action_mailer'




ActionMailer::Base.smtp_settings = { 
                    :address => "alexey.kondratenko@mail.ru", 
                    :port => 465, 
					:authentication => :plain, 
					:domain => "mail.ru",
					:user_name => "alexey.kondratenko", 
					:password => "911101102Alexey",
					:enable_starttls_auto => true
					}

class MaileRealt < ActionMailer::Base
 #self.default :from => "alexey.kondratenko@mail.ru"
 
 def welcom
     
	 mail(:to => "ialexey.kondratenko@gmail.com", :from => "alexey.kondratenko@mail.ru", :subject => "Welcom") #do |format|
         #format.text { render :text => "Hello Alexey" }
     #end 
 
 end


 
end


MaileRealt.welcom.deliver