require 'action_mailer'

ActionMailer::Base.smtp_settings = { 
                    :address => "smtp.gmail.com", 
                    :port => 587,#465, 
					:authentication => :plain, 
					:domain => "gmail.com",
					:user_name => "ialexey.kondratenko", 
					:password => '45673999Alexey',
					:enable_starttls_auto => true
					}

class MaileRealt < ActionMailer::Base
 self.default :from => "ialexey.kondratenko@gmail.com"
 
 def welcom(recipient)
     
	 mail(:to => recipient, :subject => "Welcom") do |format|
         format.html { render :text => "<h1>Hello Alexey<h1>" }
     end 
 
 end


 
end

MaileRealt.welcom("alexey.kondratenko@mail.ru").deliver