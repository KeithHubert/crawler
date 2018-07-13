require 'mechanize'

puts "Enter Card Name"
puts "===================="
card_name = gets.strip
puts "===================="
formatted_card_name = card_name.gsub!(" ", "+")

agent = Mechanize.new
page = agent.get("http://www.capefeargames.com/buylist/search?q=" + "#{formatted_card_name}")
page.search('#main-content .products-container .meta').each do |a|
    card = a.search("h4 a").text
    set = a.search(".cat-name").text
    buylist = a.search(".regular.price")[0].text.gsub(/\s+/, '')
    store_credit = a.search(".store-credit.hide-for-medium-down").text
    
    buylist_parsed = buylist.rpartition("/")[0]
    store_credit_parsed = buylist.rpartition("/")[2]
    
    puts ""
    puts card + " (#{set})"
    puts "Buylist #{buylist_parsed}"
    puts "Store Credit: #{store_credit_parsed}"
end