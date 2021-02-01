
require 'telegram/bot'
require_relative 'godville.rb'
require_relative 'token.rb'
require_relative 'jokes.rb'

tg_token = Token.new
token = tg_token.token

Telegram::Bot::Client.run(token) do |bot|
  kb = [
    Telegram::Bot::Types::KeyboardButton.new(text: 'Справка о токенах в Godville'),
    Telegram::Bot::Types::KeyboardButton.new(text: 'Посмотреть информацию о герое'),
    Telegram::Bot::Types::KeyboardButton.new(text: 'Шутка')
  ]
  markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)

  bot.listen do |message|
    bot.api.send_message(
      chat_id: message.chat.id,
      text: "#{message.text}",
      reply_markup: markup)
    case message.text
      when 'Справка о токенах в Godville'
        bot.api.send_message(
          chat_id: message.chat.id,
          text: "Герой ищет себя...")
      when 'Посмотреть информацию о герое'
        bot.api.send_message(
          chat_id: message.chat.id,
          text: "Введите имя бога")
        bot.listen do |name|
          god = name.text
          if god == 'Шутка'
            bot.api.send_message(
              chat_id: message.chat.id,
              text: "Анекдот про нюанс")
          elsif god == 'Справка о токенах в Godville'
            bot.api.send_message(
              chat_id: message.chat.id,
              text: "Это неправильные пчёлы...")
          else
            @data = Godville.new(god).parse
            bot.api.send_message(
              chat_id: name.chat.id,
              text: "#{@data}")
          end
        end
      when 'Шутка'
        joke = Joke.new

        bot.api.send_message(
          chat_id: message.chat.id,
          text: joke.select_random)
      else
        bot.api.send_message(
          chat_id: message.chat.id,
          text: "Сбой в матрице")
    end
  end
end
