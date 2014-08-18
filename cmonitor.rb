require 'json'
require 'open-uri'

@apiUrl = 'https://www.coinotron.com/coinotron/AccountServlet?action=api&api_key='
@apiKey = ''

	# Request for input of API key
	def getKey
		print 'Enter Coinotron API key: '
		validateKey(gets.chomp)
	end

	# Validate length of given API key
	def validateKey(key)
		if key.size === 32
			@apiKey = key
		else
			puts 'Error! Invalid API key: must be 32 characters long.'
			getKey
		end
	end

	# Send request to API, print results to screen
	def getApi(url, key)
		finalApiUrl = url + key
		api = JSON.parse(open(finalApiUrl).read)

		if api['username'] != 'null'
			api['workers'].each do |k,w|
				puts "\t#{Time.now.strftime('%Y.%m.%d. %H:%M:%S')}\t#{w['username']}\tHashrate: #{w['hashrate']}"
			end
		end

	end


getKey

while true
	getApi(@apiUrl, @apiKey)
	sleep(600)
end