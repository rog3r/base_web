#Date::DATE_FORMATS[:default]= '%d/%m/%Y'
Date::DATE_FORMATS[:default] = lambda { |date| I18n.l(date) }

 #Time::DATE_FORMATS[:default] = '%d/%m/%Y %H:%M'
 #Time::DATE_FORMATS[:default] = '%d/%m/%Y'
 #Time::DATE_FORMATS[:default] = lambda { |date| I18n.l(date) }