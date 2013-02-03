#coding: UTF-8
#require 'iconv'
#require 'net/http'
require 'fileutils'
require 'open-uri' 

require 'hpricot'
require 'fileutils'

require 'rexml-expansion-fix'

require 'rubygems'
require 'active_record'

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
 self.default :from => "ialexey.kondratenko@gmail.com", :charset => "Windows-1251"
 
 def welcom(recipient, textHTML)
     
	 mail(:to => recipient, :subject => "Welcom") do |format|	      
         format.html { render :text => textHTML}
     end 
 
 end


 
end

class WrongNumberOfColumnc < StandardError ; end

class FileXml

  attr_accessor :doc
  
 def newTable(countColomn)	 #создает REXML с тегом <table></table> и присваивает переменной экземпляра @doc  
	 
     @doc = REXML::Document.new
     @doc.add_element("table")
	 root = @doc.root
	 root.add_attribute("cols", countColomn)
	 root.add_attributes("border" => "1", "align" => "center", "rules" => "cols") #необходимы для отображения HTML
	 
	 
	 
	 
	 return @doc
	 
 end
 
   
  
 
  def addTable(arrayColumn) # добавлят в XML документ ячейки с данными указанными в массиве
     
	 countArColumn = arrayColumn.length
	 rootTable = @doc.root
     @countColumn = (rootTable.attributes["cols"]).to_i
	 
	 
	 raise WrongNumberOfColumnc unless countArColumn == @countColumn
	 
	 rootTr = rootTable.add_element("tr")
	 
	 
     @countColumn.times do |countC|
	     rootTd = rootTr.add_element("td")
		 rootTd.add_attributes("title" => countC.to_s, "align" => "center", "valign" => "middle")
		 rootTd.add_text arrayColumn[countC].encode("Windows-1251")
	 
	 end

	 return @doc
  
  end

 def saveNewXML(nameFile) # сохраняеи в указаный файл
     file = File.open(nameFile, 'w')
	 @doc.write(out_string = "", 2)
     file.puts out_string
	 file.close
 end
     
 def fileOpenTable(nameFile) #открывается XML если существует или создает новый
      	  
	 fileOpenXML = File.open(nameFile, 'r')
	 line = ""
	 fileOpenXML.each {|l| line<<l}
	 print line
	 str = line
	 print "\n\n", str, "\n\n"
	 @doc = REXML::Document.new str
	 fileOpenXML.close
	  
	 return @doc
	 
  end
  
  
  def searchTable(title, value)
  
     REXML::XPath.each(@doc, "//td") do |tdElement|
	     
		 if (tdElement.attributes["title"] = 2 and tdElement.text = value)
		   then return true
		   else return nil
		 end
		 
		 
	 
	 end
  
  
  end
  
  def saveInHTML(nameFile)
     file = File.open(nameFile, 'w')
	 @doc.write(out_string = "", 2)
     file.puts out_string
	 file.close
  
  
  end
  
 end







class HTMLrealt



ActiveRecord::Base.establish_connection(
  :adapter  => "mysql2",
  :encoding  => "cp1251",
  :host     => "127.0.0.1",
  :username => "root",
  :password => "18281828",
  :database => "realt"
  )
  
  
class Realt < ActiveRecord::Base


