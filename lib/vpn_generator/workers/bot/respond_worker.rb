module Bot
  class RespondWorker
    include Sidekiq::Worker

    def perform(args)
      Interactors::Bot::Respond.new.call(args)
    end
  end
end
