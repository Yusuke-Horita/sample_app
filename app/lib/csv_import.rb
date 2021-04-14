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

		
	end
end