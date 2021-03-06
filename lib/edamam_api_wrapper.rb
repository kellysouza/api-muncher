require 'httparty'
require 'recipe'


class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.listRecipes(search_words, health = nil)
   url = BASE_URL + "?q=#{ search_words }" + "&app_id=#{ APP_ID }" + "&app_key=#{ APP_KEY }" + "&to=100"
   if health
     url = url + "&health=#{ health }"
   end
   response = HTTParty.get(url)
   @recipes = []

  if response["hits"]
   response["hits"].each do | hit |
     options = {
     label: hit["recipe"]["label"],
     image: hit["recipe"]["image"],
     uri: hit["recipe"]["uri"].split("_").last.to_s
     }
     @recipes << Recipe.new(options)
    end
  end
   return @recipes
  end

  # def self.sendMessage(channel_id, text, token = nil)
  #
  #   token ||= TOKEN
  #   # url = BASE_URL + "chat.postMessage?" + "token=#{ token }&" + "channel=#{channel_id}&" + "text=#{text}"
  #   # # raise
  #   # response = HTTParty.get(url)
  #   #
  #   # return response["ok"]
  #
  #   url = BASE_URL + "chat.postMessage?" + "token=#{token}"
  #   response = HTTParty.post(url,
  #     body: {
  #       "text" => "#{text}",
  #       "channel" => "#{channel_id}",
  #       "username" => "MonkeyBot",
  #       "icon_emoji" => ":monkey:",
  #       "as_user" => "false"
  #     },
  #     headers: {'Content-Type' => 'application/x-www-form-urlencoded'}
  #     )
  #   return response["ok"]
  # end
  #
  def self.getRecipe(uri)
    url = "https://api.edamam.com/search?r=http://www.edamam.com/ontologies/edamam.owl_" + uri
    response = HTTParty.get(url)
    if response[0] != nil
      options = {
        label: response[0]["label"],
        image:  response[0]["image"],
        url:  response[0]["url"],
        ingredientlines: response[0]["ingredientLines"],
        totalnutrients: response[0]["totalNutrients"]
      }
      return Recipe.new(options)
    else
      return nil
    end
  end


end
