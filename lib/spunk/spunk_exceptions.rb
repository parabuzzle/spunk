class SpunkException < Exception
  
  class OriginException < SpunkException
  end
  
  class BotException < SpunkException
  end
  
end