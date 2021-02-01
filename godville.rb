require 'open-uri'
require 'json'

class Godville
  def initialize(name)
    @hash = JSON.parse(open(URI.escape("http://www.godville.net/gods/api/#{name}")).read)
    #придумать, как сделать, чтобы бот не вылетал, когда пользователь вводит несуществующее имя
  end

  def parse
    "Герой - #{@hash['name']}
    Бог - #{@hash['godname']}
    Гильдия - #{@hash['clan']}
    Звание в гильдии - #{@hash['clan_position']}
    Уровень - #{@hash['level']}
    Мировоззрение - #{@hash['alignment']}
    Дата окончания строительства храма - #{@hash['temple_completed_at']}"
  end
end
