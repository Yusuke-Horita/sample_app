require "selenium-webdriver"
require 'csv'

class Rakuten
	USER_NAME = ENV["USER_NAME"]
	PASSWORD = ENV["PASSWORD"]
	def self.get_coupon
		starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
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

		wait.until { driver.find_element(:css, ".OptionalSelectorAbstract--leader").displayed? }
		# driver.find_element(:css, ".OptionalSelectorAbstract--leader").click
		# driver.find_element(:link_text, "東京").click

		driver.get "https://www.wantedly.com/projects?type=mixed&page=1&occupation_types%5B%5D=jp__engineering&hiring_types%5B%5D=mid_career&fields%5B%5D=jp__mobile_engineer&fields%5B%5D=jp__web_engineer&fields%5B%5D=jp__systems_engineer&fields%5B%5D=jp__data_scientist&locations%5B%5D=tokyo"

		# ------ driver.find_element(:css, "#comment____________").submit --------

		inclusion_companys = []
		exclusion_companys = []

		# begin
			10.times do
				10.times do |num|
					driver.find_elements(:css, ".project-index-single-inner")[num].click
					# js-descriptions 
					driver.navigate.refresh
					if /SES|常駐|プロジェクト先|クライアント先|客先/ =~ driver.find_element(:css, ".js-descriptions").text || /フロントエンド|CTO|デザイナー/ =~ driver.find_element(:css, ".project-tag.normal").text
						hash = {}
						hash[:category] = driver.find_element(:css, ".project-tag.large.normal").text
						hash[:title] = driver.find_element(:css, ".project-title").text
						hash[:company] = driver.find_element(:css, ".company-link").text
						hash[:url] = driver.current_url
						exclusion_companys << hash
						ap hash[:title]
						driver.navigate.back
						# elements = driver.find_elements(:css, ".oDrDetailList .detail .listPageIcon")
						# elements[num].click
				
						# delivery = driver.find_element(:css, ".shippingType").text

						# if /メール便|日本郵便/ =~ driver.find_element(css:"body").text
						# 	puts shop_name = driver.find_element(:css, ".shopName").text
						# 	order_date = driver.find_element(:css, ".orderDate").text
						# 	net_tot = driver.find_element(:css, ".netTot").text
						# 	csv << [order_date, shop_name, net_tot, delivery]
							
						# 	driver.navigate.back
						# else
						# 	ap driver.find_element(:css, ".shopName").text
						# 	driver.navigate.back
						# end
						# driver.find_element(:link_text, "次の25件>>").click
					else
						hash = {}
						hash[:category] = driver.find_element(:css, ".project-tag.large.normal").text
						hash[:title] = driver.find_element(:css, ".project-title").text
						hash[:company] = driver.find_element(:css, ".company-link").text
						hash[:url] = driver.current_url
						inclusion_companys << hash
						puts hash[:title]
						driver.navigate.back
					end
				end
				driver.find_element(:link_text, "次へ").click
				wait.until { driver.find_element(:css, ".project-index-single-inner").displayed? }
				puts "---"
			end

			CSV.open('inclusion_company.csv', 'w') do |csv|
				csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
				inclusion_companys.each_with_index do |company, i|
					csv << [i + 1, company[:category], company[:title], company[:company], company[:url]]
				end
			end

			CSV.open('exclusion_company.csv', 'w') do |csv|
				csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
				exclusion_companys.each_with_index do |company, i|
					csv << [i + 1, company[:category], company[:title], company[:company], company[:url]]
				end
			end

			ap inclusion_companys.size + exclusion_companys.size
			ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
			elapsed = ending - starting
		# rescue
		# 	ap inclusion_companys.size + exclusion_companys.size
		# 	ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
		# 	elapsed = ending - starting
		# end

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

