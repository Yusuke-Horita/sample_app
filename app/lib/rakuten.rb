require "selenium-webdriver"
require 'csv'

class Rakuten
	USER_NAME = ENV["USER_NAME"]
	PASSWORD = ENV["PASSWORD"]
	def self.get_coupon
		starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
		driver = Selenium::WebDriver.for :chrome
		wait = Selenium::WebDriver::Wait.new(:timeout => 10)

		driver.get "https://wantedly.com/signin_or_signup"
		email_form = driver.find_element(:css, "#email")
		email_form.send_keys USER_NAME
		email_form.submit
		wait.until { driver.find_element(:css, "#password").displayed? }
		driver.find_element(:css, "#password").send_keys PASSWORD
		driver.find_element(:css, "#password").submit
		wait.until { driver.find_element(:css, ".OptionalSelectorAbstract--leader").displayed? }
		driver.get "https://www.wantedly.com/projects?type=mixed&page=1&occupation_types%5B%5D=jp__engineering&hiring_types%5B%5D=mid_career&fields%5B%5D=jp__web_engineer&fields%5B%5D=jp__systems_engineer&locations%5B%5D=tokyo&keywords%5B%5D=java"
		# ------ driver.find_element(:css, "#comment____________").submit --------

		inclusion_companys = []
		exclusion_companys_1 = []
		exclusion_companys_2 = []
		exclusion_companys_3 = []

		# begin
			100.times do |page|
				10.times do |num|
					begin
						driver.find_elements(:css, ".project-index-single-inner")[num].displayed?
					rescue
						next
					end
					5.times do |i|
						driver.find_elements(:css, ".project-index-single-inner")[num].click
						# if driver.current_url == "https://www.wantedly.com/projects?type=mixed&page=#{ page + 1 }&occupation_types%5B%5D=jp__engineering&hiring_types%5B%5D=mid_career&fields%5B%5D=jp__mobile_engineer&fields%5B%5D=jp__web_engineer&fields%5B%5D=jp__systems_engineer&fields%5B%5D=jp__data_scientist&locations%5B%5D=tokyo"
						if driver.current_url.include?("https://www.wantedly.com/projects/") && driver.current_url.exclude?("https://www.wantedly.com/projects/mixed?")
							5.times do
								begin
									driver.find_element(:css, ".js-descriptions")
									break
								rescue
									driver.navigate.refresh
									puts "・"
								end
							end
							break
						end
						puts "!!!!!!!!!!!"
						driver.navigate.refresh
						wait.until { driver.find_element(:css, ".project-index-single-inner").displayed? }
					end
					begin
						text = driver.find_element(:css, ".js-descriptions").text
						if /プロジェクト先|クライアント先/ =~ text || /フロントエンド|フロントエンジニア|CTO|デザイナー/ =~ driver.find_element(:css, ".project-tag.normal").text
							hash = {}
							hash[:category] = driver.find_element(:css, ".project-tag.large.normal").text
							hash[:company] = driver.find_element(:css, ".company-link").text
							hash[:title] = driver.find_element(:css, ".project-title").text
							hash[:url] = driver.current_url
							exclusion_companys_1 << hash
							ap hash[:title]
						elsif /常駐|客先/ =~ text
							hash = {}
							hash[:category] = driver.find_element(:css, ".project-tag.large.normal").text
							hash[:company] = driver.find_element(:css, ".company-link").text
							hash[:title] = driver.find_element(:css, ".project-title").text
							hash[:url] = driver.current_url
							exclusion_companys_2 << hash
							ap hash[:title]
						elsif /SES/ =~ text
							hash = {}
							hash[:category] = driver.find_element(:css, ".project-tag.large.normal").text
							hash[:company] = driver.find_element(:css, ".company-link").text
							hash[:title] = driver.find_element(:css, ".project-title").text
							hash[:url] = driver.current_url
							exclusion_companys_3 << hash
							ap hash[:title]
						else
							hash = {}
							hash[:category] = driver.find_element(:css, ".project-tag.large.normal").text
							hash[:company] = driver.find_element(:css, ".company-link").text
							hash[:title] = driver.find_element(:css, ".project-title").text
							hash[:url] = driver.current_url
							inclusion_companys << hash
							puts hash[:title]
						end
					rescue
						text = driver.find_element(:css, ".js-descriptions").text
						if /プロジェクト先|クライアント先/ =~ text
							hash = {}
							hash[:category] = driver.find_element(:css, ".job-type-tag").text
							hash[:company] = driver.find_element(:css, ".company-name").text
							hash[:title] = driver.find_element(:css, ".project-title").text
							hash[:url] = driver.current_url
							exclusion_companys_1 << hash
							ap hash[:title]
						elsif /常駐|客先/ =~ text
							hash = {}
							hash[:category] = driver.find_element(:css, ".job-type-tag").text
							hash[:company] = driver.find_element(:css, ".company-name").text
							hash[:title] = driver.find_element(:css, ".project-title").text
							hash[:url] = driver.current_url
							exclusion_companys_2 << hash
							ap hash[:title]
						elsif /SES/ =~ text
							hash = {}
							hash[:category] = driver.find_element(:css, ".job-type-tag").text
							hash[:company] = driver.find_element(:css, ".company-name").text
							hash[:title] = driver.find_element(:css, ".project-title").text
							hash[:url] = driver.current_url
							exclusion_companys_3 << hash
							ap hash[:title]
						else
							hash = {}
							hash[:category] = driver.find_element(:css, ".job-type-tag").text
							hash[:company] = driver.find_element(:css, ".company-name").text
							hash[:title] = driver.find_element(:css, ".project-title").text
							hash[:url] = driver.current_url
							inclusion_companys << hash
							puts hash[:title]
						end
					end
					driver.navigate.back
				end
				puts "--- #{ page + 1 } ---"
				begin
					driver.find_element(:link_text, "次へ").click
					ap "次へ"
				rescue
					break
				end
				5.times do
					begin
						wait.until { driver.find_element(:css, ".project-index-single-inner").displayed? }
						ap"表示"
						break
					rescue
						driver.navigate.refresh
						ap "リロード"
					end
				end
			end

			# CSV.open('inclusion_company.csv', 'w') do |csv|
			# 	csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
			# 	inclusion_companys.each_with_index do |company, i|
			# 		csv << [i + 1, company[:category], company[:title], company[:company], company[:url]]
			# 	end
			# end
			# CSV.open('exclusion_company.csv', 'w') do |csv|
			# 	csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
			# 	exclusion_companys.each_with_index do |company, i|
			# 		csv << [i + 1, company[:category], company[:title], company[:company], company[:url]]
			# 	end
			# end

			inclusion_companys.uniq!
			exclusion_companys_1.uniq!
			exclusion_companys_2.uniq!
			exclusion_companys_3.uniq!

			f_i = []
			f_e_1 = []
			f_e_2 = []
			f_e_3 = []
	
			inclusion_companys.each do |company|
				if index = f_i.rindex(f_i.select{|i| i[:company] == company[:company]}.last)
					company[:company] = "└ " + company[:company]
					f_i.insert(index + 1, company)
				else
					f_i << company
				end
			end
			exclusion_companys_1.each do |company|
				if index = f_e_1.rindex(f_e_1.select{|i| i[:company] == company[:company]}.last)
					company[:company] = "└ " + company[:company]
					f_e_1.insert(index + 1, company)
				else
					f_e_1 << company
				end
			end
			exclusion_companys_2.each do |company|
				if index = f_e_2.rindex(f_e_2.select{|i| i[:company] == company[:company]}.last)
					company[:company] = "└ " + company[:company]
					f_e_2.insert(index + 1, company)
				else
					f_e_2 << company
				end
			end
			exclusion_companys_3.each do |company|
				if index = f_e_3.rindex(f_e_3.select{|i| i[:company] == company[:company]}.last)
					company[:company] = "└ " + company[:company]
					f_e_3.insert(index + 1, company)
				else
					f_e_3 << company
				end
			end
	
			CSV.open('inclusion_company.csv', 'w') do |csv|
				csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
				f_i.each_with_index do |company, i|
					csv << [i + 1, company[:category], company[:company], company[:title], company[:url]]
				end
			end
			CSV.open('exclusion_company_1.csv', 'w') do |csv|
				csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
				f_e_1.each_with_index do |company, i|
					csv << [i + 1, company[:category], company[:company], company[:title], company[:url]]
				end
			end
			CSV.open('exclusion_company_2.csv', 'w') do |csv|
				csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
				f_e_2.each_with_index do |company, i|
					csv << [i + 1, company[:category], company[:company], company[:title], company[:url]]
				end
			end
			CSV.open('exclusion_company_3.csv', 'w') do |csv|
				csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
				f_e_3.each_with_index do |company, i|
					csv << [i + 1, company[:category], company[:company], company[:title], company[:url]]
				end
			end

			# ap inclusion_companys.size + exclusion_companys.size
			ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
			elapsed = ending - starting
			
		# rescue
		# 	CSV.open('inclusion_company.csv', 'w') do |csv|
		# 		csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
		# 		inclusion_companys.each_with_index do |company, i|
		# 			csv << [i + 1, company[:category], company[:title], company[:company], company[:url]]
		# 		end
		# 	end
		# 	CSV.open('exclusion_company.csv', 'w') do |csv|
		# 		csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
		# 		exclusion_companys.each_with_index do |company, i|
		# 			csv << [i + 1, company[:category], company[:title], company[:company], company[:url]]
		# 		end
		# 	end

		# 	ap inclusion_companys.size + exclusion_companys.size
		# 	ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
		# 	elapsed = ending - starting
		# end


		# driver.find_element(:xpath, "//p[contains(text(), 'SES')]")

	end
	# a.find{|i| i[:f] == "F"}
	# a.rindex({:e=>"E", :f=>"F"})
	# =>
	# a.rindex(a.find{|i| i[:f] == "F"})

	# a.insert(index + 1, ccc)
end
"https://www.wantedly.com/projects/mixed?fields%5B%5D=jp__mobile_engineer&fields%5B%5D=jp__web_engineer&fields%5B%5D=jp__systems_engineer&fields%5B%5D=jp__data_scientist&hiring_types%5B%5D=mid_career&locations%5B%5D=tokyo&occupation_types%5B%5D=jp__engineering&page=42"