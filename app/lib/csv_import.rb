class CsvImport
	require 'csv'
	def self.import
		inclusion_company = []
		exclusion_company_1 = []
		exclusion_company_2 = []
		exclusion_company_3 = []

		CSV.foreach("応募企業_Ruby.csv") do |row|
			hash = {}
			hash["category"] = row[0]
			hash["company_name"] = row[1]
			hash["title"] = row[2]
			hash["url"] = row[3]
			inclusion_company << hash
		end
		ap inclusion_company.size
		CSV.foreach("応募企業_Rails.csv") do |row|
			hash = {}
			hash["category"] = row[0]
			hash["company_name"] = row[1]
			hash["title"] = row[2]
			hash["url"] = row[3]
			inclusion_company << hash
		end
		ap inclusion_company.size
		CSV.foreach("除外企業_Ruby（フロント・プロジェクト先・クライアント先）.csv") do |row|
			hash = {}
			hash["category"] = row[0]
			hash["company_name"] = row[1]
			hash["title"] = row[2]
			hash["url"] = row[3]
			exclusion_company_1 << hash
		end
		ap exclusion_company_1.size
		CSV.foreach("除外企業_Rails（フロント・プロジェクト先・クライアント先）.csv") do |row|
			hash = {}
			hash["category"] = row[0]
			hash["company_name"] = row[1]
			hash["title"] = row[2]
			hash["url"] = row[3]
			exclusion_company_1 << hash
		end
		ap exclusion_company_1.size
		CSV.foreach("除外企業_Ruby（常駐・客先）.csv") do |row|
			hash = {}
			hash["category"] = row[0]
			hash["company_name"] = row[1]
			hash["title"] = row[2]
			hash["url"] = row[3]
			exclusion_company_2 << hash
		end
		ap exclusion_company_2.size
		CSV.foreach("除外企業_Rails（常駐・客先）.csv") do |row|
			hash = {}
			hash["category"] = row[0]
			hash["company_name"] = row[1]
			hash["title"] = row[2]
			hash["url"] = row[3]
			exclusion_company_2 << hash
		end
		ap exclusion_company_2.size
		CSV.foreach("除外企業_Ruby（SES）.csv") do |row|
			hash = {}
			hash["category"] = row[0]
			hash["company_name"] = row[1]
			hash["title"] = row[2]
			hash["url"] = row[3]
			exclusion_company_3 << hash
		end
		ap exclusion_company_3.size
		CSV.foreach("除外企業_Rails（SES）.csv") do |row|
			hash = {}
			hash["category"] = row[0]
			hash["company_name"] = row[1]
			hash["title"] = row[2]
			hash["url"] = row[3]
			exclusion_company_3 << hash
		end
		ap exclusion_company_3.size

		inclusion_company.uniq!
		exclusion_company_1.uniq!
		exclusion_company_2.uniq!
		exclusion_company_3.uniq!

		puts inclusion_company.size
		puts exclusion_company_1.size
		puts exclusion_company_2.size
		puts exclusion_company_3.size

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
	end
end