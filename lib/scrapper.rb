require 'bundler'
Bundler.require
require 'open-uri' 
require 'dotenv'

Dotenv.load('.env')



class Scapper
    attr_accessor :page
    @@pages_mairie =[]

    def initialize(url)
        @page = Nokogiri::HTML(URI.open(url))
        @@pages_mairie << self
    end

    def get_townhall_email
        city_name = @page.xpath('//main//h1').text.split(" ")
        hash_one_city = {city_name[0] => @page.xpath('/html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]').text}
    end

    def get_townhall_urls
        links_mairie = @page.xpath('//a[@class="lientxt"]')      
        links_mairie.each do |link|
            each_link_mairie ="https://annuaire-des-mairies.com" + link['href'].delete_prefix(".")
          Scapper.new(each_link_mairie)
        end
    end

    def perform
        result = []
        self.get_townhall_urls        
        @@pages_mairie.delete_at(0)
        @@pages_mairie.each do |page_mairie|
           result << page_mairie.get_townhall_email
        end
        return result
    end
end