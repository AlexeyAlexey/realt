str = "A man, a plan, a canal -- Panama"
strExpr = (str.downcase).gsub(/\W/, '')
      


print "expr ", (strExpr.eql?(strExpr.reverse)), "\n\n"