end




   @resTable = Array.new #для записи результата
   
   def initialize(path, urlS, urlQ, valt, сn_min, сn_max, vSps)
      Dir.chdir(path) #текущий рабочий каталог
	  #file = File.open('tableXML.xml', 'r')
      #@xmlREXML = REXML::Document.new file.gets
	  #print "\n\n\n\n@xmlREXML = ",@xmlREXML ,"\n\n\n\n"
	  
	  @urlSite = proc{ |showNum, pos| "#{urlS}#{urlQ}Cn_min=#{сn_min}&Cn_max=#{сn_max}&TmSdch=#{9999}&srtby=#{5}&showNum=#{showNum}&vSps=#{vSps}&idNp=#{100000}&pos=#{pos}&valt=#{valt}"}
	  
	  htmlHpricot(0, 0) # в переменной @encodingStr получаем кодировку
   end

      
   def templetN(arg)
      #print "____________________", Realt.column_names, "\n\n"
      hashTd = Hash.new
	  
	  @nameOfColumns.each {|key| hashTd[key.to_sym] = nil}
	  
	  arrayTd = Array.new
      arg.search(:tr).each do |resTr|
	     i = 1
	     resTr.search(:td).each do |resTd|
		      
		     if i==3
			   then 
			        #проверка на существование первичных ключей
			        if  Realt.where(Street_number: arrayTd[0], district: arrayTd[1]).exists?
                      then 				       
                           arrayTd.clear						   
					       break
                    end		
			 end
			 
			 arrayTd << resTd.inner_html #массив с даными таблицы
			 
			 if i == @countColumn
			   then break			   
			 end
			 			 
		     i += 1
		      
		 end
	     #print "array of td", arrayTd, "\n\n"
		 
		 if !(arrayTd.empty?)
		   then
		     j = 0
		     hashTd.each_key {|key| hashTd[key] = arrayTd[j]; j += 1} #хэш с данными	
             
			 #print "____________________", hashTd, "\n\n"			 
		     		 
			 Realt.create(hashTd) #вставка в базу даных
			 
			 @xml1.addTable arrayTd #передаем массив значений столбцов
			  
		 end
		 ################################################################
	     arrayTd.clear
	  end
   
      
      
   
      #@file.write arg 
	  #@file.write "\n"
   end
   
   def temletSearch(argSearch, title)
      
	  #возвращает false or tru
   
   end
   
   def templetW(arg)
       # Записывает в XML arg - массив элементы которого есть ячейки
   end
   
   
   def parseTableHTML(htmlHpricot, countOfBox)
      
	  indexBox = 0
	  wr = false
	  arrayBox = Array.new
	  htmlHpricot.search(:tr).each do |resTr|
	  
	        resTr.search(:td).each do |resTd|
			   			   
			   resTd.inner_html #получаем значение ячейки
			   
			   if indexBox == 1
			     then wr = temletSearch(resTd.inner_html, "2") #ещет значение в шаблоне XML "2" - значение атрибута title; resTd.inner_html - текстовое значение; возвращает false or tru  				 
			   end
			   arrayBox[indexBox] = resTd.inner_html #сохраняем ячейки в массиве
			   indexBox += 1 #индекс ячейки
			end
			
			if wr
			  then templetW arrayBox#записываем в XML передавая массив
			end
		    			
	   end
   
   end
   
   def formdRequest(urlS, urlQ, valt, сn_min, сn_max, vSps) 
      #Шаблон запроса
	  #http://realt.ua/Db2/0Sd_Kv.php?cnt_all=289&idNp=100000&Cn_min=1000&Cn_max=3000&valt=4&TmSdch=9999&vSps=0&srtby=5&pos=0
      #Cn_min= минимальная цена
      #Cn_max= максимальная цена
      #valt тип валюты 4-евро 2-долары 1-гривня
      #при добавлении vSps=0 оттображается таблицей 
      #cnt_all количество строк таблицы вернувшихся с сервера (можно пропускать)
	  #showNum количество строк отображаемых в таблице вывода 20, 30, 50 задать вручную
	  #pos перелистывает страницу на следующие n строк при showNum=50 - 0, 50, 100. Необходимо вычислять через параметр cnt_all и showNum
	  #порядок следования переменных безразлично   
	  
	  #Замыкание
	  
	  
   end
   
   def htmlHpricot(showNum, pos)
       	  
	  #print "urlTable @urlSite  :", @urlSite.call(showNum, pos), "\n\n"
      #OpenURI is an easy-to-use wrapper for net/http, net/https and net/ftp.
	  uri = URI.parse(@urlSite.call(showNum, pos))
	  @strHtml = uri.read #возвращает html страницу которая сохраняется в str
	  @encodingStr = @strHtml.encoding.name #переменная содержащая кодировку
      Hpricot(@strHtml) #Используем Hpricot для анализа html  
   end
   
   def searchCnt_all(strHtmlHpr) #находит значение переменной cnt_all которая используется в URI
       
	   countLinStr = "http:\/\/realt\.ua.+(cnt_all=[0-9]+).+"#.encode("Windows-1251")
	   countLinExpr = Regexp.compile(countLinStr) #Создает регулярное выражение из строки
	   
       	    
	   #Используем Hpricot для анализа html в строке str хранится html страница
	   
	   @cnt_all = 0
	   strHtmlHpr.search(:a).each do |res|
		    
                                    			
			if countLinExpr.match(res.attributes["href"])
			  then @cnt_all = (/([0-9]+)/.match(countLinExpr.match(res.attributes["href"]).to_a[1]).to_a[1]).to_i #обратные ссылки находим количество найденных строк
			end
				
	   end
		
	   
   
   end
   
   
   def catchPage(*titleTable) 
       
	   showNum = 50
	   pos = 0
	   
	   #strHtmlHpr = htmlHpricot(showNum, pos)

       self.searchCnt_all htmlHpricot(showNum, pos)  
   
       #print "Количество ключевых столбцов по которым ищется таблица: ", titleTable.count, "\n\n"
	   
       
       #Находит таблицу по шапке заключенную в теги <table> <tr><th></th></tr> </table>
       # При работе возникла проблема с кодировкой текста. В консоле Windows была кодировка IBM6680 при которой выдавало ошибку при перекодировке 
	   #в Windows-1251. Для исправления данной ошибки изменил кодировку текста в консоле Start->Run->regedit
       #Go to [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage]
       #And change the "OEMCP" value to "1252"  
	   
	   
	   #print "Charset of html page is ", @encodingStr, "\n\n"#возвращет кодировку страницы
	   
	   
		
		#Массив с регулярными выражениями
	   titleTable.map! do |t| 
	        t2=t.encode(@encodingStr)#изменяем кодировку строки соответствено html
			Regexp.compile(t2) #создаем объект регулярного выражения	   
	   
	   end
		
	   #file = File.open('realt.xml', 'w:windows-1251') #открывает файл для записи результата для удобства просмотра	"w:utf-8"
	   
	   countPage = @cnt_all/50 + 1
	   
	   if countPage == 0
	     then countPage = 1
       end
       
	   
	   @nameOfColumns = Realt.column_names #массив с именами полей таблицы базы данных
	   @countColumn = @nameOfColumns.size #количество полей базы данных
	   
	  
	   @xml1 = FileXml.new                 #создаем таблицу XML(HTML) class FileXml
	   @strXML = @xml1.newTable @countColumn #создаем таблицу XML(HTML) указывая количество столбцов class FileXml
	   @xml1.addTable ["Район города", "Улица, № дома", "Кол-во комнат", "Этаж :Этажность", "Площадь (кв.м) Общ. / Жил./ Кух.", "Цена/Мес." , "Дата"]
        #перебирая параметром pos пролистываем html страницы	   
       countPage.times do |countP| 
          
		 pos = countP*50
		  
		 
		 #перебирая параметром pos пролистываем html страницы
	    htmlHpricot(showNum, pos).search(:th).each do |res|
				     
		    if titleTable[1].match(res.inner_html) #res.inner_html - просматривает содержание тега; titleTable[1].match(res.inner_html) - regexpreshion
		      #print "Number page: ", countP, "\n\n\n\n"
			  templetN res.parent.parent #file.write res.parent.parent #вложенность <table> <tr><th></th></tr> </table>
			  #file.write "\n"
			  
			end		
			
	   end
	   
	   
	   
		
       end	

       MaileRealt.welcom("alexey.kondratenko@mail.ru", @xml1.doc).deliver
	   #print "countPage = ", countPage, "\n\n"
	   #print "showNum = ", showNum, "\n\n"
	   #print "cnt_all = ", @cnt_all, "\n\n"
	   #print "titleTable[1] = ", titleTable[1], "\n\n"
	   
	     
	   
	   
			
	end
	
	
   
   

end


htm = HTMLrealt.new("D:\\realt\\", "http://realt.ua", "/Db2/0Sd_Kv.php?", 2, 0, 300, 0)

#htm.formdRequest("http://realt.ua", "/Db2/0Sd_Kv.php?", 2, 0, 1000, 0)

htm.catchPage("[Рр]айон города", "Улица.+", ".+Кол-во.+комнат.+", ".+Этаж :.+")

