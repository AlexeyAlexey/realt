require 'rexml-expansion-fix'



class FileXml

 def initialize(path)
     Dir.chdir(path) #текущий рабочий каталог
     
  end
  
  
 def newTable(countColomn)	 #создает REXML с тегом <table></table> и присваивает переменной экземпл€ра @doc  
	 
     @doc = REXML::Document.new
     @doc.add_element("table")
	 root = @doc.root
	 root.add_attribute("cols", countColomn)
	 root.add_attributes("border" => "1", "align" => "center", "rules" => "cols") #необходимы дл€ отображени€ HTML
	 
	 
	 
	 
	 return @doc
	 
 end
 
   
  
 
  def addTable(arrayColumn) # добавл€т в XML документ €чейки с данными указанными в массиве
     
	 countArColumn = arrayColumn.length
	 rootTable = @doc.root
     @countColumn = (rootTable.attributes["cols"]).to_i
	 
	 if (countArColumn != @countColumn)
	   then return "cols != @countColumn"
	 end
	 
	 rootTr = rootTable.add_element("tr")
	 
	 
     @countColumn.times do |countC|
	     rootTd = rootTr.add_element("td")
		 rootTd.add_attributes("title" => countC.to_s, "align" => "center", "valign" => "middle")
		 rootTd.add_text(arrayColumn[countC])
	 
	 end

	 return @doc
  
  end

 def saveNewXML(nameFile) # сохран€еи в указаный файл
     file = File.open(nameFile, 'w')
	 @doc.write(out_string = "", 2)
     file.puts out_string
	 file.close
 end
     
 def fileOpenTable(nameFile) #открываетс€ XML если существует или создает новый
      	  
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

#последовательность вызовов
#xml1 = FileXml.new("D:\\realt\\")
#xml1.fileOpenTable('tableXML2.xml') или xml1.newTable(countColomn)
#xml1.addTable(['a', 'b', 'c', 'd']) или xml1.searchTable("1", 2)
#saveNewXML('tableXML2.xml')
xml1 = FileXml.new("D:\\realt\\")

#strXML = xml1.fileOpenTable('tableXML2.xml')

strXML = xml1.newTable(3)

print "\n\n", strXML.root, "\n\n"

print "\n\n", xml1.addTable(['a', 'b', 'c']), "\n\n"

print "\n\n", xml1.addTable(["777", "2", "3"]), "\n\n"

print "\n\n", xml1.searchTable("1", 2), "\n\n"

xml1.saveNewXML('tableXML2.xml')

xml1.saveInHTML('tableHTML.html')

