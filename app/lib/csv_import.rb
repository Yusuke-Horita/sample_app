class CsvImport
	require 'csv'
	def self.import
		inclusion_companys = []
		exclusion_companys_1 = []
		exclusion_companys_2 = []
		exclusion_companys_3 = []

		CSV.foreach("応募企業_Ruby.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			inclusion_companys << hash
		end
		ap inclusion_companys.size
		CSV.foreach("応募企業_Rails.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			inclusion_companys << hash
		end
		ap inclusion_companys.size
		CSV.foreach("除外企業_Ruby（フロント・プロジェクト先・クライアント先）.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			exclusion_companys_1 << hash
		end
		ap exclusion_companys_1.size
		CSV.foreach("除外企業_Rails（フロント・プロジェクト先・クライアント先）.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			exclusion_companys_1 << hash
		end
		ap exclusion_companys_1.size
		CSV.foreach("除外企業_Ruby（常駐・客先）.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			exclusion_companys_2 << hash
		end
		ap exclusion_companys_2.size
		CSV.foreach("除外企業_Rails（常駐・客先）.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			exclusion_companys_2 << hash
		end
		ap exclusion_companys_2.size
		CSV.foreach("除外企業_Ruby（SES）.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			exclusion_companys_3 << hash
		end
		ap exclusion_companys_3.size
		CSV.foreach("除外企業_Rails（SES）.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			exclusion_companys_3 << hash
		end
		ap exclusion_companys_3.size

		inclusion_companys.uniq!
		exclusion_companys_1.uniq!
		exclusion_companys_2.uniq!
		exclusion_companys_3.uniq!

		puts inclusion_companys.size
		puts exclusion_companys_1.size
		puts exclusion_companys_2.size
		puts exclusion_companys_3.size

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

		ap f_i.size
		ap f_e_1.size
		ap f_e_2.size
		ap f_e_3.size
		
		CSV.open('応募企業_RubyOnRails.csv', 'w') do |csv|
			csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
			f_i.each_with_index do |company, i|
				csv << [i + 1, company[:category], company[:company], company[:title], company[:url]]
			end
		end
		CSV.open('除外企業_RubyOnRails（フロント・プロジェクト先・クライアント先）.csv', 'w') do |csv|
			csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
			f_e_1.each_with_index do |company, i|
				csv << [i + 1, company[:category], company[:company], company[:title], company[:url]]
			end
		end
		CSV.open('除外企業_RubyOnRails（常駐・客先）.csv', 'w') do |csv|
			csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
			f_e_2.each_with_index do |company, i|
				csv << [i + 1, company[:category], company[:company], company[:title], company[:url]]
			end
		end
		CSV.open('除外企業_RubyOnRails（SES）.csv', 'w') do |csv|
			csv << ["", "ジャンル", "タイトル", "会社名", "URL"]
			f_e_3.each_with_index do |company, i|
				csv << [i + 1, company[:category], company[:company], company[:title], company[:url]]
			end
		end
	end

	def self.company_match
		inclusion_companys = []
		exclusion_companys_1 = []
		exclusion_companys_2 = []
		exclusion_companys_3 = []
		
		inclusion_companys_2 = []
		exclusion_companys_1_2 = []
		exclusion_companys_2_2 = []
		exclusion_companys_3_2 = []

		CSV.foreach("応募企業_RubyOnRails.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			inclusion_companys << hash
		end
		CSV.foreach("除外企業_RubyOnRails（フロント・プロジェクト先・クライアント先）.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			exclusion_companys_1 << hash
		end
		CSV.foreach("除外企業_RubyOnRails（常駐・客先）.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			exclusion_companys_2 << hash
		end
		CSV.foreach("除外企業_RubyOnRails（SES）.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			exclusion_companys_3 << hash
		end

		CSV.foreach("応募企業.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			inclusion_companys_2 << hash
		end
		CSV.foreach("除外企業（フロント・プロジェクト先・クライアント先）.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			exclusion_companys_1_2 << hash
		end
		CSV.foreach("除外企業（常駐・客先）.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			exclusion_companys_2_2 << hash
		end
		CSV.foreach("除外企業（SES）.csv") do |row|
			hash = {}
			hash[:category] = row[0]
			hash[:company] = row[1]
			hash[:title] = row[2]
			hash[:url] = row[3]
			exclusion_companys_3_2 << hash
		end

		ap inclusion_companys.size
		ap exclusion_companys_1.size
		ap exclusion_companys_2.size
		ap exclusion_companys_3.size

		match_1 = []
		match_2 = []
		match_3 = []
		match_4 = []
		
		inclusion_companys.each do |company|
			unless inclusion_companys_2.find{|i| i[:company] == company[:company]}
				match_1 << company[:company]
				# ap "[#{company[:company]}] #{company[:title]}"
				ap company[:company]
			end
		end
		puts "----- 応募企業 -----"
		exclusion_companys_1.each do |company|
			unless exclusion_companys_1_2.find{|i| i[:company] == company[:company]}
				match_2 << company[:company]
				# ap "[#{company[:company]}] #{company[:title]}"
				ap company[:company]
			end
		end
		puts "----- 除外企業-１ -----）"
		exclusion_companys_2.each do |company|
			unless exclusion_companys_2_2.find{|i| i[:company] == company[:company]}
				match_3 << company[:company]
				# ap "[#{company[:company]}] #{company[:title]}"
				ap company[:company]
			end
		end
		puts "----- 除外企業-２ -----"
		exclusion_companys_3.each do |company|
			unless exclusion_companys_3_2.find{|i| i[:company] == company[:company]}
				match_4 << company[:company]
				# ap "[#{company[:company]}] #{company[:title]}"
				ap company[:company]
			end
		end
		puts "----- 除外企業-３ -----"

		puts match_1.size
		puts match_2.size
		puts match_3.size
		puts match_4.size
	end
end