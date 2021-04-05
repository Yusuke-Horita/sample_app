require "selenium-webdriver"
require 'csv'

class Rakuten
	USER_NAME = ENV["USER_NAME"]
	PASSWORD = ENV["PASSWORD"]
	def self.get_coupon
		#Chrome用のドライバ
		driver = Selenium::WebDriver.for :chrome
		wait = Selenium::WebDriver::Wait.new(:timeout => 10)

		# driver.get "https://order.my.rakuten.co.jp/?l-id=pc_header_func_ph"
		# driver.find_element(:name, "u").send_keys USER_NAME
		# driver.find_element(:name, "p").send_keys PASSWORD
		# driver.find_element(:name, "submit").click


		# CSV.open('all_comments.csv', 'w') do |csv|
		# 	csv << ["注文日", "ショップ名", "合計金額", "配達方法"]
		# 	3.times do
		# 		25.times do |num|
		# 			elements = driver.find_elements(:css, ".oDrDetailList .detail .listPageIcon")
		# 			elements[num].click
			
		# 			delivery = driver.find_element(:css, ".shippingType").text

		# 			if /メール便|日本郵便/ =~ driver.find_element(css:"body").text
		# 				puts shop_name = driver.find_element(:css, ".shopName").text
		# 				order_date = driver.find_element(:css, ".orderDate").text
		# 				net_tot = driver.find_element(:css, ".netTot").text
		# 				csv << [order_date, shop_name, net_tot, delivery]
						
		# 				driver.navigate.back
		# 			else
		# 				ap driver.find_element(:css, ".shopName").text
		# 				driver.navigate.back
		# 			end
		# 		end
		# 		driver.find_element(:link_text, "次の25件>>").click
		# 	end
		# end




		driver.get "https://wantedly.com/signin_or_signup"
		email_form = driver.find_element(:css, "#email")
		email_form.send_keys USER_NAME
		email_form.submit
		wait.until { driver.find_element(:css, "#password").displayed? }
		driver.find_element(:css, "#password").send_keys PASSWORD
		driver.find_element(:css, "#password").submit


		# begin
		# 	driver.find_element(:xpath, "//p[contains(text(), 'SES')]")
		# 	puts driver.find_element(:css, ".company-logo")
		# 	driver.navigate.back
		# rescue
		# 	begin
		# 		driver.find_element(:xpath, "//p[contains(text(), '常駐')]")
		# 		puts driver.find_element(:css, ".company-logo")
		# 		driver.navigate.back
		# 	rescue
		# 		begin
		# 			driver.find_element(:xpath, "//p[contains(text(), 'ses')]")
		# 			puts driver.find_element(:css, ".company-logo")
		# 			driver.navigate.back
		# 		rescue
		# 			begin
		# 				driver.find_element(:xpath, "//div[contains(text(), 'SES')]")
		# 				puts driver.find_element(:css, ".company-logo")
		# 				driver.navigate.back
		# 			rescue
		# 				driver.navigate.back
		# 			end
		# 		end
		# 	end
		# end

	end
end

